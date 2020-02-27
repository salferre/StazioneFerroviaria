package controller;

import dao.models.Calendario;
import dao.models.Treno;
import dao.repositories.DurataRepository;
import dao.repositories.StazioneRepository;
import dao.repositories.TrattaRepository;
import dao.repositories.TrenoRepository;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class TrenoController implements AbstractController {

    public TrenoController() {
    }

    public static Treno getTreno (String numeroTreno){

        Treno treno = new Treno();
        try{
            Class.forName(DRIVER).newInstance();
            Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            Integer idTreno = getIdTreno(connection, numeroTreno);
            Calendario calendario = CalendarioController.getCalendarioFromidTreno(connection, idTreno.toString());

        } catch (Exception ex){
            ex.printStackTrace();
        }

        return treno;
    }

    public static Boolean insertTreno(String numeroTreno, String tratta, List<String> tappe, String giornoPartenza, String oraPartenza,
                                      String binario) {

        try{
            Class.forName(DRIVER).newInstance();
            Connection connection= DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            String SQL_INSERT_TRENO = "INSERT INTO Treno (codiceTreno) VALUES (?)";
            PreparedStatement statement = connection.prepareStatement(SQL_INSERT_TRENO);
            statement.setString(1, numeroTreno);
            statement.executeUpdate();

            String SQL_INSERT_TRATTA = "INSERT INTO Tratta (nomeTratta) VALUES (?)";
            statement = connection.prepareStatement(SQL_INSERT_TRATTA);
            statement.setString(1, tratta);
            statement.executeUpdate();

            String SQL_INSERT_CALENDARIO = "INSERT INTO Calendario (idTratta, dataPartenza, idTreno, Binario) VALUES (?,?,?,?)";
            statement = connection.prepareStatement(SQL_INSERT_CALENDARIO);
            Integer idTratta = getIdTratta(connection, tratta);
            statement.setInt(1, idTratta);
            statement.setTimestamp(2, buildMySQLDateTime(giornoPartenza, oraPartenza) );
            statement.setInt(3, getIdTreno(connection, numeroTreno));
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
                    statement.setInt(2, getIdStazione(connection, tappa));
                    statement.setInt(3, numProgessivoTappa);
                    statement.setInt(4, getDurata(connection, trattaIntermedia));
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

    private static Integer getIdTreno(Connection connection, String codiceTreno) {
        Integer idTreno = 0;
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrenoRepository.GET_ID_TRENO);
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

    private static Integer getIdTratta(Connection connection, String tratta) {
        Integer idTratta = 0;
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(TrattaRepository.GET_ID_TRATTA);
            statement.setString(1, tratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                idTratta = rs.getInt("idTratta");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return idTratta;
    }

    private static Integer getIdStazione(Connection connection, String nomeStazione) {
        Integer idStazione = 0;
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(StazioneRepository.GET_ID_STAZIONE);
            statement.setString(1, nomeStazione);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                idStazione = rs.getInt("idStazione");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return idStazione;
    }

    private static Integer getDurata(Connection connection, String nomeTratta) {
        Integer duarata = 0;
        try{
            Class.forName(DRIVER).newInstance();
            PreparedStatement statement = connection.prepareStatement(DurataRepository.GET_DURATA);
            statement.setString(1, nomeTratta);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                duarata = rs.getInt("durata");
            }
            rs.close();
            statement.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return duarata;
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
