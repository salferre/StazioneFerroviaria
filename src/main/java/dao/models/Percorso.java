package dao.models;

public class Percorso {

    private String idPercorso;
    private String idTratta;
    private String idStazione;
    private String progressivo;
    private String durata;

    public Percorso() {
    }

    public Percorso(String idPercorso, String idTratta, String idStazione, String progressivo, String durata) {
        this.idPercorso = idPercorso;
        this.idTratta = idTratta;
        this.idStazione = idStazione;
        this.progressivo = progressivo;
        this.durata = durata;
    }

    public String getIdPercorso() {
        return idPercorso;
    }

    public void setIdPercorso(String idPercorso) {
        this.idPercorso = idPercorso;
    }

    public String getIdTratta() {
        return idTratta;
    }

    public void setIdTratta(String idTratta) {
        this.idTratta = idTratta;
    }

    public String getIdStazione() {
        return idStazione;
    }

    public void setIdStazione(String idStazione) {
        this.idStazione = idStazione;
    }

    public String getProgressivo() {
        return progressivo;
    }

    public void setProgressivo(String progressivo) {
        this.progressivo = progressivo;
    }

    public String getDurata() {
        return durata;
    }

    public void setDurata(String durata) {
        this.durata = durata;
    }
}
