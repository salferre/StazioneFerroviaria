package dao.models;

public class Tratta {

    private Integer idTratta;
    private String nomeTratta;

    public Tratta() {
    }

    public Tratta(Integer idTratta, String nomeTratta) {
        this.idTratta = idTratta;
        this.nomeTratta = nomeTratta;
    }

    public Integer getIdTratta() {
        return idTratta;
    }

    public void setIdTratta(Integer idTratta) {
        this.idTratta = idTratta;
    }

    public String getNomeTratta() {
        return nomeTratta;
    }

    public void setNomeTratta(String nomeTratta) {
        this.nomeTratta = nomeTratta;
    }

    @Override
    public String toString() {
        return "Tratta{" +
                "idTratta=" + idTratta +
                ", nomeTratta='" + nomeTratta + '\'' +
                '}';
    }
}
