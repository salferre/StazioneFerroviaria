package dao.repositories;

public interface CalendarioRepository {

    public static final String GET_CALENDARIO_FROM_IDTRENO = "SELECT * FROM Calendario c WHERE c.idTreno = ?";

}
