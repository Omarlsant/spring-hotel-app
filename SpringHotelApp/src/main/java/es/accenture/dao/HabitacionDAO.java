package es.accenture.dao;

import java.util.List;

import es.accenture.entidades.Habitacion;

public interface HabitacionDAO {
	
    List<Habitacion> findAll();

    Habitacion findById(int id);

    void save(Habitacion habitacion);

    void update(Habitacion habitacion);

    void delete(int id);

}
