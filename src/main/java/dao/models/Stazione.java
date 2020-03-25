package dao.models;

public class Stazione {

    private Integer idStazione;
    private String nomeStazione;
    private String provinciaStazione;

    public Stazione() {
    }

    public Stazione(Integer idStazione, String nomeStazione, String provinciaStazione) {
        this.idStazione = idStazione;
        this.nomeStazione = nomeStazione;
        this.provinciaStazione = provinciaStazione;
    }

    public String getNomeStazione() {
        return nomeStazione;
    }

    public void setNomeStazione(String nomeStazione) {
        this.nomeStazione = nomeStazione;
    }

    public Integer getIdStazione() { return idStazione; }

    public void setIdStazione(Integer idStazione) { this.idStazione = idStazione; }

    public String getProvinciaStazione() { return provinciaStazione; }

    public void setProvinciaStazione(String provinciaStazione) { this.provinciaStazione = provinciaStazione; }

    @Override
    public String toString() {
        return "Stazione{" +
                "idStazione=" + idStazione +
                ", nomeStazione='" + nomeStazione + '\'' +
                ", provinciaStazione='" + provinciaStazione + '\'' +
                '}';
    }
}
