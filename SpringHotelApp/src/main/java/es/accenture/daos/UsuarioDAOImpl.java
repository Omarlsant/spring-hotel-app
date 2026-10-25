package es.accenture.daos;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import es.accenture.entidades.Usuario;

@Repository
@Transactional
public class UsuarioDAOImpl implements IUsuarioDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Usuario obtenerPorCredenciales(String username, String password) {
        
        // Se obtiene la sesión conectada a la base de datos.
        Session currentSession = sessionFactory.getCurrentSession();
        
        // Uso de sintaxis HQL usando el objeto 'Usuario', sin referenciar la tabla.
        String sentenciaHQL = "FROM Usuario u WHERE u.username = :paramUsername AND u.password = :paramPassword";
        
        // Se ejecuta la Query indicando explícitamente el tipo de dato que esperamos devolver.
        Query<Usuario> query = currentSession.createQuery(sentenciaHQL, Usuario.class);
        query.setParameter("paramUsername", username);
        query.setParameter("paramPassword", password);
        
        // Método uniqueResult() que devuelve el usuario y manejo de no encontrar dato con null
        return query.uniqueResult();
    }
}