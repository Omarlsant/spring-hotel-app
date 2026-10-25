package es.accenture.controladores;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import es.accenture.entidades.Huesped;
import es.accenture.entidades.Usuario;
import es.accenture.excepciones.UsuarioSinPermisosException;
import es.accenture.servicios.IHuespedService;

@Controller
@RequestMapping("/huespedes")
public class HuespedController {

    @Autowired
    private IHuespedService huespedService;

    // ----- Defensa DRY para verificar Sesiones/Roles antes de Ejecutar Acción -----
    private Usuario validarSesionActiva(HttpSession session) {
        Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
        if (user == null) {
            throw new UsuarioSinPermisosException("Debes iniciar sesión para realizar acciones sobre el sistema.");
        }
        return user;
    }
    
    private void verificarRolRecepcionista(Usuario user) {
        if (!"RECEPCIONISTA".equalsIgnoreCase(user.getRol())) {
            throw new UsuarioSinPermisosException("Permiso denegado. Rol (" + user.getRol() + ") no cuenta con los accesos requeridos para Escritura/Borrado.");
        }
    }

    // Lectura de todos los roles
    
    @GetMapping("/listado")
    public String listarHuespedes(Model modelo, HttpSession session) {
        validarSesionActiva(session);
        List<Huesped> listaBd = huespedService.obtenerTodos();
        modelo.addAttribute("huespedesList", listaBd);
        return "Huespedes"; 
    }

    @GetMapping("/detalle")
    public String verDetalleHuesped(@RequestParam("id") int id, Model modelo, HttpSession session) {
        validarSesionActiva(session); 
        Huesped huespedBd = huespedService.obtenerPorId(id);
        modelo.addAttribute("huespedAtributo", huespedBd);
        return "DetalleHuesped";
    }

    // Escritura y eliminación

    @GetMapping("/formulario")
    public String renderizarFormulario(@RequestParam(name = "id", required = false) Integer id, Model modelo, HttpSession session) {
        Usuario sesionActual = validarSesionActiva(session);
        verificarRolRecepcionista(sesionActual); // Control por rol

        Huesped huespedModel;
        if (id != null && id > 0) {
            huespedModel = huespedService.obtenerPorId(id);
        } else {
            huespedModel = new Huesped();
        }
        
        modelo.addAttribute("huespedAttrBinding", huespedModel);
        return "FormularioHuesped";
    }

    @PostMapping("/guardar")
    public String guardarOModificarHuesped(@ModelAttribute("huespedAttrBinding") Huesped formHuesped, HttpSession session) {
        Usuario sesionActual = validarSesionActiva(session);
        verificarRolRecepcionista(sesionActual);
        
        if (formHuesped.getId() != null && formHuesped.getId() > 0) {
            huespedService.modificar(formHuesped);
        } else {
            huespedService.alta(formHuesped);
        }
        return "redirect:/huespedes/listado";
    }

    @PostMapping("/eliminar")
    public String procesarBorradoHuesped(@RequestParam("id") int id, HttpSession session) {
        Usuario sesionActual = validarSesionActiva(session);
        verificarRolRecepcionista(sesionActual); 
        huespedService.eliminar(id);
        return "redirect:/huespedes/listado";
    }
}