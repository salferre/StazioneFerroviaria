package dao.repositories;

public interface TrenoRepository {

    public static final String GET_TRENO_FROM_IDTRENO = "SELECT * FROM Treno t WHERE t.idTreno = ?";

    public static final String GET_TRENO_FROM_CODICETRENO = "SELECT * FROM Treno t WHERE t.codiceTreno = ?";

    public static final String GET_IDTRENO_FROM_CODICETRENO = "SELECT idTreno FROM Treno t WHERE t.codiceTreno = ?";

    public static final String GET_CODICETRENO_FROM_IDTRENO = "SELECT codiceTreno FROM Treno t WHERE t.idTreno = ?";

    public static final String GET_ALL_TRENI = "SELECT * FROM Treno t";

}
