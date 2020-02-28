package dao.repositories;

public interface StazioneRepository {

    public static final String GET_ALL_STAZIONI = "SELECT * FROM Stazione ORDER BY idStazione";

    public static final String GET_ID_STAZIONE = "SELECT idStazione FROM Stazione t WHERE t.nomeStazione = ?";

    public static final String GET_NOME_STAZIONE = "SELECT nomeStazione FROM Stazione t WHERE t.idStazione = ?";

}
