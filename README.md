# Ecosistema Windows Server + Zabbix + GLPI

Este proyecto reúne un ecosistema funcional orientado a la gestión integral de infraestructura IT.

![Diagrama del ecosistema](https://github.com/farnacho/Ecosistema-Windows-Server-Zabbix-GLPI/releases/download/v1.0/ImagenEcosistema.png)Combina **Windows Server**, **Zabbix**, **GLPI** y **WireGuard** para cubrir necesidades de administración de dominios, monitoreo, helpdesk y acceso seguro.

El objetivo principal es **resolver problemas reales del entorno IT**, al tiempo que sirve como un laboratorio para **experimentar, aprender y validar habilidades técnicas**.

---

## 🎯 Objetivos del Proyecto

* Gestionar usuarios y equipos dentro de un dominio Windows Server.
* Implementar monitoreo de servicios, hosts y aplicaciones mediante Zabbix.
* Gestionar tickets para el departamento IT usando GLPI.
* Establecer conectividad segura mediante VPN WireGuard.
* Explorar herramientas y metodologías para mejorar habilidades técnicas.

---

## 🛠️ Tecnologías utilizadas

* **Windows Server**
* **Ubuntu Server**
* **PowerShell**
* **Zabbix**
* **GLPI**
* **WireGuard VPN**

---

## 📦 Requisitos e Instalación

El proyecto no tiene coste económico. Requiere tiempo de aprendizaje, despliegue y práctica de cada una de las tecnologías involucradas.

---

## 📂 Mini Guía de Uso

### 🔑 Windows Server — Gestión de Dominio

* Crear y configurar el dominio.
* Gestionar usuarios y equipos.
* Crear y aplicar GPO básicas.

### 📡 Zabbix — Monitoreo

* Instalar Zabbix Server en Ubuntu.
* Configurar base de datos y frontend.
* Añadir agentes o SNMP a los equipos.
* Crear triggers, alertas y dashboards.

### 🎫 GLPI — Helpdesk

* Instalar GLPI en Ubuntu.
* Configurar perfiles y categorías.
* Crear y gestionar tickets.
* Integrar inventario (opcional).

### 🔐 WireGuard — VPN

* Configurar servidor WireGuard.
* Generar claves para clientes.
* Permitir acceso seguro a los servicios.

---

## 🔄 Workflow recomendado

1. **Configuración del Dominio** en Windows Server.
2. **Despliegue de Servicios** Zabbix y GLPI en Ubuntu.
3. **Integración de Hosts** del dominio con Zabbix.
4. **Configuración de Helpdesk** en GLPI.
5. **Montaje de la VPN** para acceder a recursos de forma segura.
6. **Pruebas, Ajustes y Documentación** continua.

---

## 👤 Autor

**Nacho Abad Rodríguez**
