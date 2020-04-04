package controller;

import dao.models.*;
import dao.repositories.TrenoRepository;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class TrenoController implements AbstractController {

    public TrenoController() {
    }

    public static TrenoForm getTreno (String numeroTreno) {

        if(numeroTreno == null || numeroTreno.equalsIgnoreCase("")){
            return null;
        }

        TrenoForm treno = new TrenoForm();
        try{
            Class.forName(DRIVER).newInstance();
            Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            Integer idTreno = TrenoController.getIdTrenoFromCodiceTreno(connection, numeroTreno);
            Calendario calendario = CalendarioController.getCalendarioFromidTreno(connection, idTreno.toString());
            List<Percorso> percorsi = PercorsoController.getPercorsoFromidTratta(connection, calendario.getIdTratta());

            List<String> tappe = new ArrayList<>();
            for ( Percorso p : percorsi ) {
                tappe.add(StazioneController.getNomeStazioneFromidStazione(connection, p.getIdStazione()));
            }

            String nomeTratta = TrattaController.getNomeTrattaFromIdTratta(connection, calendario.getIdTratta());
            String stazioneArrivo = nomeTratta.split("_")[1];
            stazioneArrivo = StazioneController.getNomeStazioneFromProvinciaStazione(connection, stazioneArrivo);
            tappe.add(stazioneArrivo);

            treno.setNumeroTreno(numeroTreno);
            treno.setTappe(tappe);

            final String OLD_FORMAT = "yyyy/MM/dd";
            final String NEW_FORMAT = "dd/MM/yyyy";
            String giornoPartenza = calendario.getDataPartenza();
            giornoPartenza = giornoPartenza.split(" ")[0].replace("-","/");
            SimpleDateFormat dateFormat = new SimpleDateFormat(OLD_FORMAT);
            Date parsedDate = dateFormat.parse(giornoPartenza);
            dateFormat.applyPattern(NEW_FORMAT);
            giornoPartenza = dateFormat.format(parsedDate);
            treno.setGiornoPartenza(giornoPartenza);

            String oraPartenza = calendario.getDataPartenza().split(" ")[1].substring(0, 5);
            treno.setOraPartenza(oraPartenza);

            treno.setBinario(calendario.getBinario());

        } catch (Exception ex){
            ex.printStackTrace();
        }

        return treno;
    }

    public static List<TrenoExtended> getArriviOrPartenzePA(String arrivoOrPartenza) {
        List<TrenoExtended> treni = new ArrayList<>();
        List<Tratta> tratte = new ArrayList<>();
        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            PreparedStatement statement = connection.prepareStatement(arrivoOrPartenza);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Tratta tratta = new Tratta( rs.getInt("idTratta") ,rs.getString("nomeTratta"));
                tratte.add(tratta);
            }

            List<Integer> idTreni = new ArrayList<>();
            for (Tratta t : tratte) {
                idTreni.add(CalendarioController.getIdTrenoFromIdTratta(connection, t.getIdTratta().toString()));
            }

            treni = buildListTrenoExtended(connection, idTreni);

            rs.close();
            statement.close();
            connection.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return treni;
    }

    public static List<TrenoExtended> buildListTrenoExtended (Connection connection, List<Integer> idTreni) throws ParseException {
        List<TrenoExtended> treni = new ArrayList<>();
        for (Integer idTreno : idTreni) {
            TrenoExtended treno = new TrenoExtended();
            Treno trenoDB = TrenoController.getTrenoFromIdTreno(connection, idTreno.toString());
            treno.setNumeroTreno(trenoDB.getCodiceTreno()); //1
            Calendario calendario = CalendarioController.getCalendarioFromidTreno(connection, idTreno.toString());
            String idTratta = calendario.getIdTratta();
            String nomeTratta = TrattaController.getNomeTrattaFromIdTratta(connection, idTratta);
            treno.setStazionePartenza(StazioneController.getNomeStazioneFromProvinciaStazione(connection, nomeTratta.split("_")[0])); //2
            treno.setStazioneArrivo(StazioneController.getNomeStazioneFromProvinciaStazione(connection, nomeTratta.split("_")[1])); //3

            String oraPartenza = calendario.getDataPartenza().split(" ")[1].substring(0, 6);
            SimpleDateFormat df = new SimpleDateFormat("HH:mm");
            Date d = df.parse(oraPartenza);
            Calendar cal = Calendar.getInstance();
            cal.setTime(d);
            cal.add(Calendar.MINUTE, PercorsoController.getDurataViaggio(connection, idTratta));
            treno.setArrivoPrevisto(df.format(cal.getTime())); //4

            treno.setStato(trenoDB.getStatoTreno()); //5
            treno.setBinario(calendario.getBinario()); //6
            treni.add(treno);
        }
        return treni;
    }

    public static Boolean insertTreno(String numeroTreno, String tratta, List<String> tappe, String giornoPartenza, String oraPartenza,
                                      String binario) {

        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String SQL_INSERT_TRENO = "INSERT INTO Treno (codiceTreno, statoTreno) VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(SQL_INSERT_TRENO);
            statement.setString(1, numeroTreno);
            statement.setString(2, "C"); //CONFERMATO
            statement.executeUpdate();

            String SQL_INSERT_TRATTA = "INSERT INTO Tratta (nomeTratta) VALUES (?)";
            statement = connection.prepareStatement(SQL_INSERT_TRATTA);
            statement.setString(1, tratta);
            statement.executeUpdate();

            String SQL_INSERT_CALENDARIO = "INSERT INTO Calendario (idTratta, dataPartenza, idTreno, Binario) VALUES (?,?,?,?)";
            statement = connection.prepareStatement(SQL_INSERT_CALENDARIO);
            Integer idTratta = TrattaController.getIdTrattaFromNomeTratta(connection, tratta);
            statement.setInt(1, idTratta);
            statement.setTimestamp(2, buildMySQLDateTime(giornoPartenza, oraPartenza) );
            statement.setInt(3, getIdTrenoFromCodiceTreno(connection, numeroTreno));
            statement.setInt(4, Integer.valueOf(binario));
            statement.executeUpdate();

            int numProgessivoTappa = 1;
            for (String tappa : tappe ) {
                //controllo che non sia la stazione di arrivo
                if(!tappa.equalsIgnoreCase(tappe.get(tappe.size() - 1))){

                    String trattaIntermedia = tappa.substring(0, 2).toUpperCase() + "_"
                            + tappe.get(numProgessivoTappa).substring(0, 2).toUpperCase();


                    String SQL_INSERT_PERCORSO = "INSERT INTO Percorso (idTratta, idStazione, Progressivo, durata) VALUES (?,?,?,?)";
                    statement = connection.prepareStatement(SQL_INSERT_PERCORSO);
                    statement.setInt(1, idTratta);
                    statement.setInt(2, StazioneController.getIdStazione(connection, tappa));
                    statement.setInt(3, numProgessivoTappa);
                    statement.setInt(4, DurataController.getDurata(connection, trattaIntermedia));
                    statement.executeUpdate();
                    numProgessivoTappa++;
                }
            }

            statement.close();
            connection.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static Boolean deleteTreno (String codiceTreno) throws ClassNotFoundException {

        if(codiceTreno == null || codiceTreno.trim().equalsIgnoreCase(""))
            return false;

        Boolean result = false;
        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            Treno treno = getTrenoFromCodiceTreno(connection, "16");
            if (treno.getStatoTreno().equalsIgnoreCase("C")) {
                Calendario calendario = CalendarioController.getCalendarioFromidTreno(connection, treno.getIdTreno().toString());
                String oraPartenza = calendario.getDataPartenza();
                String oraArrivo = oraPartenza;
                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                Date d = df.parse(oraArrivo);
                Calendar cal = Calendar.getInstance();
                cal.setTime(d);
                cal.add(Calendar.MINUTE, PercorsoController.getDurataViaggio(connection, calendario.getIdTratta()));
                oraArrivo = df.format(cal.getTime());

                Date partenza = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(oraPartenza);
                Date arrivo = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(oraArrivo);
                Date now = new Date();

                if(now.after(partenza) && now.before(arrivo))
                    return false;
            }
            String SQL_DELETE_TRENO = "UPDATE Treno SET statoTreno=? where codiceTreno=?";
            PreparedStatement statement = connection.prepareStatement(SQL_DELETE_TRENO);
            statement.setString(1, "D"); //DELETED
            statement.setString(2, codiceTreno);
            statement.executeUpdate();
            statement.close();
            connection.close();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
            result = false;
        }
        return result;
    }

    public static Boolean updateTreno (String numeroTreno, String giornoPartenza, String oraPartenza, String binario) throws ClassNotFoundException {
        Boolean result = false;
        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            String SQL_UPDATE_TRENO = "UPDATE Calendario SET dataPartenza=?, binario=? where idTreno=?";
            PreparedStatement statement = connection.prepareStatement(SQL_UPDATE_TRENO);
            statement.setTimestamp(1, buildMySQLDateTime(giornoPartenza, oraPartenza));
            statement.setString(2, binario);
            statement.setInt(2, getIdTrenoFromCodiceTreno(connection, numeroTreno));
            statement.executeUpdate();
            statement.close();
            connection.close();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static Integer getIdTrenoFromCodiceTreno(Connection connection, String codiceTreno) {
        Integer idTreno = 0;

        try{
            if (connection == null) {
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrenoRepository.GET_IDTRENO_FROM_CODICETRENO);
            statement.setString(1, codiceTreno);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                idTreno = rs.getInt("idTreno");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return idTreno;
    }

    public static Treno getTrenoFromIdTreno(Connection connection, String idTreno) {
        Treno treno = null;
        try{
            if (connection == null) {
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrenoRepository.GET_TRENO_FROM_IDTRENO);
            statement.setString(1, idTreno);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                treno = new Treno();
                treno.setIdTreno(rs.getInt("idTreno"));
                treno.setCodiceTreno(rs.getString("codiceTreno"));
                treno.setStatoTreno(rs.getString("statoTreno"));
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return treno;
    }

    public static Treno getTrenoFromCodiceTreno(Connection connection, String codiceTreno) {
        Treno treno = null;
        try{
            if (connection == null) {
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrenoRepository.GET_TRENO_FROM_CODICETRENO);
            statement.setString(1, codiceTreno);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                treno = new Treno();
                treno.setIdTreno(rs.getInt("idTreno"));
                treno.setCodiceTreno(rs.getString("codiceTreno"));
                treno.setStatoTreno(rs.getString("statoTreno"));
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return treno;
    }

    public static String getCodiceTrenoFromIdTreno(Connection connection, String idTreno) {
        String codiceTreno = "";

        try{
            if (connection == null) {
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrenoRepository.GET_CODICETRENO_FROM_IDTRENO);
            statement.setString(1, idTreno);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                codiceTreno = rs.getString("codiceTreno");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return codiceTreno;
    }

    public static List<Treno> getAllTreni(Connection connection) {
        List<Treno> treni = new ArrayList<>();
        try{
            if (connection == null) {
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
            }
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrenoRepository.GET_ALL_TRENI);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Treno treno = new Treno();
                treno.setIdTreno(rs.getInt("idTreno"));
                treno.setCodiceTreno(rs.getString("codiceTreno"));
                treno.setStatoTreno(rs.getString("statoTreno"));
                treni.add(treno);
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return treni;
    }

    private static Timestamp buildMySQLDateTime(String data, String orario) throws ParseException {

        final String OLD_FORMAT = "dd/MM/yyyy";
        final String NEW_FORMAT = "yyyy/MM/dd";

        String oldDateString = data;
        String newDateString;

        SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
        Date d = sdf.parse(oldDateString);
        sdf.applyPattern(NEW_FORMAT);
        newDateString = sdf.format(d);

        newDateString = newDateString.replace("/", "-");

        orario = orario.concat(":00");
        return Timestamp.valueOf(newDateString + " " + orario);
    }

}
