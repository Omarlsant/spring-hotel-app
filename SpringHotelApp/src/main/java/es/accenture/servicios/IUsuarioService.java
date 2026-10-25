package es.accenture.servicios;

import es.accenture.entidades.Usuario;

public interface IUsuarioService {

    /**
     * Valida y autentica a un usuario del sistema.
     * 
     * @param username El nombre de usuario enviado en el formulario.
     * @param password La contraseña ingresada.
     * @return El Usuario completo autenticado.
     */
    Usuario login(String username, String password);

}