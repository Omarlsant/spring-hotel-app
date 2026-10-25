<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle Incidencia #${incidencia.id} | Spring Hotel</title>
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

    <div class="container" style="max-width: 720px;">

        <a href="<spring:url value='/incidencias'/>" class="back-link" style="margin-bottom: 24px; display: inline-flex;">
            <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
            </svg>
            Volver al listado
        </a>

        <div class="detail-card">

            <!-- Header -->
            <div class="card-header">
                <div class="card-header-left">
                    <div class="incident-icon">
                        <svg fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                        </svg>
                    </div>
                    <div>
                        <div class="card-header-title">Incidencia #${incidencia.id}</div>
                        <div class="card-header-sub">Habitación ${incidencia.habitacion.numero}</div>
                    </div>
                </div>
                <div class="badges-row">
                    <c:choose>
                        <c:when test="${incidencia.estado == 'abierto' || incidencia.estado == 'abierta'}">
                            <span class="badge badge-abierto">Abierta</span>
                        </c:when>
                        <c:when test="${incidencia.estado == 'en curso'}">
                            <span class="badge badge-en-curso">En curso</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-cerrado">Cerrada</span>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${incidencia.prioridad == 'alta'}">
                            <span class="badge badge-alta">⚠ Alta</span>
                        </c:when>
                        <c:when test="${incidencia.prioridad == 'media'}">
                            <span class="badge badge-media">Media</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-baja">Baja</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Body -->
            <div class="card-body">

                <div class="info-row">
                    <span class="info-label">Habitación</span>
                    <span class="info-value">
                        <span class="badge badge-room">${incidencia.habitacion.numero}</span>
                    </span>
                </div>

                <div class="info-row" style="flex-direction: column; align-items: flex-start; gap: 8px;">
                    <span class="info-label">Descripción</span>
                    <div class="info-value descripcion" style="text-align:left; width:100%;">
                        ${incidencia.descripcion}
                    </div>
                </div>

                <!-- Fechas -->
                <div class="dates-grid">
                    <div class="date-block">
                        <div class="date-block-label">Fecha de apertura</div>
                        <div class="date-block-value">
                            <c:choose>
                                <c:when test="${not empty incidencia.fechaApertura}">${incidencia.fechaApertura}</c:when>
                                <c:otherwise><span class="empty">—</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Footer acciones -->
            <div class="card-footer">
                <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}"><form method="post" action="${pageContext.request.contextPath}/incidencias/eliminar" style="display:inline">
                <input type="hidden" name="id" value="${incidencia.id}">
                <button type="submit" onclick="return confirm('¿Seguro que deseas eliminar esta incidencia?')" class="btn btn-delete">
                    <svg width="15" height="15" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                    </svg>
                    Eliminar
                    </button>
                </form>
                <a href="<spring:url value='/incidencias/editar/${incidencia.id}'/>" class="btn btn-edit">
                    <svg width="15" height="15" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                    </svg>
                    Editar incidencia
                </a></c:if>
            </div>

        </div>
    </div>

</body>
</html>
