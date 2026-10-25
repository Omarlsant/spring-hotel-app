<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringHotelApp | Login</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">

    <h2>Bienvenido a la Gestion de Hotel</h2>
    <p>Por favor, ingrese sus credenciales (Intenta recepcion1 y recep123)</p>

    <!-- Caja de advertencia controlada -->
    <c:if test="${not empty errorDeLogin}">
        <div style="color: red; border: 1px solid red; padding: 10px; margin-bottom: 20px; width: 300px;">
            <strong>Aviso:</strong> ${errorDeLogin}
        </div>
    </c:if>

    <!-- Formulario dispara por POST a LoginController -->
    <form:form action="${pageContext.request.contextPath}/login" method="POST"
               modelAttribute="loginForm" cssStyle="max-width: 300px;">
        
        <div style="margin-bottom: 15px;">
            <label for="username" style="display: block;">Usuario:</label>
            <form:input path="username" id="username" cssStyle="width: 100%; padding: 5px;" required="required" />
        </div>
        
        <div style="margin-bottom: 15px;">
            <label for="password" style="display: block;">Contraseña:</label>
            <form:password path="password" id="password" cssStyle="width: 100%; padding: 5px;" required="required" />
        </div>
        
        <button type="submit" style="padding: 10px; width: 100%;">Iniciar Sesion</button>
    </form:form>

</body>
</html>