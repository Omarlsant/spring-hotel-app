package es.accenture.servicios;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import es.accenture.daos.IUsuarioDAO;
import es.accenture.entidades.Usuario;
import es.accenture.excepciones.CredencialesInvalidasException;

@Service
public class UsuarioServiceImpl implements IUsuarioService {

    @Autowired
    private IUsuarioDAO usuarioDAO;

    @Override
    public Usuario login(String username, String password) {
        // Criterio fallo rápido si vienen datos corruptos.
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            throw new CredencialesInvalidasException("El usuario y la contraseña no pueden estar vacíos.");
        }

        Usuario usuarioAutenticado = usuarioDAO.obtenerPorCredenciales(username.trim(), password);

        // Validamos contra la BD
        if (usuarioAutenticado == null) {
            throw new CredencialesInvalidasException("Usuario o contraseña incorrectos.");
        }

        return usuarioAutenticado;
    }
}