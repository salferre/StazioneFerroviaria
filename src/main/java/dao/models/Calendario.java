package dao.models;

public class Calendario {

    private String idCalendario;
    private String idTratta;
    private String dataPartenza;
    private String idTreno;
    private String binario;

    public Calendario() {
    }

    public Calendario(String idCalendario, String idTratta, String dataPartenza, String idTreno, String binario) {
        this.idCalendario = idCalendario;
        this.idTratta = idTratta;
        this.dataPartenza = dataPartenza;
        this.idTreno = idTreno;
        this.binario = binario;
    }

    public String getIdCalendario() {
        return idCalendario;
    }

    public void setIdCalendario(String idCalendario) {
        this.idCalendario = idCalendario;
    }

    public String getIdTratta() {
        return idTratta;
    }

    public void setIdTratta(String idTratta) {
        this.idTratta = idTratta;
    }

    public String getDataPartenza() {
        return dataPartenza;
    }

    public void setDataPartenza(String dataPartenza) {
        this.dataPartenza = dataPartenza;
    }

    public String getIdTreno() {
        return idTreno;
    }

    public void setIdTreno(String idTreno) {
        this.idTreno = idTreno;
    }

    public String getBinario() {
        return binario;
    }

    public void setBinario(String binario) {
        this.binario = binario;
    }
}
