package es.accenture.servicios;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import es.accenture.daos.IHuespedDAO;
import es.accenture.entidades.Huesped;
import es.accenture.excepciones.HuespedNoEncontradoException;

@Service
@Transactional
public class HuespedServiceImpl implements IHuespedService {

    @Autowired
    private IHuespedDAO huespedDAO;

    @Override
    public List<Huesped> obtenerTodos() {
        return huespedDAO.obtenerTodos();
    }

    @Override
    public Huesped obtenerPorId(int id) {
        // Obtenemos del DAO
        Huesped huesped = huespedDAO.obtenerPorId(id);
        
        // Validación limpia. En vez de mandar 'null' a la vista, paramos aquí y lanzamos excepción.
        if (huesped == null) {
            throw new HuespedNoEncontradoException("No se ha encontrado el huesped con identificador interno: " + id);
        }
        
        return huesped;
    }

    @Override
    public void alta(Huesped huesped) {
        validarDatosBasicosHuesped(huesped);
        // Si no exploto la validación, damos pase al DAO
        huespedDAO.guardar(huesped);
    }

    @Override
    public void modificar(Huesped huesped) {
        validarDatosBasicosHuesped(huesped);
        
        // Antes de pisar, nos aseguramos que el identificador enviado realmente corresponda a una BBDD
        Huesped huespedBD = huespedDAO.obtenerPorId(huesped.getId());
        if (huespedBD == null) {
            throw new HuespedNoEncontradoException("No puedes actualizar un huesped que no existe en el sistema.");
        }
        
        huespedDAO.actualizar(huesped);
    }

    @Override
    public void eliminar(int id) {
        // Esto invoca la misma validacion y fallará automáticamene lanzando excepcion si mandan URL incorrecta.
        Huesped huespedObjetivo = obtenerPorId(id); 
        
        huespedDAO.eliminar(huespedObjetivo.getId());
    }
    
    // Método privado interno reutilizable para validar integridad estructural en alta y modificación.
    private void validarDatosBasicosHuesped(Huesped h) {
        if (h == null) {
            throw new IllegalArgumentException("No se ha enviado información del huésped.");
        }
        if (h.getNombre() == null || h.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del huésped es un dato obligatorio y no puede ir vacío.");
        }
        if (h.getApellidos() == null || h.getApellidos().trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido es obligatorio y es requerido para la formalidad hotelera.");
        }
        if (h.getDni() == null || h.getDni().trim().isEmpty()) {
            throw new IllegalArgumentException("Debe capturarse el Documento o Pasaporte oficial para temas de validación e ID legal.");
        }
    }
}