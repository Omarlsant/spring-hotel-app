<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringHotelApp | Principal</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">

    <div style="background-color: #f1f1f1; padding: 15px; margin-bottom: 20px;">
        <span style="font-size: 1.2em; font-weight: bold;">Spring Hotel Dashboard</span>
        
        <span style="float: right;">
            Usuario Activo: <strong>${usuarioLogueado.username}</strong> 
            (<span style="color: blue;">${usuarioLogueado.rol}</span>) | 
            <a href="${pageContext.request.contextPath}/logout" style="color: red; text-decoration: none;">Cerrar sesion</a>
        </span>
    </div>

    <!-- Modulo General del Nav que menciona el PDF para luego mezclar -->
    <nav style="margin-bottom: 30px;">
        <!-- Enlaces base de preparación -->
        <a href="${pageContext.request.contextPath}/habitaciones" style="margin-right: 15px;">Habitaciones</a>
        <a href="${pageContext.request.contextPath}/huespedes/listado" style="margin-right: 15px;">Huespedes</a>
        <a href="${pageContext.request.contextPath}/reservas" style="margin-right: 15px;">Reservas</a>
        <a href="${pageContext.request.contextPath}/incidencias">Incidencias</a>
    </nav>

    <h3>Resumen y Panel de Control</h3>
    <p>Aqui gestionaremos toda la actividad del hotel en base al rol de cada trabajador.</p>

</body>
</html>