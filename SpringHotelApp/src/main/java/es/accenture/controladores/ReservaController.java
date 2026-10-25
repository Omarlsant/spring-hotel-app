package es.accenture.controladores;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import es.accenture.entidades.Reserva;
import es.accenture.entidades.Usuario;
import es.accenture.excepciones.UsuarioSinPermisosException;
import es.accenture.servicios.IHuespedService;
import es.accenture.servicios.IReservaService;
import es.accenture.dao.HabitacionDAO;

@Controller
@RequestMapping("/reservas")
public class ReservaController {

    @Autowired
    private IReservaService reservaService;

    @Autowired
    private IHuespedService huespedService;

    @Autowired
    private HabitacionDAO habitacionDAO;

    @GetMapping
    public String listar(Model model, HttpSession session) {
        validarSesion(session);
        model.addAttribute("reservas", reservaService.obtenerTodos());
        return "Reservas";
    }

    @GetMapping("/{id}")
    public String detalle(@PathVariable long id, Model model, HttpSession session) {
        validarSesion(session);
        model.addAttribute("reserva", reservaService.obtenerPorId(id));
        return "DetalleReserva";
    }

    @GetMapping("/nueva")
    public String nueva(Model model, HttpSession session) {
        verificarRecepcionista(session);
        prepararFormulario(model, new Reserva());
        return "FormularioReserva";
    }

    @GetMapping("/editar/{id}")
    public String editar(@PathVariable long id, Model model, HttpSession session) {
        verificarRecepcionista(session);
        prepararFormulario(model, reservaService.obtenerPorId(id));
        return "FormularioReserva";
    }

    @PostMapping
    public String guardar(@ModelAttribute("reserva") Reserva reserva,
            HttpSession session) {
        verificarRecepcionista(session);
        if (reserva.getId() == null || reserva.getId() == 0) {
            reservaService.alta(reserva);
        } else {
            reservaService.modificar(reserva);
        }
        return "redirect:/reservas";
    }

    @PostMapping("/eliminar")
    public String eliminar(@RequestParam("id") long id, HttpSession session) {
        verificarRecepcionista(session);
        reservaService.eliminar(id);
        return "redirect:/reservas";
    }

    private void prepararFormulario(Model model, Reserva reserva) {
        model.addAttribute("reserva", reserva);
        model.addAttribute("huespedes", huespedService.obtenerTodos());
        model.addAttribute("habitaciones", habitacionDAO.findAll());
    }

    private Usuario validarSesion(HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        if (usuario == null) {
            throw new UsuarioSinPermisosException("Debes iniciar sesión.");
        }
        return usuario;
    }

    private void verificarRecepcionista(HttpSession session) {
        Usuario usuario = validarSesion(session);
        if (!"RECEPCIONISTA".equalsIgnoreCase(usuario.getRol())) {
            throw new UsuarioSinPermisosException("No tienes permisos para modificar reservas.");
        }
    }
}
