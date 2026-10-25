package es.accenture.excepciones;

/**
 * Excepción lanzada cuando un usuario intenta acceder con credenciales erróneas.
 */
public class CredencialesInvalidasException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public CredencialesInvalidasException(String mensaje) {
        super(mensaje);
    }
}