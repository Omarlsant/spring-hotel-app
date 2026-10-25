<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Detalle de reserva</title></head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h1>Detalle de reserva #${reserva.id}</h1>
    <p>Huesped: ${reserva.huesped.nombre} ${reserva.huesped.apellidos}</p>
    <p>Habitacion: ${reserva.habitacion.numero} (${reserva.habitacion.tipo})</p>
    <p>Fecha de entrada: ${reserva.fechaEntrada}</p>
    <p>Fecha de salida: ${reserva.fechaSalida}</p>
    <a href="${pageContext.request.contextPath}/reservas">Volver al listado</a>
</body>
</html>
