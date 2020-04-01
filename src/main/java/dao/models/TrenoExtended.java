package dao.models;

public class TrenoExtended {

    private String numeroTreno;
    private String stazionePartenza;
    private String stazioneArrivo;
    private String arrivoPrevisto;
    private String stato;
    private String ritardo; //???
    private String binario;

    public TrenoExtended() {
    }

    public TrenoExtended(String numeroTreno, String stazionePartenza, String stazioneArrivo, String arrivoPrevisto, String stato, String ritardo, String binario) {
        this.numeroTreno = numeroTreno;
        this.stazionePartenza = stazionePartenza;
        this.stazioneArrivo = stazioneArrivo;
        this.arrivoPrevisto = arrivoPrevisto;
        this.stato = stato;
        this.ritardo = ritardo;
        this.binario = binario;
    }

    public String getNumeroTreno() {
        return numeroTreno;
    }

    public void setNumeroTreno(String numeroTreno) {
        this.numeroTreno = numeroTreno;
    }

    public String getStazionePartenza() {
        return stazionePartenza;
    }

    public void setStazionePartenza(String stazionePartenza) {
        this.stazionePartenza = stazionePartenza;
    }

    public String getStazioneArrivo() { return stazioneArrivo; }

    public void setStazioneArrivo(String stazioneArrivo) { this.stazioneArrivo = stazioneArrivo; }

    public String getArrivoPrevisto() {
        return arrivoPrevisto;
    }

    public void setArrivoPrevisto(String arrivoPrevisto) {
        this.arrivoPrevisto = arrivoPrevisto;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    public String getRitardo() {
        return ritardo;
    }

    public void setRitardo(String ritardo) {
        this.ritardo = ritardo;
    }

    public String getBinario() {
        return binario;
    }

    public void setBinario(String binario) {
        this.binario = binario;
    }
}
