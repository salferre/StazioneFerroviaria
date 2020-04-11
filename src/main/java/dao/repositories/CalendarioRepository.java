package dao.repositories;

public interface CalendarioRepository {

    public static final String GET_CALENDARIO_FROM_IDTRENO = "SELECT * FROM Calendario c WHERE c.idTreno = ?";

    public static final String GET_IDTRENO_FROM_IDTRATTA = "SELECT c.idTreno FROM Calendario c WHERE c.idTratta = ?";

    public static final String GET_IDTRENO_FROM_BINARIO = "SELECT c.idTreno FROM Calendario c WHERE c.binario = ? AND c.dataPartenza > ?";

}
