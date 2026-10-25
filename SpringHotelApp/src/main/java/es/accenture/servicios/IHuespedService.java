package es.accenture.servicios;

import java.util.List;
import es.accenture.entidades.Huesped;

public interface IHuespedService {

    /**
     Obtiene el listado completo de todos los huespedes alojados o históricos.
     */
    List<Huesped> obtenerTodos();

    /**
     Recupera la informacion de un solo huesped garantizando que existe. Si no existe, dispara HuespedNoEncontradoException.
     **/
    Huesped obtenerPorId(int id);

    /**
     * Realiza validaciones estrictas de datos y da de alta en la BD.
     */
    void alta(Huesped huesped);

    /**
     * Verifica que el huesped exista y, de ser valido, lo actualiza.
     */
    void modificar(Huesped huesped);

    /**
     * Verifica que el ID enviado realmente apunte a alguien y lo borra de BBDD.
     */
    void eliminar(int id);
}