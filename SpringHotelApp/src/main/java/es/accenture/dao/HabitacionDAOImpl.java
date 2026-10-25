package es.accenture.dao;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import es.accenture.entidades.Habitacion;
import es.accenture.excepciones.HabitacionNoDisponibleException;

@Repository
@Transactional
public class HabitacionDAOImpl implements HabitacionDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List<Habitacion> findAll() {
        return getCurrentSession().createQuery("from Habitacion", Habitacion.class).list();
    }

    @Override
    public Habitacion findById(int id) {
        Habitacion habitacion = getCurrentSession().get(Habitacion.class, (long) id);

        if (habitacion == null) {
            throw new HabitacionNoDisponibleException(
                "No se encontró ninguna habitación con ID: " + id);
        }

        // Forzar carga de incidencias dentro de la transacción
        // para evitar LazyInitializationException en el JSP
        Hibernate.initialize(habitacion.getIncidencias());

        return habitacion;
    }

    @Override
    public void save(Habitacion habitacion) {
        getCurrentSession().save(habitacion);
    }

    @Override
    public void update(Habitacion habitacion) {
        Habitacion existente = getCurrentSession().get(Habitacion.class, habitacion.getId());

        if (existente == null) {
            throw new HabitacionNoDisponibleException(
                "No se puede actualizar: habitación con ID " + habitacion.getId() + " no encontrada.");
        }

        getCurrentSession().update(habitacion);
    }

    @Override
    public void delete(int id) {
        Session session = getCurrentSession();
        Habitacion habitacion = session.get(Habitacion.class, (long) id);

        if (habitacion == null) {
            throw new HabitacionNoDisponibleException(
                "No se puede eliminar: habitación con ID " + id + " no encontrada.");
        }

        session.createNativeQuery("DELETE FROM reservas WHERE habitacion_id = :id")
               .setParameter("id", id)
               .executeUpdate();

        session.delete(habitacion);
    }
}
