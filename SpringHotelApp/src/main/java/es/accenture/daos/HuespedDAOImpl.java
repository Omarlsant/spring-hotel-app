package es.accenture.daos;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import es.accenture.entidades.Huesped;

@Repository
@Transactional
public class HuespedDAOImpl implements IHuespedDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Huesped> obtenerTodos() {
        Session session = sessionFactory.getCurrentSession();
        // Usamos tipado de genéricos para seguridad del Query (HQL)
        return session.createQuery("FROM Huesped ORDER BY apellidos", Huesped.class).getResultList();
    }

    @Override
    public Huesped obtenerPorId(int id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Huesped.class, id);
    }

    @Override
    public void guardar(Huesped huesped) {
        Session session = sessionFactory.getCurrentSession();
        // Genera el registro; el framework insertará y poblará su ID autoincremental internamente.
        session.save(huesped);
    }

    @Override
    public void actualizar(Huesped huesped) {
        Session session = sessionFactory.getCurrentSession();
        // Busca si un hueped existe e inyecta toda la información 
        session.update(huesped);
    }

    @Override
    public void eliminar(int id) {
        Session session = sessionFactory.getCurrentSession();
        Huesped huespedBD = session.get(Huesped.class, id);
        
        // Verifica para no invocar métodos a datos Nulos
        if (huespedBD != null) {
            session.createNativeQuery("DELETE FROM reservas WHERE huesped_id = :id")
                   .setParameter("id", id)
                   .executeUpdate();
            session.delete(huespedBD);
        }
    }
}