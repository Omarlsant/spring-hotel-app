package es.accenture.servicios;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import es.accenture.dao.ReservaDAO;
import es.accenture.entidades.Reserva;
import es.accenture.excepciones.ReservaNoEncontradaException;

@Service
@Transactional
public class ReservaServiceImpl implements IReservaService {

    @Autowired
    private ReservaDAO reservaDAO;

    @Override
    public List<Reserva> obtenerTodos() {
        return reservaDAO.findAll();
    }

    @Override
    public Reserva obtenerPorId(long id) {
        return reservaDAO.findById(id);
    }

    @Override
    public void alta(Reserva reserva) {
        validar(reserva);
        reservaDAO.save(reserva);
    }

    @Override
    public void modificar(Reserva reserva) {
        if (reserva == null || reserva.getId() == null) {
            throw new ReservaNoEncontradaException("La reserva que se desea modificar no existe.");
        }
        validar(reserva);
        reservaDAO.update(reserva);
    }

    @Override
    public void eliminar(long id) {
        reservaDAO.delete(id);
    }

    private void validar(Reserva reserva) {
        if (reserva == null || reserva.getHuesped() == null
                || reserva.getHuesped().getId() == null
                || reserva.getHabitacion() == null
                || reserva.getHabitacion().getId() == null
                || reserva.getFechaEntrada() == null
                || reserva.getFechaSalida() == null) {
            throw new IllegalArgumentException(
                    "Huesped, habitacion y fechas son obligatorios.");
        }
        if (!reserva.getFechaSalida().isAfter(reserva.getFechaEntrada())) {
            throw new IllegalArgumentException(
                    "La fecha de salida debe ser posterior a la fecha de entrada.");
        }
        if (reservaDAO.existsOverlap(reserva.getHabitacion().getId(),
                reserva.getFechaEntrada(), reserva.getFechaSalida(), reserva.getId())) {
            throw new IllegalArgumentException(
                    "La habitacion ya tiene una reserva para esas fechas.");
        }
    }
}
