package es.accenture.excepciones;

public class HabitacionNoDisponibleException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public HabitacionNoDisponibleException(String mensaje) {
        super(mensaje);
    }
}
