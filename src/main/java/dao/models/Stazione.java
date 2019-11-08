package dao.models;

public class Stazione {

    private Integer idStazione;
    private String nomeStazione;

    public Stazione() {
    }

    public Stazione(Integer idStazione, String nomeStazione) {
        this.idStazione = idStazione;
        this.nomeStazione = nomeStazione;
    }

    public String getNomeStazione() {
        return nomeStazione;
    }

    public void setNomeStazione(String nomeStazione) {
        this.nomeStazione = nomeStazione;
    }

    public Integer getIdStazione() { return idStazione; }

    public void setIdStazione(Integer idStazione) { this.idStazione = idStazione; }

    @Override
    public String toString() {
        return "Stazione{" +
                "idStazione=" + idStazione +
                ", nomeStazione='" + nomeStazione + '\'' +
                '}';
    }

}
