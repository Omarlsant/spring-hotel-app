package es.accenture.excepciones;

public class UsuarioSinPermisosException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public UsuarioSinPermisosException(String mensaje) {
        super(mensaje);
    }
}
