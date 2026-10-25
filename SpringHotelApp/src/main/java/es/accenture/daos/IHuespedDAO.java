package es.accenture.daos;

import java.util.List;
import es.accenture.entidades.Huesped;

/**
 * Interface DAO que define el contrato de las operaciones 
 * de la base de datos aplicables a la entidad Huesped.
 */
public interface IHuespedDAO {

    /**
     * Recupera todos los huespedes registrados.
     * @return Lista de huespedes.
     */
    List<Huesped> obtenerTodos();

    /**
     * Busca un huesped basandose en su identificador unico de base de datos.
     * @param id El identificador primario del huesped.
     * @return El Huesped encontrado o null en su defecto.
     */
    Huesped obtenerPorId(int id);

    /**
     * Da de alta un nuevo registro de Huesped. 
     * Las restricciones como el DNI unico lo controla BBDD.
     * @param huesped El huesped temporal (sin ID) mapeado a guardar.
     */
    void guardar(Huesped huesped);

    /**
     * Actualiza y sincroniza la información de un huesped que 
     * ya existía previamente mediante su objeto en la base de datos.
     * @param huesped El Huesped portador de las modificaciones y el Id objetivo.
     */
    void actualizar(Huesped huesped);

    /**
     * Da de baja el Huesped por completo usando unicamente su id para encontrarlo.
     * @param id Identificador a destruir.
     */
    void eliminar(int id);
}