<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty incidencia.id ? 'Nueva Incidencia' : 'Editar Incidencia'} | Spring Hotel</title>
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

    <div class="form-container">

        <a href="${pageContext.request.contextPath}/incidencias" class="back-link">
            <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
            </svg>
            Volver al listado
        </a>

        <div class="form-card">
            <h1 class="form-title">
                <c:choose>
                    <c:when test="${empty incidencia.id}">Nueva Incidencia</c:when>
                    <c:otherwise>Editar Incidencia #${incidencia.id}</c:otherwise>
                </c:choose>
            </h1>
            <p class="form-subtitle">
                <c:choose>
                    <c:when test="${empty incidencia.id}">Rellena los datos para registrar una nueva incidencia.</c:when>
                    <c:otherwise>Modifica los campos que necesites actualizar.</c:otherwise>
                </c:choose>
            </p>

            <form:form modelAttribute="incidencia" method="post"
                       action="${pageContext.request.contextPath}/incidencias">

                <form:hidden path="id"/>
                <form:hidden path="fechaApertura"/>

                <!-- Habitación -->
                <div class="form-group">
                    <label class="form-label">Habitación</label>
                    <c:choose>
                        <%-- Edición: habitación fija, no editable --%>
                        <c:when test="${not empty incidencia.id}">
                            <div class="hab-banner">
                                <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                                </svg>
                                Habitación <strong>${incidencia.habitacion.numero}</strong>
                                <span style="margin-left:auto; font-size:0.8rem; opacity:0.75;">no editable</span>
                            </div>
                            <form:hidden path="habitacion.id"/>
                        </c:when>
                        <%-- Nueva desde DetalleHabitacion: habitación fija --%>
                        <c:when test="${not empty incidencia.habitacion.id}">
                            <div class="hab-banner">
                                <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                                </svg>
                                Habitación <strong>${not empty habitacionNumero ? habitacionNumero : incidencia.habitacion.numero}</strong>
                                <span style="margin-left:auto; font-size:0.8rem; opacity:0.75;">fijada desde el detalle</span>
                            </div>
                            <form:hidden path="habitacion.id"/>
                        </c:when>
                        <%-- Nueva sin habitación: select libre --%>
                        <c:otherwise>
                            <select name="habitacion.id" class="form-input" style="cursor:pointer;">
                                <option value="">-- Selecciona una habitación --</option>
                                <c:forEach var="hab" items="${habitaciones}">
                                    <option value="${hab.id}"
                                        ${incidencia.habitacion.id == hab.id ? 'selected' : ''}>
                                        ${hab.numero}
                                    </option>
                                </c:forEach>
                            </select>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Descripción -->
                <div class="form-group">
                    <label class="form-label">Descripción</label>
                    <form:textarea path="descripcion" cssClass="form-input" rows="4"
                                   placeholder="Describe el problema o incidencia detectada..."/>
                </div>

                <!-- Estado -->
                <div class="form-group">
                    <label class="form-label">Estado</label>
                    <div class="chip-group" id="estadoGroup">
                        <label class="chip-label abierta" data-value="abierta">
                            <input type="radio" name="estadoRadio" value="abierta"/>
                            <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M12 8v4m0 4h.01"/>
                            </svg>
                            Abierta
                        </label>
                        <label class="chip-label en-curso" data-value="en curso">
                            <input type="radio" name="estadoRadio" value="en curso"/>
                            <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            En curso
                        </label>
                        <label class="chip-label cerrada" data-value="cerrada">
                            <input type="radio" name="estadoRadio" value="cerrada"/>
                            <svg width="14" height="14" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                            </svg>
                            Cerrada
                        </label>
                    </div>
                    <form:hidden path="estado" id="estadoHidden"/>
                </div>

                <!-- Prioridad -->
                <div class="form-group">
                    <label class="form-label">Prioridad</label>
                    <div class="chip-group" id="prioridadGroup">
                        <label class="chip-label baja"  data-value="baja"><input type="radio" name="prioridadRadio" value="baja"/>Baja</label>
                        <label class="chip-label media" data-value="media"><input type="radio" name="prioridadRadio" value="media"/>Media</label>
                        <label class="chip-label alta"  data-value="alta"><input type="radio" name="prioridadRadio" value="alta"/>⚠ Alta</label>
                    </div>
                    <form:hidden path="prioridad" id="prioridadHidden"/>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/incidencias" class="btn btn-ghost">Cancelar</a>
                    <button type="submit" class="btn btn-primary">
                        <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                        </svg>
                        Guardar Incidencia
                    </button>
                </div>

            </form:form>
        </div>
    </div>

    <script>
        function initChipGroup(groupId, hiddenId, currentValue) {
            const group  = document.getElementById(groupId);
            const hidden = document.getElementById(hiddenId);
            const chips  = group.querySelectorAll('.chip-label');

            chips.forEach(chip => {
                const val = chip.dataset.value;
                if (currentValue && val === currentValue.toLowerCase()) {
                    chip.classList.add('active');
                    hidden.value = val;
                }
                chip.addEventListener('click', () => {
                    chips.forEach(c => c.classList.remove('active'));
                    chip.classList.add('active');
                    hidden.value = val;
                });
            });

            const anyActive = group.querySelector('.chip-label.active');
            if (!anyActive) {
                chips[0].classList.add('active');
                hidden.value = chips[0].dataset.value;
            }
        }

        initChipGroup('estadoGroup',    'estadoHidden',    '${incidencia.estado}');
        initChipGroup('prioridadGroup', 'prioridadHidden', '${incidencia.prioridad}');
    </script>

</body>
</html>
