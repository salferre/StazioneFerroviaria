package dao.repositories;

public interface TrenoRepository {

    public static final String GET_ID_TRENO = "SELECT idTreno FROM Treno t WHERE t.codiceTreno = ?";

}
