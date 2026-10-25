<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle Habitación Nº ${habitacion.numero} | Spring Hotel</title>
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
            <a href="${pageContext.request.contextPath}/habitaciones" class="navbar-link active">Habitaciones</a>
            <a href="${pageContext.request.contextPath}/reservas" class="navbar-link">Reservas</a>
            <a href="${pageContext.request.contextPath}/huespedes/listado" class="navbar-link">Huespedes</a>
        </div>
    </nav>

    <div class="container">
        <div class="header-navigation">
            <a href="${pageContext.request.contextPath}/habitaciones" class="back-link">
                <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                </svg>
                Volver al panel principal
            </a>
        </div>

        <div class="detail-grid">

            <!-- Sidebar habitación -->
            <div class="card">
                <div class="card-header-bg">
                    <div class="card-header-number">${habitacion.numero}</div>
                    <div class="card-header-label">Habitación</div>
                </div>
                <div class="card-body">
                    <div class="card-info-item">
                        <span class="info-label">Identificador (ID)</span>
                        <span class="info-value" style="color: var(--text-muted);">#${habitacion.id}</span>
                    </div>
                    <div class="card-info-item">
                        <span class="info-label">Tipo</span>
                        <span class="info-value">
                            <span class="badge badge-type">${habitacion.tipo}</span>
                        </span>
                    </div>
                    <div class="card-info-item">
                        <span class="info-label">Precio/Noche</span>
                        <span class="info-value" style="color: var(--primary); font-size: 1.1rem; font-weight: 700;">
                            ${habitacion.precio} €
                        </span>
                    </div>
                    <div class="card-info-item">
                        <span class="info-label">Estado</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${habitacion.disponible}">
                                    <span class="badge badge-success">Disponible</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">Ocupada / No disp.</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="card-actions">
                        <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}"><a href="${pageContext.request.contextPath}/habitaciones/editar/${habitacion.id}" class="btn btn-primary">
                            <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                            </svg>
                            Editar Datos
                        </a></c:if>
                        <a href="${pageContext.request.contextPath}/habitaciones" class="btn btn-outline">
                            Volver al listado
                        </a>
                    </div>
                </div>
            </div>

            <!-- Incidencias -->
            <div class="incidents-card">
                <div class="incidents-header">
                    <h3 class="incidents-title">
                        <svg fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                        </svg>
                        Historial de Incidencias
                        <span class="incidents-count-badge">${fn:length(habitacion.incidencias)}</span>
                    </h3>
                    <div class="incidents-header-actions">
                        <a href="${pageContext.request.contextPath}/incidencias?habitacionId=${habitacion.id}" class="btn-view-incidents">
                            <svg width="15" height="15" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 10h16M4 14h16M4 18h16"/>
                            </svg>
                            Ver listado
                        </a>
                        <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}"><a href="${pageContext.request.contextPath}/incidencias/nueva?habitacionId=${habitacion.id}&habitacionNumero=${habitacion.numero}" class="btn-add-incident">
                            <svg width="15" height="15" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/>
                            </svg>
                            Nueva incidencia
                        </a></c:if>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty habitacion.incidencias}">
                        <c:forEach var="inc" items="${habitacion.incidencias}">
                            <div class="incident-item">
                                <div class="incident-meta">
                                    <div class="incident-meta-left">
                                        <c:choose>
                                            <c:when test="${inc.estado == 'abierto' || inc.estado == 'abierta'}">
                                                <span class="badge badge-status-abierto">Abierta</span>
                                            </c:when>
                                            <c:when test="${inc.estado == 'en curso'}">
                                                <span class="badge badge-status-en-curso">En Curso</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-status-cerrado">Cerrada</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${inc.prioridad == 'alta'}">
                                                <span class="badge badge-priority-alta">Prioridad Alta</span>
                                            </c:when>
                                            <c:when test="${inc.prioridad == 'media'}">
                                                <span class="badge badge-priority-media">Prioridad Media</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-priority-baja">Prioridad Baja</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <span class="incident-date">Reporte #${inc.id}</span>
                                </div>
                                <div class="incident-desc">${inc.descripcion}</div>
                                <div class="incident-dates-grid">
                                    <div class="date-block">
                                        <span class="date-label">Apertura</span>
                                        <span class="date-val">${inc.fechaApertura}</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="incidents-empty">
                            <svg fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"/>
                            </svg>
                            <h4>¡Excelente! Sin incidencias</h4>
                            <p>Esta habitación no registra incidencias pendientes ni históricas.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

</body>
</html>
