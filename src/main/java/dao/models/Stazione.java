package dao.models;

public class Stazione {

    private String nomeStazione;

    public Stazione() {
    }

    public Stazione(String nomeStazione) {
        this.nomeStazione = nomeStazione;
    }

    public String getNomeStazione() {
        return nomeStazione;
    }

    public void setNomeStazione(String nomeStazione) {
        this.nomeStazione = nomeStazione;
    }
}
