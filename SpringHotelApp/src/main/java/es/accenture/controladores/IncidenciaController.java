package es.accenture.controladores;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import es.accenture.dao.HabitacionDAO;
import es.accenture.dao.IncidenciaDAO;
import es.accenture.entidades.Habitacion;
import es.accenture.entidades.Incidencia;
import es.accenture.entidades.Usuario;
import es.accenture.excepciones.UsuarioSinPermisosException;

@Controller
@RequestMapping("/incidencias")
public class IncidenciaController {

    @Autowired
    private IncidenciaDAO incidenciaDAO;

    @Autowired
    private HabitacionDAO habitacionDAO;

    @GetMapping
    public String listar(Model model) {
        model.addAttribute("incidencias", incidenciaDAO.findAll());
        return "Incidencias";
    }

    @GetMapping("/{id}")
    public String detalle(@PathVariable int id, Model model) {
        model.addAttribute("incidencia", incidenciaDAO.findById(id));
        return "DetalleIncidencia";
    }

    @GetMapping("/nueva")
    public String nueva(
            @RequestParam(required = false) Long habitacionId,
            @RequestParam(required = false) String habitacionNumero,
            Model model, javax.servlet.http.HttpSession session) {

        verificarRecepcionista(session);

        Incidencia incidencia = new Incidencia();

        if (habitacionId != null) {
            Habitacion hab = habitacionDAO.findById(habitacionId.intValue());
            incidencia.setHabitacion(hab);
            // El n�mero viene directo de la URL, sin necesidad de ir a BD
            model.addAttribute("habitacionNumero", habitacionNumero);
        }

        model.addAttribute("incidencia", incidencia);
        model.addAttribute("habitaciones", habitacionDAO.findAll());
        model.addAttribute("titulo", "Nueva incidencia");
        return "FormularioIncidencia";
    }

    @GetMapping("/editar/{id}")
    public String editar(@PathVariable int id, Model model, javax.servlet.http.HttpSession session) {
        verificarRecepcionista(session);
    	
    	Incidencia incidencia = incidenciaDAO.findById(id);
    	
        model.addAttribute("incidencia", incidencia);
        model.addAttribute("habitaciones", habitacionDAO.findAll());
        model.addAttribute("titulo", "Editar incidencia");
        
        
        return "FormularioIncidencia";
    }

    @PostMapping
    public String guardar(@ModelAttribute("incidencia") Incidencia incidencia,
            javax.servlet.http.HttpSession session) {
        verificarRecepcionista(session);
        if (incidencia.getHabitacion() == null || incidencia.getHabitacion().getId() == null
                || incidencia.getDescripcion() == null || incidencia.getDescripcion().trim().isEmpty()
                || incidencia.getEstado() == null || incidencia.getPrioridad() == null) {
            throw new IllegalArgumentException("Habitacion, descripcion, estado y prioridad son obligatorios.");
        }
    	
        if (incidencia.getFechaApertura() == null) {
            incidencia.setFechaApertura(LocalDate.now());
        }
        incidencia.setEstado(incidencia.getEstado().toLowerCase());
        incidencia.setPrioridad(incidencia.getPrioridad().toLowerCase());
    	
        if (incidencia.getId() == null || incidencia.getId() == 0) {
        	
            incidenciaDAO.save(incidencia);
        } else {
            incidenciaDAO.update(incidencia);
        }
        return "redirect:/incidencias";
    }

    @PostMapping("/eliminar")
    public String eliminar(@RequestParam("id") int id, javax.servlet.http.HttpSession session) {
        verificarRecepcionista(session);
        incidenciaDAO.delete(id);
        return "redirect:/incidencias";
    }

    private void verificarRecepcionista(javax.servlet.http.HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null || !"RECEPCIONISTA".equalsIgnoreCase(usuario.getRol())) {
            throw new UsuarioSinPermisosException("No tienes permisos para modificar incidencias.");
        }
    }
}
