<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SpringHotelApp | Algo Fallo</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #ffe6e6; margin: 40px;">

    <h2 style="color: darkred;">¡Uy! Algo salio mal dentro de la plataforma</h2>
    <p>Hemos interceptado un problema en nuestro lado. El desarrollador ya recibio los registros en su consola de servidor.</p>

    <div style="background: white; border-left: 5px solid red; padding: 20px;">
        <p>No se ha podido completar la operación. Facilita este identificador al responsable de la aplicación:</p>
        <p><strong>Identificador:</strong> ${errorId}</p>
    </div>

    <br>
    <a href="${pageContext.request.contextPath}/login" style="padding: 10px; background-color: gray; color: white; text-decoration: none;">Volver al Inicio</a>

</body>
</html>