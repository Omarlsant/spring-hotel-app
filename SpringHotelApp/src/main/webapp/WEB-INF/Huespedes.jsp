<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringHotelApp | Listado de Huespedes</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">
    <h2>Directorio General de Huespedes</h2>
    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/principal" style="margin-right: 15px;">⬅ Volver al Menu Principal</a>
        
        <!-- Bloque Restrictivo VISTA -->
        <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}">
            <a href="${pageContext.request.contextPath}/huespedes/formulario" style="color: green; font-weight:bold;">➕ Alta Nuevo Huesped</a>
        </c:if>
    </div>

    <table border="1" style="width: 100%; text-align: left; border-collapse: collapse;">
        <tr style="background-color: #d1d1d1;">
            <th style="padding: 10px;">ID Sistema</th>
            <th style="padding: 10px;">Apellidos y Nombres</th>
            <th style="padding: 10px;">Identificador Básico (DNI)</th>
            <th style="padding: 10px; text-align: center;">Acciones Autorizadas</th>
        </tr>

        <c:forEach var="clienteIt" items="${huespedesList}">
            <tr>
                <td style="padding: 8px;">${clienteIt.id}</td>
                <td style="padding: 8px;"><strong>${clienteIt.apellidos}</strong>, ${clienteIt.nombre}</td>
                <td style="padding: 8px;">${clienteIt.dni}</td>
                <td style="padding: 8px; text-align: center;">
                    <a href="${pageContext.request.contextPath}/huespedes/detalle?id=${clienteIt.id}" style="margin-right: 10px; text-decoration: none;">🔍 Ver</a>
                    
                    <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}">
                        <a href="${pageContext.request.contextPath}/huespedes/formulario?id=${clienteIt.id}" style="color: blue; text-decoration: none; margin-right: 10px;">✏️ Editar</a>
                        <form method="post" action="${pageContext.request.contextPath}/huespedes/eliminar" style="display:inline">
                            <input type="hidden" name="id" value="${clienteIt.id}">
                            <button type="submit" style="color: red; text-decoration: none;" onclick="return confirm('¿Confirma eliminar este huesped?')">Borrar</button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>