package dao.repositories;

public interface DurataRepository {

    public static final String GET_DURATA = "SELECT durata FROM Durata t WHERE t.nomeTratta = ?";

}
