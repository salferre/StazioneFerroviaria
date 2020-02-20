package dao.repositories;

public interface TrattaRepository {

    public static final String GET_ID_TRATTA = "SELECT idTratta FROM Tratta t WHERE t.nomeTratta = ?";

}
