package dao.repositories;

public interface TrattaRepository {

    public static final String GET_ID_TRATTA = "SELECT idTratta FROM Tratta t WHERE t.nomeTratta = ?";

    public static final String GET_NOME_TRATTA = "SELECT nomeTratta FROM Tratta t WHERE t.idTratta = ?";

    public static final String GET_PARTENZE_PA = "SELECT * FROM Tratta t WHERE t.nometratta LIKE 'PA_%' ORDER BY idTratta";

    public static final String GET_ARRIVI_PA = "SELECT * FROM Tratta t WHERE t.nometratta LIKE '%_PA' ORDER BY idTratta";

}
