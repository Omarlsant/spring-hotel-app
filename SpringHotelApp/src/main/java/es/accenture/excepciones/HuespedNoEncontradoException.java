package es.accenture.excepciones;

/**
 * Excepción lanzada cuando se busca un huésped en BBDD y no existe.
 * Esta excepción es capturada de forma automática por el GlobalExceptionHandler.
 */
public class HuespedNoEncontradoException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public HuespedNoEncontradoException(String mensaje) {
        super(mensaje);
    }
}