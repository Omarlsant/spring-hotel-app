<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reservas | Spring Hotel</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h1>Reservas</h1>
    <p>
        <a href="${pageContext.request.contextPath}/principal">Menu principal</a> |
        <a href="${pageContext.request.contextPath}/habitaciones">Habitaciones</a> |
        <a href="${pageContext.request.contextPath}/huespedes/listado">Huespedes</a> |
        <a href="${pageContext.request.contextPath}/incidencias">Incidencias</a>
    </p>
    <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}">
        <p><a href="${pageContext.request.contextPath}/reservas/nueva">Nueva reserva</a></p>
    </c:if>
    <c:choose>
        <c:when test="${empty reservas}"><p>No hay reservas registradas.</p></c:when>
        <c:otherwise>
            <table border="1" cellpadding="8">
                <tr><th>ID</th><th>Huesped</th><th>Habitacion</th><th>Entrada</th><th>Salida</th><th>Acciones</th></tr>
                <c:forEach var="reserva" items="${reservas}">
                    <tr>
                        <td>${reserva.id}</td>
                        <td>${reserva.huesped.nombre} ${reserva.huesped.apellidos}</td>
                        <td>${reserva.habitacion.numero}</td>
                        <td>${reserva.fechaEntrada}</td>
                        <td>${reserva.fechaSalida}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/reservas/${reserva.id}">Detalle</a>
                            <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}">
                                <a href="${pageContext.request.contextPath}/reservas/editar/${reserva.id}">Editar</a>
                                <form method="post" action="${pageContext.request.contextPath}/reservas/eliminar" style="display:inline">
                                    <input type="hidden" name="id" value="${reserva.id}">
                                    <button type="submit">Eliminar</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
