package es.accenture.controladores;

import java.util.UUID;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * Gestor Global de Excepciones.
 * Intercepta cualquier fallo en la app, nos lo chiva por consola
 * y envía al usuario a una pantalla controlada en vez de mostrarle 
 * un volcado feo del servidor de Tomcat.
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Log LOGGER = LogFactory.getLog(GlobalExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    public ModelAndView atraparCualquierFallo(Exception ex) {
        
        String errorId = UUID.randomUUID().toString();
        LOGGER.error("Error no controlado. Identificador: " + errorId, ex);
        
        // Lo redirigimos a una vista segura
        ModelAndView modeloVista = new ModelAndView("ErrorGlobal");
        modeloVista.addObject("errorId", errorId);
        
        return modeloVista;
    }
}