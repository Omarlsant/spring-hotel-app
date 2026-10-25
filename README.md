# Spring Hotel App

Aplicación web para la gestión de un hotel desarrollada con Java y Spring MVC.
El proyecto cubre los principales procesos de operación del hotel: autenticación
de empleados, gestión de habitaciones, huéspedes, reservas e incidencias de
mantenimiento.

Este repositorio muestra una implementación de una aplicación MVC clásica,
organizada por capas y con persistencia relacional mediante Hibernate.

## Funcionalidades principales

- Autenticación de empleados y cierre de sesión.
- Gestión CRUD de habitaciones.
- Gestión CRUD de huéspedes.
- Gestión CRUD de reservas.
- Gestión CRUD de incidencias de mantenimiento.
- Asociación entre huéspedes, habitaciones, reservas e incidencias.
- Validación de fechas y prevención de reservas solapadas.
- Control de acceso según el perfil del empleado:
  - **Recepcionista**: consulta y operaciones de gestión.
  - **Supervisor**: consulta y visualización de detalles.
- Protección de rutas para evitar el acceso anónimo.
- Navegación coherente entre los módulos de la aplicación.
- Gestión controlada de errores sin mostrar información técnica al usuario.

## Arquitectura

El código sigue una arquitectura por capas:

```text
controladores  ->  servicios  ->  DAOs  ->  Hibernate / MySQL
       |
      JSP / JSTL / Spring Form Tags
```

### Organización del código

- `entidades`: entidades persistentes y relaciones ORM.
- `dao` y `daos`: contratos e implementaciones de acceso a datos.
- `servicios`: reglas de negocio y validaciones.
- `controladores`: gestión de peticiones HTTP y preparación de modelos.
- `interceptores`: protección transversal de las rutas.
- `excepciones`: excepciones específicas del dominio.
- `src/main/webapp/WEB-INF`: vistas JSP protegidas.
- `src/main/resources/sql`: scripts de creación y datos de prueba.

## Tecnologías

- Java
- Spring MVC
- Hibernate ORM
- MySQL
- JSP
- JSTL
- Spring Form Tags
- Apache Tomcat

## Decisiones técnicas destacadas

- Separación entre presentación, controladores, lógica de negocio y persistencia.
- Uso de interfaces para los contratos de acceso a datos y servicios.
- Mapeo de relaciones entre huéspedes, habitaciones, reservas e incidencias.
- Validación de reglas de negocio en la capa de servicio.
- Prevención de solapamientos de reservas para una misma habitación.
- Operaciones destructivas mediante peticiones `POST`.
- Protección de rutas en el servidor, además de ocultar acciones no permitidas
  en la interfaz.
- Gestión de errores mediante un identificador técnico, evitando exponer
  detalles internos en las vistas.

## Estructura del proyecto

```text
SpringHotelApp/
├── src/main/java/es/accenture/
│   ├── controladores/
│   ├── dao/
│   ├── daos/
│   ├── entidades/
│   ├── excepciones/
│   ├── interceptores/
│   └── servicios/
├── src/main/resources/
│   ├── sql/
│   └── application.properties.example
└── src/main/webapp/
    ├── WEB-INF/
    └── css/
```

## Ejecución local

La aplicación utiliza Spring MVC tradicional y se despliega en Apache Tomcat.
No es un proyecto Spring Boot ni dispone de una clase `main`.

Para ejecutarla localmente se necesita:

1. Java.
2. MySQL.
3. Apache Tomcat 9.
4. Configurar la conexión local a MySQL a partir de
   `SpringHotelApp/src/main/resources/application.properties.example`.
5. Ejecutar los scripts SQL de `SpringHotelApp/src/main/resources/sql/`.
6. Desplegar `SpringHotelApp` en Tomcat.

La configuración específica del entorno y las credenciales locales deben
mantenerse fuera del control de versiones.

## Calidad y validación

Antes de considerar la aplicación lista se verificaron:

- Compilación de todas las clases Java.
- Existencia de las cinco entidades y tablas principales.
- Rutas de consulta y modificación de los módulos.
- Restricciones de acceso por rol.
- Navegación entre vistas.
- Validaciones de reservas e incidencias.
- Ausencia de enlaces sin destino y eliminaciones mediante `GET`.

## Alcance

El proyecto se plantea como una aplicación formativa completa de Spring MVC,
priorizando claridad, separación de responsabilidades y buenas prácticas
aplicables a un perfil junior en desarrollo backend Java.

Las funcionalidades de búsqueda avanzada, BCrypt, logging externo y análisis
con SonarQube quedan fuera del alcance principal de esta versión.
