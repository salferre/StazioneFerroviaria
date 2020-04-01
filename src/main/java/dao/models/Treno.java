package dao.models;

public class Treno {

    private Integer idTreno;
    private String codiceTreno;
    private String statoTreno;

    public Treno() {
    }

    public Treno(Integer idTreno, String codiceTreno, String statoTreno) {
        this.idTreno = idTreno;
        this.codiceTreno = codiceTreno;
        this.statoTreno = statoTreno;
    }

    public Integer getIdTreno() {
        return idTreno;
    }

    public void setIdTreno(Integer idTreno) {
        this.idTreno = idTreno;
    }

    public String getCodiceTreno() {
        return codiceTreno;
    }

    public void setCodiceTreno(String codiceTreno) {
        this.codiceTreno = codiceTreno;
    }

    public String getStatoTreno() {
        return statoTreno;
    }

    public void setStatoTreno(String statoTreno) {
        this.statoTreno = statoTreno;
    }
}
