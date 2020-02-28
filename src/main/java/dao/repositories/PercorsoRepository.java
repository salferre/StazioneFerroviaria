package dao.repositories;

public interface PercorsoRepository {

    public static final String GET_PERCORSO_FROM_IDTRATTA = "SELECT * FROM Percorso p WHERE p.idTratta = ? ORDER BY p.Progressivo";

}
