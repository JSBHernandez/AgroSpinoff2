# 🌾 AgroTechNova - Plataforma de Gestión Agroindustrial# 🌾 AgroTechNova - Plataforma de Gestión Agroindustrial



![Estado](https://img.shields.io/badge/Estado-Sprint%201%20Completado-success)**Proyecto Integrador 1 - Universidad Pontificia Bolivariana**

![Node](https://img.shields.io/badge/Node.js-v14%2B-green)

![Licencia](https://img.shields.io/badge/Licencia-Acad%C3%A9mico-blue)Sistema web para la gestión integral de proyectos agroindustriales, recursos, presupuestos e inventario.



**Proyecto Integrador 1 - Universidad Pontificia Bolivariana**---



Sistema web para la gestión integral de proyectos agroindustriales, desarrollado con **Node.js puro** (sin frameworks externos) como ejercicio académico.## � Tabla de Contenidos



---- [Descripción del Proyecto](#-descripción-del-proyecto)

- [Estructura del Proyecto](#-estructura-del-proyecto)

## 📑 Tabla de Contenidos- [Tecnologías Utilizadas](#-tecnologías-utilizadas)

- [Instalación y Configuración](#-instalación-y-configuración)

- [🎯 Descripción del Proyecto](#-descripción-del-proyecto)- [Arquitectura del Sistema](#-arquitectura-del-sistema)

- [🧰 Stack Tecnológico](#-stack-tecnológico)- [Plan de Desarrollo por Sprints](#-plan-de-desarrollo-por-sprints)

- [🧭 Requisitos Previos](#-requisitos-previos)- [Requerimientos Implementados](#-requerimientos-implementados)

- [🧪 Instalación](#-instalación)

- [🚀 Ejecutar el Proyecto](#-ejecutar-el-proyecto)---

- [📂 Estructura del Proyecto](#-estructura-del-proyecto)

- [🔐 Credenciales de Prueba](#-credenciales-de-prueba)## 🎯 Descripción del Proyecto

- [🧪 Pruebas Funcionales](#-pruebas-funcionales)

- [🧠 Notas para Desarrolladores](#-notas-para-desarrolladores)AgroTechNova es una plataforma web diseñada para centralizar la gestión de proyectos agroindustriales, permitiendo:

- [📋 Requerimientos Implementados](#-requerimientos-implementados)

- [🌐 Roadmap](#-roadmap)- ✅ Gestión de usuarios con roles y permisos

- ✅ Control de proyectos por fases y hitos

---- ✅ Administración de recursos y presupuestos

- ✅ Inventario de insumos y productos

## 🎯 Descripción del Proyecto- ✅ Generación de reportes y métricas

- ✅ Sistema de asesorías y colaboración

**AgroTechNova** es una plataforma web diseñada para centralizar la gestión de proyectos agroindustriales en el sector del agro colombiano.

**Contexto Académico:** Proyecto Integrador 1  

### 🎓 Contexto Académico**Institución:** Universidad Pontificia Bolivariana  

**Enfoque:** Código limpio, modular y académico (sin frameworks externos)

- **Institución:** Universidad Pontificia Bolivariana (UPB)

- **Asignatura:** Proyecto Integrador 1---

- **Fecha:** Octubre 2025

- **Objetivo:** Aplicar conceptos de desarrollo web full-stack con tecnologías nativas sin frameworks externos## 📁 Estructura del Proyecto



### ✨ Funcionalidades Principales```

AgroSpinoff2/

- ✅ **Autenticación y Autorización** - Sistema de login seguro con roles (administrador, asesor, productor)│

- ✅ **Gestión de Usuarios** - CRUD completo con activación/desactivación├── 📄 server.js                    # Servidor HTTP principal (Node.js puro)

- ✅ **Control de Sesiones** - Manejo de sesiones con expiración automática├── 📄 package.json                 # Configuración del proyecto

- ✅ **Recuperación de Contraseña** - Sistema simulado de recuperación├── 📄 .env.example                 # Variables de entorno de ejemplo

- 🔜 **Gestión de Proyectos** - (Sprint 2)├── 📄 .gitignore                   # Archivos ignorados por git

- 🔜 **Control de Inventario** - (Sprint 3)│

- 🔜 **Reportes y Métricas** - (Sprint 4)├── 📁 src/                         # CÓDIGO BACKEND

│   ├── 📁 controllers/             # Lógica de negocio

---│   │   └── README.md               # Documentación de controladores

│   ├── 📁 models/                  # Modelos de datos (BD)

## 🧰 Stack Tecnológico│   │   └── README.md               # Documentación de modelos

│   ├── 📁 routes/                  # Rutas de la API REST

### Backend│   │   └── README.md               # Documentación de rutas

- **Node.js v14+** (sin Express u otros frameworks)│   ├── 📁 middlewares/             # Autenticación, validación, etc.

- **SQLite3** - Base de datos ligera en archivo│   │   └── README.md               # Documentación de middlewares

│   ├── 📁 utils/                   # Funciones utilitarias

### Frontend│   │   └── README.md               # Documentación de utils

- **HTML5** - Estructura semántica│   └── 📁 db/                      # Configuración de base de datos

- **CSS3** - Estilos personalizados (sin Bootstrap/Tailwind)│       ├── database.js             # Clase de conexión SQLite

- **JavaScript Vanilla** - Sin React, Vue, Angular│       └── README.md               # Documentación de BD

│

### Seguridad├── 📁 database/                    # Base de datos SQLite (auto-generada)

- **PBKDF2** - Hash de contraseñas con 10,000 iteraciones (SHA-512)│   └── agrotechnova.db             # Archivo de base de datos

- **Cookies HttpOnly** - Protección contra XSS│

- **Validaciones** - Input sanitization en backend├── 📁 pages/                       # CÓDIGO FRONTEND (HTML)

│   ├── Pagina.html                 # Página principal

### Base de Datos│   ├── login.html                  # Inicio de sesión

```│   ├── register.html               # Registro de usuarios

- roles (id, nombre, descripcion, permisos)│   ├── dashboard.html              # Panel principal

- usuarios (id, nombre, email, password_hash, rol_id, estado)│   ├── agendaReuniones.html        # Programación de reuniones

```│   ├── contacto.html               # Página de contacto

│   ├── mision-vision.html          # Misión y visión

**Diseño minimalista:** Solo 2 tablas en Sprint 1│   ├── objetivos.html              # Objetivos del proyecto

│   └── servicios.html              # Servicios ofrecidos

---│

├── 📁 public/                      # ARCHIVOS ESTÁTICOS

## 🧭 Requisitos Previos│   ├── 📁 css/                     # Hojas de estilo

│   │   ├── Pagina.css

Antes de instalar el proyecto, asegúrate de tener instalado:│   │   ├── login.css

│   │   ├── dashboard.css

### 1. Node.js (obligatorio)│   │   └── ...

```bash│   └── 📁 js/                      # Scripts del frontend

# Verificar instalación│

node --version  # Debe ser v14.0.0 o superior├── 📁 images/                      # IMÁGENES

npm --version   # Debe estar instalado con Node.js│   ├── logo.png

```│   ├── campo1.jpg

│   ├── campo2.jpg

**Descargar:** [https://nodejs.org/](https://nodejs.org/) (se recomienda la versión LTS)│   └── fondo.png

│

### 2. Git (recomendado)└── 📁 temp/                        # DOCUMENTACIÓN TEMPORAL

```bash    └── REQUERIMIENTOS FINAL (1).txt

# Verificar instalación```

git --version

```---



**Descargar:** [https://git-scm.com/](https://git-scm.com/)## 💻 Tecnologías Utilizadas



### 3. Editor de Código (recomendado)### Backend

- **VS Code:** [https://code.visualstudio.com/](https://code.visualstudio.com/)- **Node.js** (v14+) - Servidor HTTP nativo

- O cualquier editor de tu preferencia- **SQLite3** - Base de datos relacional

- **Crypto (nativo)** - Cifrado de contraseñas

---

### Frontend

## 🧪 Instalación- **HTML5** - Estructura de páginas

- **CSS3** - Estilos y diseño responsive

### Opción 1: Clonar desde GitHub- **JavaScript Vanilla** - Interactividad del cliente



```bash### Sin Frameworks

# 1. Clonar el repositorio- ❌ No Express

git clone https://github.com/JSBHernandez/AgroSpinoff2.git- ❌ No React/Vue/Angular

- ❌ No Bootstrap/Tailwind

# 2. Navegar a la carpeta del proyecto- ✅ Solo tecnologías nativas

cd AgroSpinoff2

---

# 3. Instalar dependencias (solo sqlite3)

npm install## 🚀 Instalación y Configuración



# 4. Inicializar la base de datos### 1. Clonar el repositorio

# (La base de datos se crea automáticamente al iniciar el servidor)```bash

```git clone <url-del-repositorio>

cd AgroSpinoff2

### Opción 2: Descargar ZIP```



```bash### 2. Instalar dependencias

# 1. Descargar el proyecto desde GitHub```bash

# https://github.com/JSBHernandez/AgroSpinoff2/archive/refs/heads/main.zipnpm install

```

# 2. Descomprimir y navegar a la carpeta

cd AgroSpinoff2### 3. Configurar variables de entorno (opcional)

```bash

# 3. Instalar dependenciascp .env.example .env

npm install# Editar .env con tus configuraciones

``````



---### 4. Iniciar el servidor

```bash

## 🚀 Ejecutar el Proyectonpm start

```

### 1. Iniciar el Servidor

### 5. Acceder a la aplicación

```bashAbrir en el navegador: `http://127.0.0.1:3000`

node server.js

```---



**Salida esperada:**## 🏗️ Arquitectura del Sistema

```

🔧 Inicializando base de datos...### Patrón de Diseño

✅ Conexión exitosa a la base de datos SQLite**Arquitectura en Capas Simplificada (sin MVC estricto)**

🔗 Claves foráneas habilitadas

✅ Tabla "roles" creada correctamente```

✅ Tabla "usuarios" creada correctamente┌─────────────────────────────────────────┐

✅ Rol "administrador" insertado│         CLIENTE (Navegador)             │

✅ Rol "asesor" insertado│    HTML + CSS + JavaScript Vanilla      │

✅ Rol "productor" insertado└────────────────┬────────────────────────┘

✅ Usuario administrador creado:                 │ HTTP/HTTPS

   📧 Email: admin@agrotechnova.com┌────────────────▼────────────────────────┐

   🔑 Password: Admin123!│         SERVIDOR (Node.js)              │

✅ Base de datos lista│  ┌─────────────────────────────────┐   │

🧹 Limpiador de sesiones iniciado (cada 15 minutos)│  │  Routes (Enrutamiento)          │   │

==================================================│  └──────────┬──────────────────────┘   │

🚀 SERVIDOR AGROTECHNOVA INICIADO│  ┌──────────▼──────────────────────┐   │

==================================================│  │  Middlewares (Auth, Validación) │   │

📡 Servidor corriendo en: http://127.0.0.1:3000│  └──────────┬──────────────────────┘   │

⏰ Hora de inicio: 15/10/2025, 4:30:00 p. m.│  ┌──────────▼──────────────────────┐   │

==================================================│  │  Controllers (Lógica Negocio)   │   │

📋 ENDPOINTS DISPONIBLES:│  └──────────┬──────────────────────┘   │

   POST /api/auth/login│  ┌──────────▼──────────────────────┐   │

   POST /api/auth/logout│  │  Models (Acceso a Datos)        │   │

   GET  /api/auth/session│  └──────────┬──────────────────────┘   │

   POST /api/auth/forgot-password└─────────────┼──────────────────────────┘

   GET  /api/users (admin)              │

   POST /api/users (admin)┌─────────────▼──────────────────────────┐

   GET  /api/roles (autenticado)│      BASE DE DATOS (SQLite)            │

==================================================│       agrotechnova.db                  │

```└────────────────────────────────────────┘

```

### 2. Abrir en el Navegador

### Flujo de una Petición

**Página de Login:**

```1. **Cliente** envía petición HTTP (ej: POST /api/auth/login)

http://localhost:3000/login2. **Servidor** recibe y parsea la petición

```3. **Routes** identifica la ruta y dirige al controlador

4. **Middlewares** validan autenticación/autorización

**Rutas alternativas:**5. **Controller** procesa la lógica de negocio

```6. **Model** ejecuta consultas a la base de datos

http://localhost:3000/pages/login.html7. **Controller** formatea respuesta

http://localhost:3000/8. **Servidor** envía respuesta JSON al cliente

```

---

### 3. Detener el Servidor

## 📆 Plan de Desarrollo por Sprints

```bash

# Presionar en la terminal:### Sprint 1 - Autenticación y Base del Sistema ✅ (Estructura Creada)

Ctrl + C**Requerimientos:** RF58, RF59, RF48, RF40, RF39, RF51, RF49 + RNF01, 05, 07, 11, 16  

```**Tablas:** usuarios, roles  

**Funcionalidades:**

---- Login y registro de usuarios

- Cifrado de contraseñas

## 📂 Estructura del Proyecto- Gestión de roles y permisos

- Recuperación de contraseña

```

AgroSpinoff2/### Sprint 2 - Gestión de Proyectos (Próximo)

│**Requerimientos:** RF41, RF13, RF62, RF25, RF23, RF15, RF70, RF71  

├── 📄 server.js                         # ⚙️ Servidor HTTP principal**Tablas:** proyectos, fases, hitos  

├── 📄 package.json                      # 📦 Configuración y dependencias**Funcionalidades:**

├── 📄 .gitignore                        # 🚫 Archivos ignorados por Git- CRUD de proyectos

├── 📄 README.md                         # 📖 Este archivo- División por fases

├── 📄 SPRINT1_COMPLETE.md               # 📋 Documentación completa Sprint 1- Seguimiento de hitos

│- Búsqueda y filtrado

├── 📁 database/                         # 💾 Base de datos SQLite

│   └── agrotechnova.db                  # (Se crea automáticamente)### Sprint 3 - Recursos y Presupuestos

│**Requerimientos:** RF01, RF02, RF03, RF04, RF05, RF17, RF19, RF32, RF33  

├── 📁 src/                              # 🔧 CÓDIGO BACKEND**Tablas:** recursos, presupuestos, gastos, asignaciones_personal  

│   ├── 📁 controllers/                  # 🎮 Lógica de negocio**Funcionalidades:**

│   │   ├── authController.js            # Login, logout, sesiones- Planificación de recursos

│   │   └── userController.js            # CRUD de usuarios- Control de presupuesto

│   │- Asignación de personal

│   ├── 📁 middlewares/                  # 🛡️ Protección de rutas- Comparación de gastos

│   │   └── authMiddleware.js            # Verificación de autenticación

│   │### Sprint 4 - Inventario y Proveedores

│   ├── 📁 models/                       # 🗄️ Modelos de datos**Requerimientos:** RF06, RF08, RF09, RF16, RF18, RF43, RF45, RF29, RF31  

│   │   ├── roleModel.js                 # Gestión de roles**Tablas:** productos, proveedores, inventario, insumos, maquinaria  

│   │   └── userModel.js                 # Gestión de usuarios**Funcionalidades:**

│   │- Catálogo de productos

│   ├── 📁 routes/                       # 🛣️ Rutas API- Registro de proveedores

│   │   ├── authRoutes.js                # Rutas de autenticación- Control de inventario

│   │   └── userRoutes.js                # Rutas de usuarios- Insumos orgánicos/químicos

│   │

│   ├── 📁 utils/                        # 🔨 Utilidades### Sprint 5 - Reportes y Visualización

│   │   ├── crypto.js                    # Hash de contraseñas (PBKDF2)**Requerimientos:** RF28, RF52, RF53, RF54, RF55, RF56, RF57, RF60, RF61  

│   │   ├── validators.js                # Validaciones de datos**Funcionalidades:**

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
