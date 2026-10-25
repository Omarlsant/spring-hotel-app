package es.accenture.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;

import es.accenture.dao.HabitacionDAO;
import es.accenture.entidades.Habitacion;
import es.accenture.entidades.Usuario;
import es.accenture.excepciones.UsuarioSinPermisosException;

@Controller
@RequestMapping("/habitaciones")
public class HabitacionController {
	
	@Autowired
	private HabitacionDAO habitacionDAO;
	
	@GetMapping
	public String listar(Model model) {
	    model.addAttribute("listaHabitaciones", habitacionDAO.findAll());
	    return "Habitaciones";
	  }
	
	@GetMapping("/{id}")
    public String detalle(@PathVariable int id, Model model) {
        model.addAttribute("habitacion", habitacionDAO.findById(id));
        return "DetalleHabitacion";
    }
	
	@GetMapping("/{id}/incidencias")
    public String listarIncidencias(@PathVariable int id, Model model) {
        model.addAttribute("incidencias", habitacionDAO.findById(id).getIncidencias());
        return "Incidencias";
    }
	
	
	@GetMapping("/nuevo")
	public String nuevo(Model model, HttpSession session) {
		verificarRecepcionista(session);
		model.addAttribute("habitacion", new Habitacion());
		return "FormularioHabitacion";
	}

	@GetMapping("/editar/{id}")
	public String editar(@PathVariable int id, Model model, HttpSession session) {
		verificarRecepcionista(session);
		model.addAttribute("habitacion", habitacionDAO.findById(id));
		return "FormularioHabitacion";
	}

	@PostMapping("/guardar")
	public String guardar(@ModelAttribute Habitacion habitacion, HttpSession session) {
		verificarRecepcionista(session);
		if (habitacion.getNumero() == null || habitacion.getNumero().trim().isEmpty()
				|| habitacion.getTipo() == null || habitacion.getTipo().trim().isEmpty()
				|| habitacion.getPrecio() == null || habitacion.getPrecio() < 0) {
			throw new IllegalArgumentException("Numero, tipo y precio son obligatorios.");
		}
		if (habitacion.getId() != null && habitacion.getId() > 0) {
			habitacionDAO.update(habitacion);
		} else {
			if (habitacion.getDisponible() == null) {
				habitacion.setDisponible(true);
			}
			habitacionDAO.save(habitacion);
		}
		return "redirect:/habitaciones";
	}

	@PostMapping("/eliminar")
	public String eliminar(@org.springframework.web.bind.annotation.RequestParam("id") int id,
			HttpSession session) {
		verificarRecepcionista(session);
		habitacionDAO.delete(id);
		return "redirect:/habitaciones";
	}

	private void verificarRecepcionista(HttpSession session) {
		Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
		if (usuario == null || !"RECEPCIONISTA".equalsIgnoreCase(usuario.getRol())) {
			throw new UsuarioSinPermisosException("No tienes permisos para modificar habitaciones.");
		}
	}
}
