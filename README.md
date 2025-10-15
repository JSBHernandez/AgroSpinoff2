# 🌾 AgroTechNova - Plataforma de Gestión Agroindustrial# AgroTechNova - Plataforma de Gestión Agroindustrial# 🌾 AgroTechNova - Plataforma de Gestión Agroindustrial# 🌾 AgroTechNova - Plataforma de Gestión Agroindustrial



**Proyecto Integrador 1 - Universidad Pontificia Bolivariana**



Sistema web para la gestión integral de proyectos agroindustriales, recursos, presupuestos e inventario.**Proyecto Integrador 1 - Universidad Pontificia Bolivariana**



---



## 📑 Tabla de ContenidosSistema web para la gestión integral de proyectos agroindustriales, desarrollado con **Node.js puro** (sin frameworks externos) como ejercicio académico.![Estado](https://img.shields.io/badge/Estado-Sprint%201%20Completado-success)**Proyecto Integrador 1 - Universidad Pontificia Bolivariana**



- [Descripción del Proyecto](#-descripción-del-proyecto)

- [Estructura del Proyecto](#-estructura-del-proyecto)

- [Tecnologías Utilizadas](#-tecnologías-utilizadas)---![Node](https://img.shields.io/badge/Node.js-v14%2B-green)

- [Instalación y Configuración](#-instalación-y-configuración)

- [Ejecutar el Proyecto](#-ejecutar-el-proyecto)

- [Credenciales de Acceso](#-credenciales-de-acceso)

- [Arquitectura del Sistema](#-arquitectura-del-sistema)## Tabla de Contenidos![Licencia](https://img.shields.io/badge/Licencia-Acad%C3%A9mico-blue)Sistema web para la gestión integral de proyectos agroindustriales, recursos, presupuestos e inventario.

- [Plan de Desarrollo por Sprints](#-plan-de-desarrollo-por-sprints)

- [Requerimientos Implementados](#-requerimientos-implementados)



---- [Descripción del Proyecto](#descripción-del-proyecto)



## 🎯 Descripción del Proyecto- [Stack Tecnológico](#stack-tecnológico)



AgroTechNova es una plataforma web diseñada para centralizar la gestión de proyectos agroindustriales, permitiendo:- [Requisitos Previos](#requisitos-previos)**Proyecto Integrador 1 - Universidad Pontificia Bolivariana**---



- ✅ Gestión de usuarios con roles y permisos- [Instalación](#instalación)

- ✅ Control de proyectos por fases y hitos

- ✅ Administración de recursos y presupuestos- [Ejecutar el Proyecto](#ejecutar-el-proyecto)

- ✅ Inventario de insumos y productos

- ✅ Generación de reportes y métricas- [Estructura del Proyecto](#estructura-del-proyecto)

- ✅ Sistema de asesorías y colaboración

- [Credenciales de Prueba](#credenciales-de-prueba)Sistema web para la gestión integral de proyectos agroindustriales, desarrollado con **Node.js puro** (sin frameworks externos) como ejercicio académico.## � Tabla de Contenidos

**Contexto Académico:** Proyecto Integrador 1  

**Institución:** Universidad Pontificia Bolivariana  - [Pruebas Funcionales](#pruebas-funcionales)

**Enfoque:** Código limpio, modular y académico (sin frameworks externos)

- [Requerimientos Implementados](#requerimientos-implementados)

---

- [Resolución de Problemas](#resolución-de-problemas)

## 📁 Estructura del Proyecto

---- [Descripción del Proyecto](#-descripción-del-proyecto)

```

AgroSpinoff2/---

│

├── 📄 server.js                    # Servidor HTTP principal (Node.js puro)- [Estructura del Proyecto](#-estructura-del-proyecto)

├── 📄 package.json                 # Configuración del proyecto

├── 📄 .env.example                 # Variables de entorno de ejemplo## Descripción del Proyecto

├── 📄 .gitignore                   # Archivos ignorados por git

│## 📑 Tabla de Contenidos- [Tecnologías Utilizadas](#-tecnologías-utilizadas)

├── 📁 src/                         # CÓDIGO BACKEND

│   ├── 📁 controllers/             # Lógica de negocio**AgroTechNova** es una plataforma web diseñada para centralizar la gestión de proyectos agroindustriales en el sector del agro colombiano.

│   │   ├── authController.js       # Autenticación y sesiones

│   │   ├── userController.js       # Gestión de usuarios- [Instalación y Configuración](#-instalación-y-configuración)

│   │   └── README.md               # Documentación de controladores

│   ├── 📁 models/                  # Modelos de datos (BD)### Contexto Académico

│   │   ├── roleModel.js            # Modelo de roles

│   │   ├── userModel.js            # Modelo de usuarios- [🎯 Descripción del Proyecto](#-descripción-del-proyecto)- [Arquitectura del Sistema](#-arquitectura-del-sistema)

│   │   └── README.md               # Documentación de modelos

│   ├── 📁 routes/                  # Rutas de la API REST- **Institución:** Universidad Pontificia Bolivariana (UPB)

│   │   ├── authRoutes.js           # Rutas de autenticación

│   │   ├── userRoutes.js           # Rutas de usuarios- **Asignatura:** Proyecto Integrador 1- [🧰 Stack Tecnológico](#-stack-tecnológico)- [Plan de Desarrollo por Sprints](#-plan-de-desarrollo-por-sprints)

│   │   └── README.md               # Documentación de rutas

│   ├── 📁 middlewares/             # Autenticación, validación, etc.- **Fecha:** Octubre 2025

│   │   ├── authMiddleware.js       # Middleware de autenticación

│   │   └── README.md               # Documentación de middlewares- **Objetivo:** Aplicar conceptos de desarrollo web full-stack con tecnologías nativas sin frameworks externos- [🧭 Requisitos Previos](#-requisitos-previos)- [Requerimientos Implementados](#-requerimientos-implementados)

│   ├── 📁 utils/                   # Funciones utilitarias

│   │   ├── crypto.js               # Cifrado de contraseñas (PBKDF2)

│   │   ├── validators.js           # Validaciones de entrada

│   │   ├── sessionManager.js       # Gestión de sesiones### Funcionalidades Principales- [🧪 Instalación](#-instalación)

│   │   └── README.md               # Documentación de utils

│   └── 📁 db/                      # Configuración de base de datos

│       ├── database.js             # Clase de conexión SQLite

│       ├── migrations.js           # Migraciones e inicialización- **Autenticación y Autorización** - Sistema de login seguro con roles (administrador, asesor, productor)- [🚀 Ejecutar el Proyecto](#-ejecutar-el-proyecto)---

│       └── README.md               # Documentación de BD

│- **Gestión de Usuarios** - CRUD completo con activación/desactivación

├── 📁 database/                    # Base de datos SQLite (auto-generada)

│   └── agrotechnova.db             # Archivo de base de datos- **Control de Sesiones** - Manejo de sesiones con expiración automática- [📂 Estructura del Proyecto](#-estructura-del-proyecto)

│

├── 📁 pages/                       # CÓDIGO FRONTEND (HTML)- **Recuperación de Contraseña** - Sistema simulado de recuperación

│   ├── Pagina.html                 # Página principal

│   ├── login.html                  # Inicio de sesión- [🔐 Credenciales de Prueba](#-credenciales-de-prueba)## 🎯 Descripción del Proyecto

│   ├── register.html               # Registro de usuarios

│   ├── dashboard.html              # Panel principal---

│   ├── usuarios.html               # Gestión de usuarios (admin)

│   ├── agendaReuniones.html        # Programación de reuniones- [🧪 Pruebas Funcionales](#-pruebas-funcionales)

│   ├── contacto.html               # Página de contacto

│   ├── mision-vision.html          # Misión y visión## Stack Tecnológico

│   ├── objetivos.html              # Objetivos del proyecto

│   └── servicios.html              # Servicios ofrecidos- [🧠 Notas para Desarrolladores](#-notas-para-desarrolladores)AgroTechNova es una plataforma web diseñada para centralizar la gestión de proyectos agroindustriales, permitiendo:

│

├── 📁 public/                      # ARCHIVOS ESTÁTICOS### Backend

│   ├── 📁 css/                     # Hojas de estilo

│   │   ├── Pagina.css- **Node.js v14+** (sin Express u otros frameworks)- [📋 Requerimientos Implementados](#-requerimientos-implementados)

│   │   ├── login.css

│   │   ├── dashboard.css- **SQLite3** - Base de datos ligera en archivo

│   │   └── ...

│   └── 📁 js/                      # Scripts del frontend- [🌐 Roadmap](#-roadmap)- ✅ Gestión de usuarios con roles y permisos

│

├── 📁 images/                      # IMÁGENES### Frontend

│   ├── logo.png

│   ├── campo1.jpg- **HTML5** - Estructura semántica- ✅ Control de proyectos por fases y hitos

│   ├── campo2.jpg

│   └── fondo.png- **CSS3** - Estilos personalizados (sin Bootstrap/Tailwind)

│

└── 📁 temp/                        # DOCUMENTACIÓN TEMPORAL- **JavaScript Vanilla** - Sin React, Vue, Angular---- ✅ Administración de recursos y presupuestos

    └── REQUERIMIENTOS FINAL (1).txt

```



---### Seguridad- ✅ Inventario de insumos y productos



## 💻 Tecnologías Utilizadas- **PBKDF2** - Hash de contraseñas con 10,000 iteraciones (SHA-512)



### Backend- **Cookies HttpOnly** - Protección contra XSS## 🎯 Descripción del Proyecto- ✅ Generación de reportes y métricas

- **Node.js** (v14+) - Servidor HTTP nativo

- **SQLite3** - Base de datos relacional- **Validaciones** - Input sanitization en backend

- **Crypto (nativo)** - Cifrado de contraseñas (PBKDF2)

- ✅ Sistema de asesorías y colaboración

### Frontend

- **HTML5** - Estructura de páginas### Base de Datos

- **CSS3** - Estilos y diseño responsive

- **JavaScript Vanilla** - Interactividad del cliente```**AgroTechNova** es una plataforma web diseñada para centralizar la gestión de proyectos agroindustriales en el sector del agro colombiano.



### Sin FrameworksTablas:

- ❌ No Express

- ❌ No React/Vue/Angular- roles (id, nombre, descripcion, permisos)**Contexto Académico:** Proyecto Integrador 1  

- ❌ No Bootstrap/Tailwind

- ✅ Solo tecnologías nativas- usuarios (id, nombre, email, password_hash, rol_id, estado)



---```### 🎓 Contexto Académico**Institución:** Universidad Pontificia Bolivariana  



## 🚀 Instalación y Configuración



### 1. Clonar el repositorio---**Enfoque:** Código limpio, modular y académico (sin frameworks externos)

```bash

git clone https://github.com/JSBHernandez/AgroSpinoff2.git

cd AgroSpinoff2

```## Requisitos Previos- **Institución:** Universidad Pontificia Bolivariana (UPB)



### 2. Instalar dependencias

```bash

npm installAntes de instalar el proyecto, asegúrate de tener:- **Asignatura:** Proyecto Integrador 1---

```



**Nota:** Solo se instala `sqlite3` como dependencia externa.

### 1. Node.js (obligatorio)- **Fecha:** Octubre 2025

### 3. Configurar variables de entorno (opcional)

```bash```bash

cp .env.example .env

# Editar .env con tus configuraciones# Verificar instalación- **Objetivo:** Aplicar conceptos de desarrollo web full-stack con tecnologías nativas sin frameworks externos## 📁 Estructura del Proyecto

```

node --version  # Debe ser v14.0.0 o superior

---

npm --version   # Debe estar instalado con Node.js

## ▶️ Ejecutar el Proyecto

```

### Iniciar el servidor

```bash### ✨ Funcionalidades Principales```

node server.js

```**Descargar:** https://nodejs.org/ (se recomienda la versión LTS)



**Salida esperada:**AgroSpinoff2/

```

🔧 Inicializando base de datos...### 2. Git (recomendado)

✅ Conexión exitosa a la base de datos SQLite

🔗 Claves foráneas habilitadas```bash- ✅ **Autenticación y Autorización** - Sistema de login seguro con roles (administrador, asesor, productor)│

✅ Tabla "roles" creada correctamente

✅ Tabla "usuarios" creada correctamente# Verificar instalación

✅ Rol "administrador" insertado

✅ Rol "asesor" insertadogit --version- ✅ **Gestión de Usuarios** - CRUD completo con activación/desactivación├── 📄 server.js                    # Servidor HTTP principal (Node.js puro)

✅ Rol "productor" insertado

✅ Usuario administrador creado:```

   📧 Email: admin@agrotechnova.com

   🔑 Password: Admin123!- ✅ **Control de Sesiones** - Manejo de sesiones con expiración automática├── 📄 package.json                 # Configuración del proyecto

✅ Base de datos lista

🧹 Limpiador de sesiones iniciado (cada 15 minutos)**Descargar:** https://git-scm.com/

==================================================

🚀 SERVIDOR AGROTECHNOVA INICIADO- ✅ **Recuperación de Contraseña** - Sistema simulado de recuperación├── 📄 .env.example                 # Variables de entorno de ejemplo

==================================================

📡 Servidor corriendo en: http://127.0.0.1:3000---

⏰ Hora de inicio: [fecha actual]

==================================================- 🔜 **Gestión de Proyectos** - (Sprint 2)├── 📄 .gitignore                   # Archivos ignorados por git

📋 ENDPOINTS DISPONIBLES:

   POST /api/auth/login## Instalación

   POST /api/auth/logout

   GET  /api/auth/session- 🔜 **Control de Inventario** - (Sprint 3)│

   POST /api/auth/forgot-password

   GET  /api/users (admin)### Opción 1: Clonar desde GitHub

   POST /api/users (admin)

   GET  /api/roles (autenticado)- 🔜 **Reportes y Métricas** - (Sprint 4)├── 📁 src/                         # CÓDIGO BACKEND

==================================================

``````bash



### Acceder a la aplicación# 1. Clonar el repositorio│   ├── 📁 controllers/             # Lógica de negocio

Abrir en el navegador:

- **Login:** `http://localhost:3000/login`git clone https://github.com/JSBHernandez/AgroSpinoff2.git

- **Página principal:** `http://localhost:3000/`

- **Panel de usuarios (admin):** `http://localhost:3000/usuarios`---│   │   └── README.md               # Documentación de controladores



### Detener el servidor# 2. Navegar a la carpeta del proyecto

```bash

Ctrl + Ccd AgroSpinoff2│   ├── 📁 models/                  # Modelos de datos (BD)

```



---

# 3. Instalar dependencias (solo sqlite3)## 🧰 Stack Tecnológico│   │   └── README.md               # Documentación de modelos

## 🔐 Credenciales de Acceso

npm install

### Usuario Administrador (creado automáticamente)

```│   ├── 📁 routes/                  # Rutas de la API REST

```

📧 Email:     admin@agrotechnova.com

🔑 Password:  Admin123!

👤 Rol:       Administrador### Opción 2: Descargar ZIP### Backend│   │   └── README.md               # Documentación de rutas

```



**⚠️ IMPORTANTE:** Cambiar la contraseña después del primer login por seguridad.

```bash- **Node.js v14+** (sin Express u otros frameworks)│   ├── 📁 middlewares/             # Autenticación, validación, etc.

### Crear nuevos usuarios

# 1. Descargar desde: https://github.com/JSBHernandez/AgroSpinoff2/archive/refs/heads/main.zip

1. Iniciar sesión como administrador

2. Ir a `http://localhost:3000/usuarios`# 2. Descomprimir y navegar a la carpeta- **SQLite3** - Base de datos ligera en archivo│   │   └── README.md               # Documentación de middlewares

3. Hacer clic en "Crear Usuario"

4. Completar el formulario:cd AgroSpinoff2

   - **Nombre completo** (mínimo 3 caracteres)

   - **Email válido**│   ├── 📁 utils/                   # Funciones utilitarias

   - **Contraseña segura** (8+ caracteres, mayúscula, minúscula, carácter especial)

   - **Rol** (administrador, asesor, productor)# 3. Instalar dependencias

5. Guardar

npm install### Frontend│   │   └── README.md               # Documentación de utils

---

```

## 🏗️ Arquitectura del Sistema

- **HTML5** - Estructura semántica│   └── 📁 db/                      # Configuración de base de datos

### Patrón de Diseño

**Arquitectura en Capas Simplificada (sin MVC estricto)**---



```- **CSS3** - Estilos personalizados (sin Bootstrap/Tailwind)│       ├── database.js             # Clase de conexión SQLite

┌─────────────────────────────────────────┐

│         CLIENTE (Navegador)             │## Ejecutar el Proyecto

│    HTML + CSS + JavaScript Vanilla      │

└────────────────┬────────────────────────┘- **JavaScript Vanilla** - Sin React, Vue, Angular│       └── README.md               # Documentación de BD

                 │ HTTP/HTTPS

┌────────────────▼────────────────────────┐### 1. Iniciar el Servidor

│         SERVIDOR (Node.js)              │

│  ┌─────────────────────────────────┐   ││

│  │  Routes (Enrutamiento)          │   │

│  └──────────┬──────────────────────┘   │```bash

│  ┌──────────▼──────────────────────┐   │

│  │  Middlewares (Auth, Validación) │   │node server.js### Seguridad├── 📁 database/                    # Base de datos SQLite (auto-generada)

│  └──────────┬──────────────────────┘   │

│  ┌──────────▼──────────────────────┐   │```

│  │  Controllers (Lógica Negocio)   │   │

│  └──────────┬──────────────────────┘   │- **PBKDF2** - Hash de contraseñas con 10,000 iteraciones (SHA-512)│   └── agrotechnova.db             # Archivo de base de datos

│  ┌──────────▼──────────────────────┐   │

│  │  Models (Acceso a Datos)        │   │**Salida esperada:**

│  └──────────┬──────────────────────┘   │

└─────────────┼──────────────────────────┘```- **Cookies HttpOnly** - Protección contra XSS│

              │

┌─────────────▼──────────────────────────┐Inicializando base de datos...

│      BASE DE DATOS (SQLite)            │

│       agrotechnova.db                  │Conexión exitosa a la base de datos SQLite- **Validaciones** - Input sanitization en backend├── 📁 pages/                       # CÓDIGO FRONTEND (HTML)

└────────────────────────────────────────┘

```Claves foráneas habilitadas



### Flujo de una PeticiónTabla "roles" creada correctamente│   ├── Pagina.html                 # Página principal



1. **Cliente** envía petición HTTP (ej: POST /api/auth/login)Tabla "usuarios" creada correctamente

2. **Servidor** recibe y parsea la petición

3. **Routes** identifica la ruta y dirige al controladorRol "administrador" insertado### Base de Datos│   ├── login.html                  # Inicio de sesión

4. **Middlewares** validan autenticación/autorización

5. **Controller** procesa la lógica de negocioRol "asesor" insertado

6. **Model** ejecuta consultas a la base de datos

7. **Controller** formatea respuestaRol "productor" insertado```│   ├── register.html               # Registro de usuarios

8. **Servidor** envía respuesta JSON al cliente

Usuario administrador creado:

---

   Email: admin@agrotechnova.com- roles (id, nombre, descripcion, permisos)│   ├── dashboard.html              # Panel principal

## 📆 Plan de Desarrollo por Sprints

   Password: Admin123!

### Sprint 1 - Autenticación y Base del Sistema ✅ COMPLETADO

**Requerimientos:** RF58, RF59, RF48, RF40, RF39, RF51, RF49 + RNF01, 05, 07, 11, 16  Base de datos lista- usuarios (id, nombre, email, password_hash, rol_id, estado)│   ├── agendaReuniones.html        # Programación de reuniones

**Tablas:** `usuarios`, `roles`  

**Funcionalidades:**Limpiador de sesiones iniciado (cada 15 minutos)

- ✅ Login y logout de usuarios

- ✅ Cifrado de contraseñas (PBKDF2)==================================================```│   ├── contacto.html               # Página de contacto

- ✅ Gestión de roles y permisos

- ✅ CRUD de usuariosSERVIDOR AGROTECHNOVA INICIADO

- ✅ Activar/desactivar usuarios

- ✅ Control de sesiones con expiración==================================================│   ├── mision-vision.html          # Misión y visión

- ✅ Recuperación de contraseña (simulado)

Servidor corriendo en: http://127.0.0.1:3000

### Sprint 2 - Gestión de Proyectos (Próximo)

**Requerimientos:** RF41, RF13, RF62, RF25, RF23, RF15, RF70, RF71  Hora de inicio: 15/10/2025, 4:30:00 p. m.**Diseño minimalista:** Solo 2 tablas en Sprint 1│   ├── objetivos.html              # Objetivos del proyecto

**Tablas:** `proyectos`, `fases`, `hitos`  

**Funcionalidades:**==================================================

- CRUD de proyectos

- División por fasesENDPOINTS DISPONIBLES:│   └── servicios.html              # Servicios ofrecidos

- Seguimiento de hitos

- Búsqueda y filtrado   POST /api/auth/login



### Sprint 3 - Recursos y Presupuestos   POST /api/auth/logout---│

**Requerimientos:** RF01, RF02, RF03, RF04, RF05, RF17, RF19, RF32, RF33  

**Tablas:** `recursos`, `presupuestos`, `gastos`, `asignaciones_personal`     GET  /api/auth/session

**Funcionalidades:**

- Planificación de recursos   POST /api/auth/forgot-password├── 📁 public/                      # ARCHIVOS ESTÁTICOS

- Control de presupuesto

- Asignación de personal   GET  /api/users (admin)

- Comparación de gastos

   POST /api/users (admin)## 🧭 Requisitos Previos│   ├── 📁 css/                     # Hojas de estilo

### Sprint 4 - Inventario y Proveedores

**Requerimientos:** RF06, RF08, RF09, RF16, RF18, RF43, RF45, RF29, RF31     GET  /api/roles (autenticado)

**Tablas:** `productos`, `proveedores`, `inventario`, `insumos`, `maquinaria`  

**Funcionalidades:**==================================================│   │   ├── Pagina.css

- Catálogo de productos

- Registro de proveedores```

- Control de inventario

- Insumos orgánicos/químicosAntes de instalar el proyecto, asegúrate de tener instalado:│   │   ├── login.css



### Sprint 5 - Reportes y Visualización### 2. Abrir en el Navegador

**Requerimientos:** RF28, RF52, RF53, RF54, RF55, RF56, RF57, RF60, RF61  

**Funcionalidades:**│   │   ├── dashboard.css

- Generación de reportes PDF/Excel

- Visualización de proyectos finalizados**Página de Login:**

- Catálogo de servicios

- Información institucional```### 1. Node.js (obligatorio)│   │   └── ...



### Sprint 6 - Funcionalidades Avanzadashttp://localhost:3000/login

**Requerimientos:** RF34, RF35, RF36, RF37, RF44, RF46, RF64, RF66  

**Funcionalidades:**``````bash│   └── 📁 js/                      # Scripts del frontend

- Programación de reuniones

- Copias de seguridad

- Monitoreo del sistema

- Integración con APIs externas**Rutas alternativas:**# Verificar instalación│



---```



## 📊 Requerimientos Implementadoshttp://localhost:3000/pages/login.htmlnode --version  # Debe ser v14.0.0 o superior├── 📁 images/                      # IMÁGENES



### ✅ Sprint 1 - Autenticación y Base del Sistema (COMPLETADO)http://localhost:3000/



| RF | Descripción | Estado |```npm --version   # Debe estar instalado con Node.js│   ├── logo.png

|----|-------------|--------|

| **RF58** | Inicio de sesión con validación de credenciales | ✅ Completo |

| **RF59** | Recuperación de contraseña por correo electrónico | ✅ Simulado |

| **RF48** | Notificaciones de seguridad | ✅ Completo |### 3. Detener el Servidor```│   ├── campo1.jpg

| **RF40** | Modificación de datos de usuario | ✅ Completo |

| **RF39** | Actualización de la lista de usuarios | ✅ Completo |

| **RF51** | Activar y desactivar usuarios | ✅ Completo |

| **RF49** | Gestión de permisos por roles | ✅ Completo |```bash│   ├── campo2.jpg



### Próximos Pasos# Presionar en la terminal:

- [ ] Sprint 2: Implementar gestión de proyectos

- [ ] Sprint 3: Implementar recursos y presupuestosCtrl + C**Descargar:** [https://nodejs.org/](https://nodejs.org/) (se recomienda la versión LTS)│   └── fondo.png

- [ ] Sprint 4: Implementar inventario

- [ ] Sprint 5: Implementar reportes```

- [ ] Sprint 6: Funcionalidades avanzadas

│

---

---

## 📝 Páginas Disponibles

### 2. Git (recomendado)└── 📁 temp/                        # DOCUMENTACIÓN TEMPORAL

### Páginas Públicas

- **`/`** - Página principal (Pagina.html)## Estructura del Proyecto

- **`/pages/mision-vision.html`** - Misión y visión

- **`/pages/objetivos.html`** - Objetivos del proyecto```bash    └── REQUERIMIENTOS FINAL (1).txt

- **`/pages/servicios.html`** - Servicios ofrecidos

- **`/pages/contacto.html`** - Información de contacto```



### Páginas de AutenticaciónAgroSpinoff2/# Verificar instalación```

- **`/pages/login.html`** - Inicio de sesión

- **`/pages/register.html`** - Registro de usuarios│



### Páginas Protegidas (requieren autenticación)├── server.js                         # Servidor HTTP principalgit --version

- **`/pages/dashboard.html`** - Panel principal

- **`/pages/usuarios.html`** - Gestión de usuarios (solo admin)├── package.json                      # Configuración y dependencias

- **`/pages/agendaReuniones.html`** - Programación de reuniones

├── .gitignore                        # Archivos ignorados por Git```---

---

├── README.md                         # Este archivo

## 🔐 Seguridad

│

- ✅ Cifrado de contraseñas con PBKDF2 (10,000 iteraciones, SHA-512)

- ✅ Cookies HttpOnly para prevenir XSS├── database/                         # Base de datos SQLite

- ✅ Prepared statements para prevenir SQL injection

- ✅ Validación de datos de entrada│   └── agrotechnova.db              # (Se crea automáticamente)**Descargar:** [https://git-scm.com/](https://git-scm.com/)## 💻 Tecnologías Utilizadas

- ✅ Control de sesiones con expiración automática (2h inactividad, 24h máximo)

- ✅ Integridad referencial en BD│

- ✅ Comparación de contraseñas con timing-safe

├── src/                             # CÓDIGO BACKEND

---

│   ├── controllers/                 # Lógica de negocio

## 🐛 Resolución de Problemas

│   │   ├── authController.js       # Login, logout, sesiones### 3. Editor de Código (recomendado)### Backend

### Problema 1: Error al iniciar el servidor

```│   │   └── userController.js       # CRUD de usuarios

Error: Cannot find module 'sqlite3'

```│   │- **VS Code:** [https://code.visualstudio.com/](https://code.visualstudio.com/)- **Node.js** (v14+) - Servidor HTTP nativo

**Solución:** `npm install`

│   ├── middlewares/                # Protección de rutas

### Problema 2: Puerto 3000 ocupado

```│   │   └── authMiddleware.js       # Verificación de autenticación- O cualquier editor de tu preferencia- **SQLite3** - Base de datos relacional

Error: listen EADDRINUSE: address already in use :::3000

```│   │

**Solución:** Cambiar el puerto en `server.js` o detener el proceso:

```bash│   ├── models/                     # Modelos de datos- **Crypto (nativo)** - Cifrado de contraseñas

# Windows

netstat -ano | findstr :3000│   │   ├── roleModel.js            # Gestión de roles

taskkill /PID <PID> /F

```│   │   └── userModel.js            # Gestión de usuarios---



### Problema 3: Base de datos bloqueada│   │

```

Error: SQLITE_BUSY: database is locked│   ├── routes/                     # Rutas API### Frontend

```

**Solución:** Detener servidor (Ctrl+C), eliminar `database/agrotechnova.db` y reiniciar│   │   ├── authRoutes.js           # Rutas de autenticación



---│   │   └── userRoutes.js           # Rutas de usuarios## 🧪 Instalación- **HTML5** - Estructura de páginas



## 📚 Documentación Adicional│   │



- **[SPRINT1_COMPLETE.md](./SPRINT1_COMPLETE.md)** - Documentación técnica completa del Sprint 1│   ├── utils/                      # Utilidades- **CSS3** - Estilos y diseño responsive

- **[SPRINT1_INSTRUCCIONES.md](./SPRINT1_INSTRUCCIONES.md)** - Instrucciones detalladas de implementación

│   │   ├── crypto.js               # Hash de contraseñas (PBKDF2)

---

│   │   ├── validators.js           # Validaciones de datos### Opción 1: Clonar desde GitHub- **JavaScript Vanilla** - Interactividad del cliente

## 🎨 Características del Diseño

│   │   └── sessionManager.js       # Gestión de sesiones

- ✅ CSS separado por página para mejor mantenibilidad

- ✅ Imágenes organizadas en carpeta dedicada│   │

- ✅ Rutas relativas correctamente configuradas

- ✅ Estructura escalable y profesional│   └── db/                         # Base de datos

- ✅ Diseño responsive

- ✅ Font Awesome para iconos│       ├── database.js             # Conexión SQLite (Singleton)```bash### Sin Frameworks



---│       └── migrations.js           # Inicialización de tablas



## 🔗 Rutas Importantes│# 1. Clonar el repositorio- ❌ No Express



- **Desde pages/ hacia CSS**: `../public/css/[archivo].css`├── pages/                          # FRONTEND (HTML)

- **Desde pages/ hacia imágenes**: `../images/[imagen]`

- **Enlaces entre páginas HTML**: Usar nombres de archivo directamente (ej: `login.html`)│   ├── login.html                  # Página de logingit clone https://github.com/JSBHernandez/AgroSpinoff2.git- ❌ No React/Vue/Angular



---│   ├── usuarios.html               # Panel de administración



## 👥 Equipo de Desarrollo│   ├── dashboard.html              # Dashboard principal- ❌ No Bootstrap/Tailwind



**AgroTechNova Team**  │   ├── register.html               # Registro de usuarios

Universidad Pontificia Bolivariana  

Proyecto Integrador 1  │   └── ...                         # Otras páginas# 2. Navegar a la carpeta del proyecto- ✅ Solo tecnologías nativas

Octubre 2025

│

---

├── public/                         # ARCHIVOS ESTÁTICOScd AgroSpinoff2

## 📄 Licencia

│   └── css/                        # Estilos CSS

MIT License - Proyecto Académico

│       ├── login.css---

---

│       ├── dashboard.css

**🌾 Desarrollado con Node.js puro - Sin frameworks externos**

│       └── ...# 3. Instalar dependencias (solo sqlite3)

---

│

## 🆘 Soporte

└── images/                         # Imágenes y assetsnpm install## 🚀 Instalación y Configuración

**¿Problemas o dudas?**

1. Revisa la sección [Resolución de Problemas](#-resolución-de-problemas)    ├── logo.png

2. Consulta los logs del servidor (emojis en consola)

3. Revisa la consola del navegador (F12)    └── ...

4. Consulta `SPRINT1_COMPLETE.md` para documentación técnica

```

---

# 4. Inicializar la base de datos### 1. Clonar el repositorio

**⭐ ¡Listo para empezar!**

---

```bash

npm install && node server.js# (La base de datos se crea automáticamente al iniciar el servidor)```bash

```

## Credenciales de Prueba

Luego abre: **http://localhost:3000/login**

```git clone <url-del-repositorio>

### Usuario Administrador (por defecto)

cd AgroSpinoff2

```

Email:     admin@agrotechnova.com### Opción 2: Descargar ZIP```

Password:  Admin123!

Rol:       Administrador

```

```bash### 2. Instalar dependencias

**IMPORTANTE:** Cambiar la contraseña después del primer login.

# 1. Descargar el proyecto desde GitHub```bash

### Crear Nuevos Usuarios

# https://github.com/JSBHernandez/AgroSpinoff2/archive/refs/heads/main.zipnpm install

1. Iniciar sesión como administrador

2. Navegar a `http://localhost:3000/usuarios````

3. Hacer clic en "Crear Usuario"

4. Completar formulario con:# 2. Descomprimir y navegar a la carpeta

   - Nombre completo (mínimo 3 caracteres)

   - Email válidocd AgroSpinoff2### 3. Configurar variables de entorno (opcional)

   - Contraseña segura (8+ caracteres, mayúscula, minúscula, carácter especial)

   - Rol (administrador, asesor, productor)```bash



---# 3. Instalar dependenciascp .env.example .env



## Pruebas Funcionalesnpm install# Editar .env con tus configuraciones



### Prueba 1: Login Exitoso``````



```bash

1. Abrir http://localhost:3000/login

2. Ingresar:---### 4. Iniciar el servidor

   - Email: admin@agrotechnova.com

   - Password: Admin123!```bash

3. Hacer clic en "Ingresar"

## 🚀 Ejecutar el Proyectonpm start

Resultado esperado:

   - Mensaje: "Bienvenido Administrador"```

   - Redirección a panel de usuarios

   - Cookie de sesión almacenada### 1. Iniciar el Servidor

```

### 5. Acceder a la aplicación

### Prueba 2: Login con Credenciales Inválidas

```bashAbrir en el navegador: `http://127.0.0.1:3000`

```bash

1. Intentar login con password incorrectanode server.js

2. Ver mensaje de error: "Credenciales inválidas"

3. No se crea sesión```---

```



### Prueba 3: Crear Nuevo Usuario

**Salida esperada:**## 🏗️ Arquitectura del Sistema

```bash

1. Login como admin```

2. Ir a http://localhost:3000/usuarios

3. Clic en "Crear Usuario"🔧 Inicializando base de datos...### Patrón de Diseño

4. Completar formulario:

   - Nombre: Juan Pérez✅ Conexión exitosa a la base de datos SQLite**Arquitectura en Capas Simplificada (sin MVC estricto)**

   - Email: juan@example.com

   - Password: Prueba123!🔗 Claves foráneas habilitadas

   - Rol: productor

5. Guardar✅ Tabla "roles" creada correctamente```



Resultado: Usuario aparece en la tabla✅ Tabla "usuarios" creada correctamente┌─────────────────────────────────────────┐

```

✅ Rol "administrador" insertado│         CLIENTE (Navegador)             │

### Prueba 4: Desactivar Usuario

✅ Rol "asesor" insertado│    HTML + CSS + JavaScript Vanilla      │

```bash

1. En la tabla de usuarios, clic en "Desactivar"✅ Rol "productor" insertado└────────────────┬────────────────────────┘

2. Confirmar acción

✅ Usuario administrador creado:                 │ HTTP/HTTPS

Resultado:

   - Estado cambia a "inactivo"   📧 Email: admin@agrotechnova.com┌────────────────▼────────────────────────┐

   - Usuario no puede iniciar sesión

   - Sesiones activas se cierran automáticamente   🔑 Password: Admin123!│         SERVIDOR (Node.js)              │

```

✅ Base de datos lista│  ┌─────────────────────────────────┐   │

### Prueba 5: Sesión Persistente

🧹 Limpiador de sesiones iniciado (cada 15 minutos)│  │  Routes (Enrutamiento)          │   │

```bash

1. Iniciar sesión==================================================│  └──────────┬──────────────────────┘   │

2. Recargar página (F5)

🚀 SERVIDOR AGROTECHNOVA INICIADO│  ┌──────────▼──────────────────────┐   │

Resultado: Sesión permanece activa

```==================================================│  │  Middlewares (Auth, Validación) │   │



### Prueba 6: Endpoints API (con Postman/cURL)📡 Servidor corriendo en: http://127.0.0.1:3000│  └──────────┬──────────────────────┘   │



```bash⏰ Hora de inicio: 15/10/2025, 4:30:00 p. m.│  ┌──────────▼──────────────────────┐   │

# Login

curl -X POST http://localhost:3000/api/auth/login \==================================================│  │  Controllers (Lógica Negocio)   │   │

  -H "Content-Type: application/json" \

  -d '{"email":"admin@agrotechnova.com","password":"Admin123!"}'📋 ENDPOINTS DISPONIBLES:│  └──────────┬──────────────────────┘   │



# Verificar sesión   POST /api/auth/login│  ┌──────────▼──────────────────────┐   │

curl -X GET http://localhost:3000/api/auth/session \

  --cookie "sessionId=<SESSION_ID>"   POST /api/auth/logout│  │  Models (Acceso a Datos)        │   │



# Listar usuarios (requiere admin)   GET  /api/auth/session│  └──────────┬──────────────────────┘   │

curl -X GET http://localhost:3000/api/users \

  --cookie "sessionId=<SESSION_ID>"   POST /api/auth/forgot-password└─────────────┼──────────────────────────┘

```

   GET  /api/users (admin)              │

---

   POST /api/users (admin)┌─────────────▼──────────────────────────┐

## Requerimientos Implementados

   GET  /api/roles (autenticado)│      BASE DE DATOS (SQLite)            │

### Sprint 1 - Autenticación y Base del Sistema

==================================================│       agrotechnova.db                  │

| RF | Descripción | Estado |

|----|-------------|--------|```└────────────────────────────────────────┘

| **RF58** | Inicio de sesión con validación de credenciales | Completo |

| **RF59** | Recuperación de contraseña por correo electrónico | Simulado |```

| **RF48** | Notificaciones de seguridad | Completo |

| **RF40** | Modificación de datos de usuario | Completo |### 2. Abrir en el Navegador

| **RF39** | Actualización de la lista de usuarios | Completo |

| **RF51** | Activar y desactivar usuarios | Completo |### Flujo de una Petición

| **RF49** | Gestión de permisos por roles | Completo |

**Página de Login:**

---

```1. **Cliente** envía petición HTTP (ej: POST /api/auth/login)

## Resolución de Problemas

http://localhost:3000/login2. **Servidor** recibe y parsea la petición

### Problema 1: Error al iniciar el servidor

```3. **Routes** identifica la ruta y dirige al controlador

```

Error: Cannot find module 'sqlite3'4. **Middlewares** validan autenticación/autorización

```

**Rutas alternativas:**5. **Controller** procesa la lógica de negocio

**Solución:**

```bash```6. **Model** ejecuta consultas a la base de datos

npm install

```http://localhost:3000/pages/login.html7. **Controller** formatea respuesta



---http://localhost:3000/8. **Servidor** envía respuesta JSON al cliente



### Problema 2: Puerto 3000 ocupado```



```---

Error: listen EADDRINUSE: address already in use :::3000

```### 3. Detener el Servidor



**Solución 1:** Cambiar puerto en `server.js`:## 📆 Plan de Desarrollo por Sprints

```javascript

const PORT = process.env.PORT || 3001;```bash

```

# Presionar en la terminal:### Sprint 1 - Autenticación y Base del Sistema ✅ (Estructura Creada)

**Solución 2:** Detener proceso que usa el puerto:

```bashCtrl + C**Requerimientos:** RF58, RF59, RF48, RF40, RF39, RF51, RF49 + RNF01, 05, 07, 11, 16  

# Windows

netstat -ano | findstr :3000```**Tablas:** usuarios, roles  

taskkill /PID <PID> /F

**Funcionalidades:**

# Linux/Mac

lsof -ti:3000 | xargs kill---- Login y registro de usuarios

```

- Cifrado de contraseñas

---

## 📂 Estructura del Proyecto- Gestión de roles y permisos

### Problema 3: Base de datos bloqueada

- Recuperación de contraseña

```

Error: SQLITE_BUSY: database is locked```

```

AgroSpinoff2/### Sprint 2 - Gestión de Proyectos (Próximo)

**Solución:**

```bash│**Requerimientos:** RF41, RF13, RF62, RF25, RF23, RF15, RF70, RF71  

# Detener servidor (Ctrl + C)

# Eliminar base de datos├── 📄 server.js                         # ⚙️ Servidor HTTP principal**Tablas:** proyectos, fases, hitos  

del database\agrotechnova.db

├── 📄 package.json                      # 📦 Configuración y dependencias**Funcionalidades:**

# Reiniciar servidor (se regenera automáticamente)

node server.js├── 📄 .gitignore                        # 🚫 Archivos ignorados por Git- CRUD de proyectos

```

├── 📄 README.md                         # 📖 Este archivo- División por fases

---

├── 📄 SPRINT1_COMPLETE.md               # 📋 Documentación completa Sprint 1- Seguimiento de hitos

## Documentación Adicional

│- Búsqueda y filtrado

- **SPRINT1_COMPLETE.md** - Documentación técnica completa del Sprint 1

- **SPRINT1_INSTRUCCIONES.md** - Instrucciones de implementación├── 📁 database/                         # 💾 Base de datos SQLite



---│   └── agrotechnova.db                  # (Se crea automáticamente)### Sprint 3 - Recursos y Presupuestos



## Equipo de Desarrollo│**Requerimientos:** RF01, RF02, RF03, RF04, RF05, RF17, RF19, RF32, RF33  



**Proyecto Integrador 1 - UPB**├── 📁 src/                              # 🔧 CÓDIGO BACKEND**Tablas:** recursos, presupuestos, gastos, asignaciones_personal  



- Desarrolladores: Equipo AgroTechNova│   ├── 📁 controllers/                  # 🎮 Lógica de negocio**Funcionalidades:**

- Institución: Universidad Pontificia Bolivariana

- Fecha: Octubre 2025│   │   ├── authController.js            # Login, logout, sesiones- Planificación de recursos



---│   │   └── userController.js            # CRUD de usuarios- Control de presupuesto



## Licencia│   │- Asignación de personal



Este proyecto es de uso **exclusivamente académico** para la asignatura Proyecto Integrador 1 de la Universidad Pontificia Bolivariana.│   ├── 📁 middlewares/                  # 🛡️ Protección de rutas- Comparación de gastos



---│   │   └── authMiddleware.js            # Verificación de autenticación



## Soporte│   │### Sprint 4 - Inventario y Proveedores



**¿Tienes problemas?**│   ├── 📁 models/                       # 🗄️ Modelos de datos**Requerimientos:** RF06, RF08, RF09, RF16, RF18, RF43, RF45, RF29, RF31  



1. Revisa la sección "Resolución de Problemas"│   │   ├── roleModel.js                 # Gestión de roles**Tablas:** productos, proveedores, inventario, insumos, maquinaria  

2. Consulta los logs del servidor en consola

3. Revisa la consola del navegador (F12)│   │   └── userModel.js                 # Gestión de usuarios**Funcionalidades:**

4. Inspecciona la base de datos con SQLite Browser

5. Consulta la documentación en SPRINT1_COMPLETE.md│   │- Catálogo de productos



---│   ├── 📁 routes/                       # 🛣️ Rutas API- Registro de proveedores



**Listo para empezar:**│   │   ├── authRoutes.js                # Rutas de autenticación- Control de inventario



```bash│   │   └── userRoutes.js                # Rutas de usuarios- Insumos orgánicos/químicos

npm install && node server.js

```│   │



**Luego abre:** http://localhost:3000/login│   ├── 📁 utils/                        # 🔨 Utilidades### Sprint 5 - Reportes y Visualización



---│   │   ├── crypto.js                    # Hash de contraseñas (PBKDF2)**Requerimientos:** RF28, RF52, RF53, RF54, RF55, RF56, RF57, RF60, RF61  



**Desarrollado con Node.js puro - Sin frameworks externos**│   │   ├── validators.js                # Validaciones de datos**Funcionalidades:**


│   │   └── sessionManager.js            # Gestión de sesiones- Generación de reportes PDF/Excel

│   │- Visualización de proyectos finalizados

│   └── 📁 db/                           # 💽 Base de datos- Catálogo de servicios

│       ├── database.js                  # Conexión SQLite (Singleton)- Información institucional

│       └── migrations.js                # Inicialización de tablas

│### Sprint 6 - Funcionalidades Avanzadas

├── 📁 pages/                            # 🌐 FRONTEND (HTML)**Requerimientos:** RF34, RF35, RF36, RF37, RF44, RF46, RF64, RF66  

│   ├── login.html                       # Página de login**Funcionalidades:**

│   ├── usuarios.html                    # Panel de administración- Programación de reuniones

│   ├── dashboard.html                   # Dashboard principal- Copias de seguridad

│   ├── register.html                    # Registro de usuarios- Monitoreo del sistema

│   ├── Pagina.html                      # Landing page- Integración con APIs externas

│   └── ...                              # Otras páginas

│---

├── 📁 public/                           # 🎨 ARCHIVOS ESTÁTICOS

│   └── 📁 css/                          # Estilos CSS## 📊 Requerimientos Implementados

│       ├── login.css

│       ├── dashboard.css### Estado Actual: SPRINT 0 - Estructura Base ✅

│       └── ...

│| Componente | Estado | Descripción |

└── 📁 images/                           # 🖼️ Imágenes y assets|------------|--------|-------------|

    ├── logo.png| Servidor HTTP | ✅ | Node.js puro sin Express |

    └── ...| Base de datos | ✅ | SQLite configurado |

```| Estructura backend | ✅ | Carpetas organizadas |

| Frontend base | ✅ | HTML/CSS existente |

### 📌 Explicación de Carpetas Clave| Documentación | ✅ | README por carpeta |



| Carpeta | Propósito |### Próximos Pasos

|---------|-----------|- [ ] Sprint 1: Implementar autenticación

| `src/controllers/` | Lógica de negocio (login, CRUD usuarios) |- [ ] Sprint 2: Implementar gestión de proyectos

| `src/routes/` | Enrutamiento de endpoints API |- [ ] Sprint 3: Implementar recursos y presupuestos

| `src/middlewares/` | Autenticación y validación de permisos |- [ ] Sprint 4: Implementar inventario

| `src/models/` | Interacción con base de datos |- [ ] Sprint 5: Implementar reportes

| `src/utils/` | Funciones reutilizables (crypto, validaciones) |- [ ] Sprint 6: Funcionalidades avanzadas

| `pages/` | Interfaz de usuario (HTML) |

| `public/` | Archivos estáticos (CSS, JS) |---

| `database/` | Archivo SQLite (se genera automáticamente) |

## 📝 Páginas Disponibles

---

### Páginas Públicas

## 🔐 Credenciales de Prueba- **`/`** - Página principal (Pagina.html)

- **`/pages/mision-vision.html`** - Misión y visión

### Usuario Administrador (por defecto)- **`/pages/objetivos.html`** - Objetivos del proyecto

- **`/pages/servicios.html`** - Servicios ofrecidos

```- **`/pages/contacto.html`** - Información de contacto

📧 Email:     admin@agrotechnova.com

🔑 Password:  Admin123!### Páginas de Autenticación

👤 Rol:       Administrador- **`/pages/login.html`** - Inicio de sesión

```- **`/pages/register.html`** - Registro de usuarios



**⚠️ IMPORTANTE:** Cambiar la contraseña después del primer login (buena práctica de seguridad).### Páginas Protegidas (requieren autenticación)

- **`/pages/dashboard.html`** - Panel principal

### Crear Nuevos Usuarios- **`/pages/agendaReuniones.html`** - Programación de reuniones



1. Iniciar sesión como administrador---

2. Navegar a `http://localhost:3000/usuarios`

3. Hacer clic en "Crear Usuario"## 🔐 Seguridad

4. Completar formulario con:

   - Nombre completo (mínimo 3 caracteres)- ✅ Cifrado de contraseñas con crypto nativo

   - Email válido- ✅ Prepared statements para prevenir SQL injection

   - Contraseña segura (8+ caracteres, mayúscula, minúscula, carácter especial)- ✅ Validación de datos de entrada

   - Rol (administrador, asesor, productor)- ✅ Control de sesiones

- ✅ Integridad referencial en BD

---

---

## 🧪 Pruebas Funcionales

## 👥 Equipo de Desarrollo

### ✅ Prueba 1: Login Exitoso

**AgroTechNova Team**  

```bashUniversidad Pontificia Bolivariana  

1. Abrir http://localhost:3000/loginProyecto Integrador 1

2. Ingresar:

   - Email: admin@agrotechnova.com---

   - Password: Admin123!

3. Hacer clic en "Ingresar"## 📄 Licencia



✅ Resultado esperado:MIT License - Proyecto Académico

   - Mensaje: "Bienvenido Administrador"- **dashboard.html** - Panel de control del usuario

   - Redirección a panel de usuarios- **mision-vision.html** - Misión y visión de la empresa

   - Cookie de sesión almacenada- **objetivos.html** - Objetivos de AgroTechNova

```- **servicios.html** - Servicios ofrecidos

- **contacto.html** - Formulario de contacto

### ❌ Prueba 2: Login con Credenciales Inválidas- **agendaReuniones.html** - Agenda de reuniones



```bash## 🎨 Características

1. Intentar login con password incorrecta

2. Ver mensaje de error: "Credenciales inválidas"- ✅ CSS separado por página para mejor mantenibilidad

3. No se crea sesión- ✅ Imágenes organizadas en carpeta dedicada

```- ✅ Rutas relativas correctamente configuradas

- ✅ Estructura escalable y profesional

### ✅ Prueba 3: Crear Nuevo Usuario- ✅ Diseño responsive

- ✅ Font Awesome para iconos

```bash

1. Login como admin## ⚠️ Nota importante

2. Ir a http://localhost:3000/usuarios

3. Clic en "Crear Usuario"Los archivos HTML antiguos en la raíz del proyecto pueden ser eliminados ya que las versiones actualizadas están en la carpeta `pages/` con las rutas correctas.

4. Completar formulario:

   - Nombre: Juan Pérez## 🔗 Rutas importantes

   - Email: juan@example.com

   - Password: Prueba123!- **Desde pages/ hacia CSS**: `../public/css/[archivo].css`

   - Rol: productor- **Desde pages/ hacia imágenes**: `../images/[imagen]`

5. Guardar- **Enlaces entre páginas HTML**: Usar nombres de archivo directamente (ej: `login.html`)



✅ Resultado: Usuario aparece en la tabla---

```**Desarrollado por**: AgroTechNova Team

**Fecha**: Octubre 2025

### ✅ Prueba 4: Desactivar Usuario

```bash
1. En la tabla de usuarios, clic en "Desactivar"
2. Confirmar acción

✅ Resultado:
   - Estado cambia a "inactivo"
   - Usuario no puede iniciar sesión
   - Sesiones activas se cierran automáticamente
```

### 🔄 Prueba 5: Sesión Persistente

```bash
1. Iniciar sesión
2. Recargar página (F5)

✅ Resultado: Sesión permanece activa (no solicita login nuevamente)
```

### 📋 Prueba 6: Endpoints API (con Postman/cURL)

```bash
# Login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@agrotechnova.com","password":"Admin123!"}'

# Verificar sesión
curl -X GET http://localhost:3000/api/auth/session \
  --cookie "sessionId=<SESSION_ID>"

# Listar usuarios (requiere admin)
curl -X GET http://localhost:3000/api/users \
  --cookie "sessionId=<SESSION_ID>"
```

---

## 🧠 Notas para Desarrolladores

### 📜 Reglas del "Prompt Maestro"

Este proyecto sigue estrictamente las siguientes reglas académicas:

1. ✅ **No usar frameworks externos:**
   - ❌ No Express.js, no React, no Vue, no Angular
   - ✅ Solo Node.js puro y módulos nativos

2. ✅ **Base de datos minimalista:**
   - Solo las tablas estrictamente necesarias
   - Sprint 1: `roles` y `usuarios`

3. ✅ **Código limpio y documentado:**
   - Comentarios JSDoc en cada función
   - Nombres descriptivos de variables y funciones
   - Separación clara de responsabilidades

4. ✅ **Seguridad básica implementada:**
   - Hash de contraseñas con PBKDF2
   - Validación de inputs
   - Cookies HttpOnly

5. ✅ **Arquitectura por capas:**
   ```
   Routes → Middlewares → Controllers → Models → Database
   ```

### 🔧 Buenas Prácticas Internas

**Al agregar nuevas funcionalidades:**

1. **Crear primero el modelo** (`src/models/`)
2. **Luego el controlador** (`src/controllers/`)
3. **Después las rutas** (`src/routes/`)
4. **Aplicar middlewares** si es necesario
5. **Actualizar documentación** en `README.md`

**Convenciones de código:**

```javascript
// ✅ Funciones descriptivas
async function createUser(userData) { }

// ❌ Funciones ambiguas
async function create(data) { }

// ✅ Constantes en MAYÚSCULAS
const MAX_LOGIN_ATTEMPTS = 5;

// ✅ Clases con PascalCase
class UserController { }

// ✅ Archivos con camelCase
userController.js
```

### 🐛 Debugging

**Ver logs del servidor:**
```bash
# Los logs aparecen en consola con emojis identificadores:
✅ Éxito
❌ Error
⚠️ Advertencia
ℹ️ Información
```

**Inspeccionar base de datos:**
```bash
# Usar SQLite Browser o ejecutar:
sqlite3 database/agrotechnova.db
.tables
SELECT * FROM usuarios;
```

**Ver errores del navegador:**
```bash
# Abrir consola del navegador:
F12 → Console
```

---

## 📋 Requerimientos Implementados

### ✅ Sprint 1 - Autenticación y Base del Sistema

| RF | Descripción | Estado |
|----|-------------|--------|
| **RF58** | Inicio de sesión con validación de credenciales | ✅ Completo |
| **RF59** | Recuperación de contraseña por correo electrónico | ✅ Simulado |
| **RF48** | Notificaciones de seguridad | ✅ Completo |
| **RF40** | Modificación de datos de usuario | ✅ Completo |
| **RF39** | Actualización de la lista de usuarios | ✅ Completo |
| **RF51** | Activar y desactivar usuarios | ✅ Completo |
| **RF49** | Gestión de permisos por roles | ✅ Completo |

### 🔜 Próximos Sprints

**Sprint 2:** Gestión de Proyectos  
**Sprint 3:** Recursos e Inventario  
**Sprint 4:** Reportes y Analytics

---

## 🌐 Roadmap

### 📅 Sprint 1 (COMPLETADO) ✅
- [x] Sistema de autenticación
- [x] Gestión de usuarios
- [x] Control de roles y permisos
- [x] Sesiones con expiración

### 📅 Sprint 2 (PRÓXIMO)
- [ ] CRUD de proyectos agroindustriales
- [ ] Asignación de asesores y productores
- [ ] Estados de proyecto (planificación, en curso, finalizado)

### 📅 Sprint 3
- [ ] Gestión de recursos
- [ ] Control de inventario
- [ ] Alertas de stock

### 📅 Sprint 4
- [ ] Dashboard con gráficos
- [ ] Exportación de reportes (PDF/CSV)
- [ ] Estadísticas de uso

---

## 🐛 Resolución de Problemas

### Problema 1: Error al iniciar el servidor

```
Error: Cannot find module 'sqlite3'
```

**Solución:**
```bash
npm install
```

---

### Problema 2: Puerto 3000 ocupado

```
Error: listen EADDRINUSE: address already in use :::3000
```

**Solución 1:** Cambiar puerto en `server.js`:
```javascript
const PORT = process.env.PORT || 3001;
```

**Solución 2:** Detener proceso que usa el puerto:
```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:3000 | xargs kill
```

---

### Problema 3: Base de datos bloqueada

```
Error: SQLITE_BUSY: database is locked
```

**Solución:**
```bash
# Detener servidor
Ctrl + C

# Eliminar base de datos
rm database/agrotechnova.db  # Linux/Mac
del database\agrotechnova.db  # Windows

# Reiniciar servidor (se regenera automáticamente)
node server.js
```

---

## 📚 Documentación Adicional

- **[SPRINT1_COMPLETE.md](./SPRINT1_COMPLETE.md)** - Documentación técnica completa del Sprint 1
- **[SPRINT1_INSTRUCCIONES.md](./SPRINT1_INSTRUCCIONES.md)** - Instrucciones de implementación

---

## 👥 Equipo de Desarrollo

**Proyecto Integrador 1 - UPB**

- 👨‍💻 **Desarrolladores:** Equipo AgroTechNova
- 🏫 **Institución:** Universidad Pontificia Bolivariana
- 📅 **Fecha:** Octubre 2025

---

## 📄 Licencia

Este proyecto es de uso **exclusivamente académico** para la asignatura Proyecto Integrador 1 de la Universidad Pontificia Bolivariana.

---

## 🆘 Soporte

**¿Tienes problemas?**

1. Revisa la sección [🐛 Resolución de Problemas](#-resolución-de-problemas)
2. Consulta los logs del servidor (consola con emojis)
3. Revisa la consola del navegador (F12)
4. Inspecciona la base de datos con SQLite Browser
5. Consulta la documentación en `SPRINT1_COMPLETE.md`

---

**🎉 ¡Listo para empezar!**

```bash
npm install && node server.js
```

**Luego abre:** [http://localhost:3000/login](http://localhost:3000/login)

---

**⭐ Si te gusta el proyecto, considera darle una estrella en GitHub ⭐**
