package es.accenture.daos;

import es.accenture.entidades.Usuario;

public interface IUsuarioDAO {
    
    /**
     * Consulta la base de datos para buscar un usuario que coincida
     * con el usuario y la contraseña proporcionados.
     * 
     * @param username Nombre de usuario (recepcion1, etc).
     * @param password Contraseña plana (por ahora) o procesada.
     * @return El objeto Usuario si existe y coincide, o null si las credenciales son inválidas.
     */
    Usuario obtenerPorCredenciales(String username, String password);

}