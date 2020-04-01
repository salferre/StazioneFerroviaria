package dao.models;

import java.util.List;

public class TrenoForm {

    private String numeroTreno;
    private List<String> tappe;
    private String giornoPartenza;
    private String oraPartenza;
    private String binario;

    public TrenoForm() {
    }

    public TrenoForm(String numeroTreno, List<String> tappe, String giornoPartenza, String oraPartenza, String binario) {
        this.numeroTreno = numeroTreno;
        this.tappe = tappe;
        this.giornoPartenza = giornoPartenza;
        this.oraPartenza = oraPartenza;
        this.binario = binario;
    }

    public String getNumeroTreno() {
        return numeroTreno;
    }

    public void setNumeroTreno(String numeroTreno) {
        this.numeroTreno = numeroTreno;
    }

    public List<String> getTappe() {
        return tappe;
    }

    public void setTappe(List<String> tappe) {
        this.tappe = tappe;
    }

    public String getGiornoPartenza() {
        return giornoPartenza;
    }

    public void setGiornoPartenza(String giornoPartenza) {
        this.giornoPartenza = giornoPartenza;
    }

    public String getOraPartenza() {
        return oraPartenza;
    }

    public void setOraPartenza(String oraPartenza) {
        this.oraPartenza = oraPartenza;
    }

    public String getBinario() {
        return binario;
    }

    public void setBinario(String binario) {
        this.binario = binario;
    }
}
