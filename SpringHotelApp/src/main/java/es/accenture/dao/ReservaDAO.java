package es.accenture.dao;

import java.time.LocalDate;
import java.util.List;

import es.accenture.entidades.Reserva;

public interface ReservaDAO {

    List<Reserva> findAll();

    Reserva findById(long id);

    void save(Reserva reserva);

    void update(Reserva reserva);

    void delete(long id);

    boolean existsOverlap(long habitacionId, LocalDate fechaEntrada, LocalDate fechaSalida, Long reservaId);
}
