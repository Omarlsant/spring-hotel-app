<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Reserva</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h1><c:choose><c:when test="${empty reserva.id}">Nueva reserva</c:when><c:otherwise>Modificar reserva</c:otherwise></c:choose></h1>
    <form:form modelAttribute="reserva" method="post" action="${pageContext.request.contextPath}/reservas">
        <form:hidden path="id"/>
        <p>
            <label for="huesped">Huesped</label>
            <form:select path="huesped.id" id="huesped">
                <form:option value="" label="Selecciona un huesped"/>
                <form:options items="${huespedes}" itemValue="id" itemLabel="apellidos"/>
            </form:select>
        </p>
        <p>
            <label for="habitacion">Habitacion</label>
            <form:select path="habitacion.id" id="habitacion">
                <form:option value="" label="Selecciona una habitacion"/>
                <form:options items="${habitaciones}" itemValue="id" itemLabel="numero"/>
            </form:select>
        </p>
        <p><label for="entrada">Entrada</label><form:input path="fechaEntrada" type="date" id="entrada"/></p>
        <p><label for="salida">Salida</label><form:input path="fechaSalida" type="date" id="salida"/></p>
        <button type="submit">Guardar</button>
        <a href="${pageContext.request.contextPath}/reservas">Cancelar</a>
    </form:form>
</body>
</html>
