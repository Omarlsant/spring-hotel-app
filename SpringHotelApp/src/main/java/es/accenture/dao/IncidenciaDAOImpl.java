package es.accenture.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import es.accenture.entidades.Incidencia;
import es.accenture.excepciones.IncidenciaNoEncontradaException;

@Repository
@Transactional
public class IncidenciaDAOImpl implements IncidenciaDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List<Incidencia> findAll() {
        return getCurrentSession().createQuery("from Incidencia", Incidencia.class).list();
    }

    @Override
    public Incidencia findById(int id) {
        Incidencia incidencia = getCurrentSession().get(Incidencia.class, (long) id);

        if (incidencia == null) {
            throw new IncidenciaNoEncontradaException(
                "No se encontró ninguna incidencia con ID: " + id);
        }

        return incidencia;
    }

    @Override
    public void save(Incidencia incidencia) {
        getCurrentSession().save(incidencia);
    }

    @Override
    public void update(Incidencia incidencia) {
        Incidencia existente = getCurrentSession().get(Incidencia.class, incidencia.getId());

        if (existente == null) {
            throw new IncidenciaNoEncontradaException(
                "No se puede actualizar: incidencia con ID " + incidencia.getId() + " no encontrada.");
        }

        getCurrentSession().update(incidencia);
    }

    @Override
    public void delete(int id) {
        Session session = getCurrentSession();
        Incidencia incidencia = session.get(Incidencia.class, (long) id);

        if (incidencia == null) {
            throw new IncidenciaNoEncontradaException(
                "No se puede eliminar: incidencia con ID " + id + " no encontrada.");
        }

        session.delete(incidencia);
    }
}
