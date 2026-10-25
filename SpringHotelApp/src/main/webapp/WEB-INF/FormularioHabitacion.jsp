<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty habitacion.id ? 'Registrar Habitación' : 'Editar Habitación'} | Spring Hotel</title>
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

    <!-- Form Container -->
    <div class="form-container">
        <a href="${pageContext.request.contextPath}/habitaciones" class="back-link">
            <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            Volver al listado
        </a>

        <div class="form-card">
            <h1 class="form-title">
                <c:choose>
                    <c:when test="${empty habitacion.id}">
                        Registrar Nueva Habitación
                    </c:when>
                    <c:otherwise>
                        Editar Habitación ${habitacion.numero}
                    </c:otherwise>
                </c:choose>
            </h1>
            <p class="form-subtitle">
                <c:choose>
                    <c:when test="${empty habitacion.id}">
                        Introduce los detalles para registrar una nueva habitación en el inventario.
                    </c:when>
                    <c:otherwise>
                        Modifica los valores correspondientes a la habitación registrada.
                    </c:otherwise>
                </c:choose>
            </p>

            <form:form action="${pageContext.request.contextPath}/habitaciones/guardar"
                       method="POST" modelAttribute="habitacion">
                <form:hidden path="id" />

                <c:choose>
                    <c:when test="${empty habitacion.id}">
                        <div class="form-group">
                            <label for="numero" class="form-label">Número de Habitación</label>
                            <form:input path="numero" id="numero" cssClass="form-input"
                                   placeholder="Ej. 104" required="required" />
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form:hidden path="numero" />
                    </c:otherwise>
                </c:choose>

                <div class="form-group">
                    <label for="tipo" class="form-label">Tipo de Habitación</label>
                    <form:select path="tipo" id="tipo" cssClass="form-input" required="required">
                        <form:option value="" label="-- Selecciona un tipo --" />
                        <form:option value="Individual" label="Individual" />
                        <form:option value="Doble" label="Doble" />
                        <form:option value="Suite" label="Suite" />
                        <form:option value="Familiar" label="Familiar" />
                    </form:select>
                </div>

                <div class="form-group">
                    <label for="precio" class="form-label">Precio por Noche (€)</label>
                    <form:input path="precio" type="number" id="precio" cssClass="form-input"
                           placeholder="Ej. 75.00" step="0.01" min="0" required="required" />
                </div>

                <div class="form-group">
                    <label class="form-label">Estado de Disponibilidad</label>
                    <div class="radio-grid">
                        <label class="radio-card ${habitacion.id == null || habitacion.disponible ? 'selected' : ''}" id="lbl-disp-true">
                            <form:radiobutton path="disponible" value="true"
                                   onclick="updateRadioCards(true)" />
                            <div class="radio-info">
                                <span class="radio-title">Disponible</span>
                                <span class="radio-desc">Lista para recibir huéspedes</span>
                            </div>
                        </label>
                        <label class="radio-card ${habitacion.id != null && !habitacion.disponible ? 'selected' : ''}" id="lbl-disp-false">
                            <form:radiobutton path="disponible" value="false"
                                   onclick="updateRadioCards(false)" />
                            <div class="radio-info">
                                <span class="radio-title">No Disponible</span>
                                <span class="radio-desc">Fuera de servicio / Ocupada</span>
                            </div>
                        </label>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/habitaciones" class="btn btn-ghost">Cancelar</a>
                    <button type="submit" class="btn btn-primary">
                        <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                        </svg>
                        Guardar Habitación
                    </button>
                </div>
            </form:form>
        </div>
    </div>

    <script>
        function updateRadioCards(isAvailable) {
            const cardTrue  = document.getElementById('lbl-disp-true');
            const cardFalse = document.getElementById('lbl-disp-false');
            if (isAvailable) {
                cardTrue.classList.add('selected');
                cardFalse.classList.remove('selected');
            } else {
                cardTrue.classList.remove('selected');
                cardFalse.classList.add('selected');
            }
        }
    </script>
</body>
</html>
