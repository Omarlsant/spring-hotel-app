package es.accenture.dao;

import java.time.LocalDate;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import es.accenture.entidades.Reserva;
import es.accenture.excepciones.ReservaNoEncontradaException;

@Repository
@Transactional
public class ReservaDAOImpl implements ReservaDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List<Reserva> findAll() {
        return getCurrentSession()
                .createQuery("from Reserva order by fechaEntrada", Reserva.class)
                .getResultList();
    }

    @Override
    public Reserva findById(long id) {
        Reserva reserva = getCurrentSession().get(Reserva.class, id);
        if (reserva == null) {
            throw new ReservaNoEncontradaException("No se ha encontrado la reserva solicitada.");
        }
        return reserva;
    }

    @Override
    public void save(Reserva reserva) {
        getCurrentSession().save(reserva);
    }

    @Override
    public void update(Reserva reserva) {
        findById(reserva.getId());
        getCurrentSession().update(reserva);
    }

    @Override
    public void delete(long id) {
        getCurrentSession().delete(findById(id));
    }

    @Override
    public boolean existsOverlap(long habitacionId, LocalDate fechaEntrada,
            LocalDate fechaSalida, Long reservaId) {
        String hql = "select count(r.id) from Reserva r "
                + "where r.habitacion.id = :habitacionId "
                + "and r.fechaEntrada < :fechaSalida "
                + "and r.fechaSalida > :fechaEntrada";
        if (reservaId != null) {
            hql += " and r.id <> :reservaId";
        }
        org.hibernate.query.Query<Long> query = getCurrentSession().createQuery(hql, Long.class)
                .setParameter("habitacionId", habitacionId)
                .setParameter("fechaEntrada", fechaEntrada)
                .setParameter("fechaSalida", fechaSalida);
        if (reservaId != null) {
            query.setParameter("reservaId", reservaId);
        }
        Long count = query.uniqueResult();
        return count != null && count > 0;
    }
}
