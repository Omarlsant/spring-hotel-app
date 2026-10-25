<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringHotelApp | Central Gestión Huesped</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Centro de Gestión (Unificado Creacion/Modificacion) de Huésped</h2>

    <!-- Uso Restrictivo MVC -->
    <form:form action="${pageContext.request.contextPath}/huespedes/guardar" method="POST" modelAttribute="huespedAttrBinding" style="max-width: 400px; padding: 20px; border: 1px solid #ccc; background-color: #fafafa;">

        <form:hidden path="id" />

        <div style="margin-bottom: 10px;">
            <label style="display: block;">DNI / Doc Base Único Obligatorio:</label>
            <form:input path="dni" cssStyle="width: 100%; padding: 5px;" required="required" />
        </div>

        <div style="margin-bottom: 10px;">
            <label style="display: block;">Apellidos Legales Registrados:</label>
            <form:input path="apellidos" cssStyle="width: 100%; padding: 5px;" required="required" />
        </div>

        <div style="margin-bottom: 10px;">
            <label style="display: block;">Nombre:</label>
            <form:input path="nombre" cssStyle="width: 100%; padding: 5px;" required="required" />
        </div>

        <div style="margin-bottom: 10px;">
            <label style="display: block;">Número Télefonico:</label>
            <form:input path="telefono" cssStyle="width: 100%; padding: 5px;" />
        </div>

        <div style="margin-bottom: 20px;">
            <label style="display: block;">Correo Electronico:</label>
            <form:input path="email" type="email" cssStyle="width: 100%; padding: 5px;" />
        </div>

        <button type="submit" style="padding: 10px; background-color: #007bff; color: white; width: 100%;">💾 Completar y Persistir Registros Base</button>
    </form:form>
    
    <div style="margin-top: 15px;">
        <a href="${pageContext.request.contextPath}/huespedes/listado">🔙 Retornar listado perdiendo estado temporal (no grabar)</a>
    </div>

</body>
</html>