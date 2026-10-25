package es.accenture.excepciones;

public class ReservaNoEncontradaException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public ReservaNoEncontradaException(String message) {
        super(message);
    }
}
