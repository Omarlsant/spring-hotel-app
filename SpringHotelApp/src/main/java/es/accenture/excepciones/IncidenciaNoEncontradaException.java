package es.accenture.excepciones;

public class IncidenciaNoEncontradaException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public IncidenciaNoEncontradaException(String mensaje) {
        super(mensaje);
    }
}
