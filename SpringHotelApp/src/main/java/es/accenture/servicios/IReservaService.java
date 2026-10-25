package es.accenture.servicios;

import java.util.List;

import es.accenture.entidades.Reserva;

public interface IReservaService {

    List<Reserva> obtenerTodos();

    Reserva obtenerPorId(long id);

    void alta(Reserva reserva);

    void modificar(Reserva reserva);

    void eliminar(long id);
}
