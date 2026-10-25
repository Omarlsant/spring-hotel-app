<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringHotelApp | Auditoria Data del Huesped</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Identificador Único Huesped Perfil # ${huespedAtributo.id}</h2>

    <div style="border: 2px dashed #999; padding: 25px; margin-top: 10px; background-color:#efffff;">
        <p><strong>Nombres Capturados BBDD:</strong> ${huespedAtributo.nombre}</p>
        <p><strong>Apellidos Centrales:</strong> ${huespedAtributo.apellidos}</p>
        <p><strong>Cruce Fiscal - Legal DNI / Nro ID ÚNICA (BBDD Constraint UNIQUE):</strong> ${huespedAtributo.dni}</p>
        <p><strong>Telecomunicacion Dispositivo Registrado :</strong> ${not empty huespedAtributo.telefono ? huespedAtributo.telefono : "<i style='color:grey;'>sin registrar por huesped base</i>" }</p>
        <p><strong>Data Red y Email BBDD (Si hubiere registrado algo temporalmente para confirmacion):</strong> ${not empty huespedAtributo.email ? huespedAtributo.email : "<i style='color:grey;'>Información faltante u omitida </i>" }</p>
    </div>

    <br>
    <a href="${pageContext.request.contextPath}/huespedes/listado" style="text-decoration:none; color:black;">👈🏻 Regresar Atrás en el Control Local General Base de Datos.</a>

</body>
</html>