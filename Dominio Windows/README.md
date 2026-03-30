# 🌟 Project Overview / Descripción General del Proyecto
El directorio Ubuntu Server forma parte del ecosistema Windows Server – Zabbix – GLPI y contiene los recursos necesarios para desplegar, documentar y operar un servidor Ubuntu destinado a servicios críticos como Zabbix (monitorización) y GLPI (gestión de activos e ITSM).
Su propósito es centralizar documentación, medios y configuraciones relacionados con el despliegue en Linux dentro del proyecto global.
El núcleo del directorio es el documento `DocumentoExplicación.pdf`, que describe el proceso de instalación, configuración y puesta en marcha de los servicios, así como aspectos de integración con el ecosistema completo.

## 🚀 Key Features / Funcionalidades Clave
- **Guía de instalación y configuración de Ubuntu Server**: El documento principal incluye los pasos para preparar un servidor Ubuntu, instalar dependencias y optimizar la máquina para su rol dentro del ecosistema.
- **Despliegue de Zabbix Server y Zabbix Agent**: Explicación detallada de la instalación del servidor de monitorización, configuración de la base de datos, frontend web, servicios, así como la instalación del agente para monitorear el propio host.
- **Instalación y Preparación de GLPI**: Instrucciones para instalar GLPI en Ubuntu, configurar PHP, servidor web y base de datos, así como recomendaciones de seguridad.
- **Carpeta de Recursos Multimedia para GLPI**: El directorio `Archivos Tipo de Medio GLPI` contiene los parámetros y script utilizados dentro de GLPI para crear el tipo de medio correctamente.
- **Integración Zabbix – GLPI**: Explicaciones generales para vincular eventos de monitorización con la gestión de tickets e inventarios dentro de GLPI.


## 🛠️ Tech Stack / Tecnologías Utilizadas
- **Ubuntu Server**Plataforma de monitorización de redes, servidores y servicios.Empleado para manejar solicitudes y potencialmente interactuar con bases de datos.
- **Zabbix**: Usado para interacciones con la base de datos, incluyendo consultas y modificaciones de datos.
- **GLPI**: Sistema ITSM y de gestión de activos TI.
- **Apache / Nginx**: Servidor web para GLPI y frontend de Zabbix.
- **PHP**: Lenguaje requerido para el frontend de GLPI y Zabbix.
- **MySQL / MariaDB**: Motor de base de datos utilizado por ambos sistemas.
- **Zabbix Agent**: Agente de monitoreo para el host Ubuntu.
- **GNU/Linux Tools**: Herramientas de administración, permisos, redes y automatización.


## 💻 Uso
- **Desplpiegue de Ubuntu Server**: Sigue las instrucciones del documento PDF para preparar la máquina, actualizar paquetes y configurar servicios base.
- **Instalación de Zabbix**: Implementa el servidor de monitorización, frontend y base de datos según la guía.
- **Instalación de GLPI**: Configura el sistema ITSM, sus dependencias PHP y el servidor web.
- **Uso de recursos GLPI**: La carpeta de medios puede importarse desde la interfaz de GLPI para enriquecer su clasificación de activos.
- **Integración con el Ecosistema Completo**: El contenido del directorio forma parte de un proyecto mayor donde Ubuntu Server complementa los despliegues en Windows Server y provee servicios centrales.

## 🤝 Contribuciones
Las contribuciones son bienvenidas. Para contribuir, haz un fork del repositorio, realiza tus cambios y envía un pull request.

## 📝 Licencia
Este proyecto está licenciado bajo la Licencia MIT.
