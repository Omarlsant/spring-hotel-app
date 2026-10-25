<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incidencias | Spring Hotel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/spring-hotel.css" rel="stylesheet">
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/habitaciones" class="navbar-brand">
            <svg viewBox="0 0 24 24">
                <path d="M19 4H5c-1.1 0-2 .9-2 2v14c0 1.1 0 2 .9 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm-2 10h-4v4h-2v-4H7v-2h4V8h2v4h4v2z"/>
            </svg>
            <span>Spring Hotel App</span>
        </a>
        <div class="navbar-menu">
            <a href="${pageContext.request.contextPath}/habitaciones" class="navbar-link">Habitaciones</a>
            <a href="${pageContext.request.contextPath}/incidencias" class="navbar-link active">Incidencias</a>
            <a href="${pageContext.request.contextPath}/huespedes/listado" class="navbar-link">Huespedes</a>
        </div>
    </nav>

    <div class="container" style="max-width: 1100px;">

        <div class="page-header">
            <div class="page-title">
                <h1>Gestión de Incidencias</h1>
                <p>Consulta y gestiona todas las incidencias registradas en el hotel.</p>
            </div>
            <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}"><a href="<spring:url value='/incidencias/nueva'/>" class="btn btn-primary">
                <svg width="17" height="17" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/>
                </svg>
                Nueva Incidencia
            </a></c:if>
        </div>

        <div class="table-wrapper">
            <c:choose>
                <c:when test="${empty incidencias}">
                    <div class="empty-state">
                        <svg fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                        </svg>
                        <h4>Sin incidencias registradas</h4>
                        <p>No hay ninguna incidencia en el sistema todavía.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Habitación</th>
                                <th>Descripción</th>
                                <th>Estado</th>
                                <th>Prioridad</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="inc" items="${incidencias}">
                                <tr>
                                    <td class="td-muted">#${inc.id}</td>
                                    <td>
                                        <span class="room-pill">
                                            <svg width="11" height="11" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                                            </svg>
                                            ${inc.habitacion.numero}
                                        </span>
                                    </td>
                                    <td class="td-desc">${inc.descripcion}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${inc.estado == 'abierto' || inc.estado == 'abierta'}">
                                                <span class="badge badge-abierto">Abierta</span>
                                            </c:when>
                                            <c:when test="${inc.estado == 'en curso'}">
                                                <span class="badge badge-en-curso">En curso</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-cerrado">Cerrada</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${inc.prioridad == 'alta'}">
                                                <span class="badge badge-alta">Alta</span>
                                            </c:when>
                                            <c:when test="${inc.prioridad == 'media'}">
                                                <span class="badge badge-media">Media</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-baja">Baja</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <a href="<spring:url value='/incidencias/${inc.id}'/>" class="btn-action btn-view">
                                                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.477 0 8.268 2.943 9.542 7-1.274 4.057-5.065 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                                </svg>
                                                Ver
                                            </a>
                                            <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}"><a href="<spring:url value='/incidencias/editar/${inc.id}'/>" class="btn-action btn-edit">
                                                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                                </svg>
                                                Editar
                                            </a>
                                            <form method="post" action="${pageContext.request.contextPath}/incidencias/eliminar" style="display:inline">
                                               <input type="hidden" name="id" value="${inc.id}">
                                            <button type="submit"
                                               onclick="return confirm('¿Seguro que deseas eliminar esta incidencia?')"
                                               class="btn-action btn-delete">
                                                <svg width="13" height="13" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                                </svg>
                                                Eliminar
                                            </button></form></c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</body>
</html>
