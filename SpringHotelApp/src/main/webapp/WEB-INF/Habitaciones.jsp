<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Habitaciones | Spring Hotel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/spring-hotel.css" rel="stylesheet">
</head>
<body>

    <!-- Navbar -->
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
        <!-- Header -->
        <div class="page-header">
            <div class="page-title">
                <h1>Panel de Habitaciones</h1>
                <p>Gestiona el inventario de habitaciones del hotel, tarifas y disponibilidad en tiempo real.</p>
            </div>
            <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}"><a href="${pageContext.request.contextPath}/habitaciones/nuevo" class="btn btn-primary">
                <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                </svg>
                Añadir Habitación
            </a></c:if>
        </div>

        <!-- KPI calculations -->
        <c:set var="total" value="${fn:length(listaHabitaciones)}" />
        <c:set var="disponibles" value="0" />
        <c:forEach var="h" items="${listaHabitaciones}">
            <c:if test="${h.disponible}">
                <c:set var="disponibles" value="${disponibles + 1}" />
            </c:if>
        </c:forEach>
        <c:set var="noDisponibles" value="${total - disponibles}" />

        <!-- KPIs -->
        <div class="kpi-grid">
            <div class="kpi-card">
                <div class="kpi-icon primary">
                    <svg fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                    </svg>
                </div>
                <div class="kpi-info">
                    <span class="kpi-value">${total}</span>
                    <span class="kpi-label">Total Habitaciones</span>
                </div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon success">
                    <svg fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                </div>
                <div class="kpi-info">
                    <span class="kpi-value">${disponibles}</span>
                    <span class="kpi-label">Disponibles</span>
                </div>
            </div>
            <div class="kpi-card">
                <div class="kpi-icon danger">
                    <svg fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                </div>
                <div class="kpi-info">
                    <span class="kpi-value">${noDisponibles}</span>
                    <span class="kpi-label">No Disponibles / En Ocupación</span>
                </div>
            </div>
        </div>

        <!-- Tabla -->
        <div class="table-card">
            <div class="table-header">
                <h2>Inventario General de Habitaciones</h2>
            </div>

            <c:choose>
                <c:when test="${not empty listaHabitaciones}">
                    <table class="modern-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nº Habitación</th>
                                <th>Tipo</th>
                                <th>Precio por Noche</th>
                                <th>Disponibilidad</th>
                                <th style="text-align: right;">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${listaHabitaciones}">
                                <tr>
                                    <td style="font-weight: 600; color: var(--text-muted);">#${h.id}</td>
                                    <td style="font-weight: 700; font-size: 1.05rem;">${h.numero}</td>
                                    <td><span class="badge badge-type">${h.tipo}</span></td>
                                    <td style="font-weight: 600; color: var(--primary);">${h.precio} €</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${h.disponible}">
                                                <span class="badge badge-success">Disponible</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Ocupada</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="actions-cell">
                                        <a href="${pageContext.request.contextPath}/habitaciones/${h.id}" class="btn btn-outline-primary btn-sm">
                                            <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                            </svg>
                                            Detalle
                                        </a>
                                        <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}"><a href="${pageContext.request.contextPath}/habitaciones/editar/${h.id}" class="btn btn-outline-warning btn-sm">
                                            <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                                            </svg>
                                            Editar
                                        </a>
                                        <form method="post" action="${pageContext.request.contextPath}/habitaciones/eliminar" style="display:inline">
                                           <input type="hidden" name="id" value="${h.id}">
                                        <button type="submit"
                                           class="btn btn-outline-danger btn-sm"
                                           onclick="return confirm('¿Estás seguro de que deseas eliminar la habitación ${h.numero}? Esta acción no se puede deshacer.');">
                                            <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                            </svg>
                                            Eliminar
                                        </button></form></c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <svg viewBox="0 0 24 24">
                            <path d="M20 6h-8l-2-2H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm0 12H4V8h16v10z"/>
                        </svg>
                        <h3>No hay habitaciones registradas</h3>
                        <p style="margin-bottom: 24px;">Comienza añadiendo la primera habitación de tu catálogo hotelero.</p>
                        <c:if test="${usuarioLogueado.rol == 'RECEPCIONISTA'}">
                            <a href="${pageContext.request.contextPath}/habitaciones/nuevo" class="btn btn-primary">Añadir Habitación</a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</body>
</html>
