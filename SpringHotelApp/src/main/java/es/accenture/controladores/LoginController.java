package es.accenture.controladores;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import es.accenture.entidades.Usuario;
import es.accenture.excepciones.CredencialesInvalidasException;
import es.accenture.servicios.IUsuarioService;

@Controller
public class LoginController {

    @Autowired
    private IUsuarioService usuarioService;

    // ----- VISTA DE INICIO DE SESIÓN ----- //
    
    @GetMapping({"/", "/login"})
    public String mostrarFormularioLogin(HttpSession session, Model modelo) {
        // Si un usuario con sesión abierta trata de ir al login, lo devolvemos directo al Menú
        if (session.getAttribute("usuarioLogueado") != null) {
            return "redirect:/principal";
        }
        modelo.addAttribute("loginForm", new Usuario());
        return "Login";
    }

    // ----- PROCESAR CREDENCIALES ----- //
    
    @PostMapping("/login")
    public String procesarLogin(@RequestParam("username") String username,
                                @RequestParam("password") String password, 
                                HttpSession session, 
                                Model modelo) {
        try {
            // El servicio lanza error automático si las credenciales fallan.
            Usuario usuarioAuth = usuarioService.login(username, password);
            
            // Creamos sesión HTT
            session.setAttribute("usuarioLogueado", usuarioAuth);
            
            return "redirect:/principal";

        } catch (CredencialesInvalidasException ex) {
            modelo.addAttribute("errorDeLogin", ex.getMessage());
            Usuario loginForm = new Usuario();
            loginForm.setUsername(username);
            modelo.addAttribute("loginForm", loginForm);
            return "Login"; 
        }
    }

    // ----- PANEL PRINCIPAL DEL USUARIO ----- //
    
    @GetMapping("/principal")
    public String mostrarPaginaPrincipal(HttpSession session, Model modelo) {
        // Defensa de seguridad sencilla de la ruta
        if (session.getAttribute("usuarioLogueado") == null) {
            return "redirect:/login";
        }
        return "Principal"; 
    }

    // ----- CIERRE DE SESIÓN ----- //
    
    @GetMapping("/logout")
    public String cerrarSesion(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }
}