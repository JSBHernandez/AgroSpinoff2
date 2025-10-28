# 🎯 GUION EXPLICATIVO - PROYECTO AGROSPINOFF2
## Sistema de Gestión Agroindustrial AgroTechNova

---

## 1. INTRODUCCIÓN GENERAL

### ¿Qué es AgroTechNova?

AgroTechNova es una **plataforma web integral** diseñada para la gestión completa de proyectos agroindustriales. El sistema permite centralizar y automatizar procesos clave como:

- Administración de usuarios con roles y permisos diferenciados
- Gestión completa de proyectos (planificación, fases, hitos, seguimiento)
- Control de recursos humanos, materiales y financieros
- Administración de inventario de insumos, productos y maquinaria
- Registro y seguimiento de proveedores
- Generación de reportes ejecutivos y operativos
- Sistema de soporte técnico mediante tickets
- Monitoreo de actividad del sistema y auditoría

### ¿A quién está dirigido?

El sistema está pensado para tres tipos de usuarios principales:

1. **Administradores:** Control total del sistema, gestión de usuarios, acceso a métricas y logs del sistema.
2. **Gestores de Proyecto:** Planificación y seguimiento de proyectos, asignación de recursos, control de presupuestos.
3. **Operadores:** Registro de actividades, actualización de inventario, gestión de proveedores.

### Contexto Académico

Este proyecto fue desarrollado como **Proyecto Integrador 1** en la Universidad Pontificia Bolivariana, con un enfoque académico que prioriza:
- Código limpio y modular
- Arquitectura escalable
- Documentación técnica completa
- Uso de tecnologías nativas sin dependencias de frameworks externos

---

## 2. ARQUITECTURA TÉCNICA

### Patrón de Diseño: Arquitectura en Capas (MVC Adaptado)

El sistema implementa una arquitectura en capas inspirada en el patrón **Modelo-Vista-Controlador (MVC)**, adaptada para Node.js puro sin frameworks:

```
┌───────────────────────────────────────────────────┐
│           CAPA DE PRESENTACIÓN (Frontend)         │
│   ┌─────────────────────────────────────────┐    │
│   │  HTML5 + CSS3 + JavaScript Vanilla      │    │
│   │  - Interfaces de usuario responsivas    │    │
│   │  - Validación de formularios            │    │
│   │  - Comunicación asíncrona (fetch API)   │    │
│   └─────────────────────────────────────────┘    │
└─────────────────┬─────────────────────────────────┘
                  │ HTTP/HTTPS (JSON)
┌─────────────────▼─────────────────────────────────┐
│           CAPA DE APLICACIÓN (Backend)            │
│   ┌─────────────────────────────────────────┐    │
│   │  ROUTES (Enrutamiento)                  │    │
│   │  - Definición de endpoints REST         │    │
│   │  - Parseo de peticiones HTTP            │    │
│   └──────────────┬──────────────────────────┘    │
│   ┌──────────────▼──────────────────────────┐    │
│   │  MIDDLEWARES (Seguridad y Validación)   │    │
│   │  - Autenticación basada en sesiones     │    │
│   │  - Control de acceso por roles          │    │
│   │  - Validación de datos de entrada       │    │
│   └──────────────┬──────────────────────────┘    │
│   ┌──────────────▼──────────────────────────┐    │
│   │  CONTROLLERS (Lógica de Negocio)        │    │
│   │  - Procesamiento de peticiones          │    │
│   │  - Validaciones de negocio              │    │
│   │  - Orquestación de operaciones          │    │
│   └──────────────┬──────────────────────────┘    │
│   ┌──────────────▼──────────────────────────┐    │
│   │  MODELS (Acceso a Datos)                │    │
│   │  - Abstracción de la base de datos      │    │
│   │  - Consultas SQL parametrizadas         │    │
│   │  - Validación de integridad             │    │
│   └──────────────┬──────────────────────────┘    │
└──────────────────┼───────────────────────────────┘
                   │
┌──────────────────▼───────────────────────────────┐
│           CAPA DE DATOS (Database)                │
│   ┌─────────────────────────────────────────┐    │
│   │  SQLite3 / MySQL                        │    │
│   │  - Base de datos relacional             │    │
│   │  - Integridad referencial               │    │
│   │  - Migraciones automáticas              │    │
│   └─────────────────────────────────────────┘    │
└───────────────────────────────────────────────────┘
```

### Separación de Responsabilidades

#### **Models (Modelos de Datos)**
Ubicación: `src/models/`

Los modelos encapsulan **toda la comunicación con la base de datos**. Cada entidad del sistema tiene su propio modelo:

- `userModel.js` - Gestión de usuarios
- `projectModel.js` - Proyectos agroindustriales
- `resourceModel.js` - Recursos (humanos, materiales)
- `budgetModel.js` - Control de presupuestos
- `inventoryModel.js` - Inventario de productos
- `ticketModel.js` - Sistema de soporte
- `logModel.js` - Auditoría del sistema

**Responsabilidades:**
- Ejecutar consultas SQL parametrizadas (prevención de SQL Injection)
- Validar tipos de datos antes de insertar
- Manejar relaciones entre tablas (foreign keys)
- Proporcionar métodos CRUD reutilizables

**Ejemplo conceptual:**
```javascript
// En projectModel.js
async create(data) {
  // 1. Validar datos de entrada
  // 2. Ejecutar INSERT en la base de datos
  // 3. Retornar el ID del nuevo proyecto
}
```

#### **Controllers (Controladores de Lógica de Negocio)**
Ubicación: `src/controllers/`

Los controladores procesan las peticiones HTTP y orquestan la lógica del negocio:

- `authController.js` - Login, registro, recuperación de contraseña
- `projectController.js` - Gestión completa de proyectos
- `budgetController.js` - Control financiero
- `adminController.js` - Métricas y administración del sistema
- `ticketController.js` - Soporte técnico
- `logController.js` - Visualización de logs

**Responsabilidades:**
- Recibir y parsear datos de la petición HTTP
- Validar reglas de negocio (ej: un proyecto debe tener presupuesto positivo)
- Llamar a uno o varios modelos para obtener/modificar datos
- Formatear y enviar respuestas JSON al cliente
- Manejar errores y excepciones

**Ejemplo de flujo:**
```javascript
// Cuando un usuario crea un proyecto:
async crear(req, res) {
  // 1. Extraer datos del body (req)
  // 2. Validar sesión del usuario
  // 3. Validar que los campos sean correctos
  // 4. Llamar a ProjectModel.create()
  // 5. Enviar respuesta { success: true, projectId: ... }
}
```

#### **Routes (Enrutamiento de la API)**
Ubicación: `src/routes/`

Las rutas definen los **endpoints de la API REST** y conectan las peticiones HTTP con los controladores:

- `authRoutes.js` - `/api/auth/login`, `/api/auth/register`
- `projectRoutes.js` - `/api/projects`, `/api/projects/:id`
- `budgetRoutes.js` - `/api/budgets`
- `ticketRoutes.js` - `/api/tickets`
- `adminRoutes.js` - `/api/admin/metricas`

**Responsabilidades:**
- Parsear la URL y método HTTP (GET, POST, PUT, DELETE)
- Extraer parámetros de ruta, query strings y body
- Invocar al middleware de autenticación si es necesario
- Delegar la ejecución al controlador correspondiente

**Ejemplo:**
```
GET /api/projects?estado=activo
  ↓
projectRoutes.js identifica la ruta
  ↓
Llama a ProjectController.listar()
  ↓
Retorna lista de proyectos activos
```

#### **Middlewares (Seguridad y Validación)**
Ubicación: `src/middlewares/`

Los middlewares son funciones que se ejecutan **antes de llegar al controlador** para validar permisos y autenticación:

- `authMiddleware.js` - Verificación de sesión activa y roles

**Responsabilidades:**
- Extraer y validar cookies de sesión
- Verificar que el usuario tenga permisos para acceder al recurso
- Rechazar peticiones no autorizadas (HTTP 401/403)
- Agregar información del usuario autenticado al objeto `req`

**Ejemplo:**
```javascript
// Solo administradores pueden ver los logs
if (session.rol !== 'administrador') {
  res.writeHead(403, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Acceso denegado' }));
  return;
}
```

#### **Frontend (Interfaz de Usuario)**
Ubicación: `pages/` y `public/`

El frontend está construido con **tecnologías nativas** sin frameworks:

- **HTML5** para estructura semántica
- **CSS3** con diseño responsive (flexbox, grid)
- **JavaScript Vanilla** para interactividad

**Características clave:**
- Archivo `base.css` compartido para estilos consistentes
- Navegación común en todas las páginas
- Comunicación asíncrona con el backend mediante `fetch()`
- Validación de formularios en cliente antes de enviar al servidor

**Páginas principales:**
- `Pagina.html` - Landing page institucional
- `login.html` / `register.html` - Autenticación
- `dashboard.html` - Panel principal con acceso a módulos
- `proyectos.html` - Gestión de proyectos
- `inventario.html` - Control de inventario
- `soporte.html` - Sistema de tickets
- `panelAdmin.html` - Métricas del sistema
- `actividad.html` - Logs de auditoría

#### **Database (Capa de Persistencia)**
Ubicación: `src/db/`

La base de datos está gestionada mediante:

- **database.js** - Clase singleton para conexión SQLite/MySQL
- **migrations.js** - Script de creación de tablas e inserción de datos iniciales

**Características:**
- Soporte dual: SQLite (desarrollo) y MySQL (producción)
- Migraciones automáticas al iniciar el servidor
- Integridad referencial mediante foreign keys
- Datos iniciales (roles, usuario admin, categorías)

---

### Stack Tecnológico: Node.js Puro (Sin Frameworks)

Una decisión arquitectónica clave fue **NO usar frameworks externos** como Express, React o Bootstrap. ¿Por qué?

**Ventajas académicas:**
1. **Comprensión profunda:** Entender cómo funciona HTTP, parseo de peticiones, enrutamiento manual.
2. **Control total:** No hay "magia" ni abstracciones ocultas; cada línea de código es explicable.
3. **Ligereza:** Sin dependencias innecesarias; el proyecto es rápido y eficiente.
4. **Portabilidad:** El código puede migrarse fácilmente a cualquier framework en el futuro.

**Tecnologías utilizadas:**
- **Node.js** (v14+) - Runtime de JavaScript en servidor
- **HTTP nativo** - Servidor web sin Express
- **SQLite3** - Base de datos en desarrollo (archivo local)
- **MySQL** - Base de datos en producción (servidor remoto)
- **Crypto nativo** - Cifrado de contraseñas con PBKDF2
- **Fetch API** - Comunicación cliente-servidor en el frontend
- **Dotenv** - Gestión de variables de entorno

---

## 3. RESUMEN DE DESARROLLO POR SPRINTS

El proyecto se desarrolló en **6 sprints iterativos e incrementales**, cada uno agregando funcionalidad al sistema:

### **Sprint 1: Autenticación y Control de Acceso** ✅

**Requerimientos implementados:** RF58, RF59, RF48, RF40, RF39, RF51, RF49

**Tablas creadas:**
- `roles` (administrador, gestor, operador)
- `usuarios` (id, email, contraseña_hash, nombre, rol_id, estado)

**Funcionalidades:**
- **Login y registro de usuarios** con validación de correo único
- **Cifrado de contraseñas** mediante PBKDF2 (100,000 iteraciones)
- **Sistema de sesiones** basado en cookies (HttpOnly, SameSite=Strict)
- **Control de acceso por roles** (administrador, gestor, operador)
- **Recuperación de contraseña** (preparado para envío de emails)
- **Página de dashboard** adaptada según el rol del usuario

**Impacto:** Establece la base de seguridad de toda la aplicación.

---

### **Sprint 2: Gestión de Proyectos Agroindustriales** ✅

**Requerimientos implementados:** RF41, RF13, RF62, RF25, RF23, RF15, RF70, RF71

**Tablas creadas:**
- `categorias_proyecto` (cultivos, ganadería, agroindustria, etc.)
- `proyectos` (nombre, descripción, fecha_inicio, fecha_fin, responsable_id, estado)
- `fases` (planificación, ejecución, cierre)
- `hitos` (puntos clave de control en cada fase)

**Funcionalidades:**
- **CRUD completo de proyectos** (crear, listar, editar, eliminar)
- **División del proyecto en fases** con fechas y responsables
- **Seguimiento de hitos** (cumplimiento de objetivos)
- **Búsqueda y filtrado** por nombre, categoría, estado, responsable
- **Cambio de estado** (borrador, activo, pausado, finalizado)
- **Proyectos finalizados** con visualización histórica

**Impacto:** Núcleo del sistema; permite planificar y dar seguimiento a la operación agroindustrial.

---

### **Sprint 3: Recursos y Control Financiero** ✅

**Requerimientos implementados:** RF01, RF02, RF03, RF04, RF05, RF17, RF19, RF32, RF33

**Tablas creadas:**
- `recursos` (humanos, materiales, equipos)
- `presupuestos` (asignación por proyecto)
- `gastos` (registro de egresos)
- `asignaciones_personal` (relación trabajador-proyecto)

**Funcionalidades:**
- **Planificación de recursos** por proyecto
- **Control de presupuesto** con alertas de desviación
- **Registro de gastos** con categoría y justificación
- **Asignación de personal** a proyectos específicos
- **Comparación presupuesto vs gastos** en tiempo real
- **Indicadores financieros** (% ejecutado, saldo disponible)

**Impacto:** Permite tomar decisiones informadas sobre la viabilidad financiera de los proyectos.

---

### **Sprint 4: Inventario y Gestión de Proveedores** ✅

**Requerimientos implementados:** RF06, RF08, RF09, RF16, RF18, RF43, RF45, RF29, RF31

**Tablas creadas:**
- `productos` (insumos, maquinaria, productos finales)
- `proveedores` (nombre, contacto, tipo de suministro)
- `inventario` (stock actual, ubicación, movimientos)
- `categorias_producto` (semillas, fertilizantes, maquinaria, etc.)

**Funcionalidades:**
- **Catálogo de productos** con búsqueda y filtros
- **Registro de proveedores** con historial de compras
- **Control de inventario** (entradas, salidas, stock mínimo)
- **Alertas de stock bajo** para reabastecimiento
- **Gestión de insumos orgánicos y químicos**
- **Trazabilidad de productos** (origen, lote, vencimiento)

**Impacto:** Optimiza la gestión logística y reduce pérdidas por desabastecimiento.

---

### **Sprint 5: Reportes y Visualización de Datos** ✅

**Requerimientos implementados:** RF28, RF52, RF53, RF54, RF55, RF56, RF57, RF60, RF61

**Funcionalidades:**
- **Generación de reportes en PDF** (proyectos, inventario, finanzas)
- **Exportación a Excel** para análisis externo
- **Visualización de proyectos finalizados** con métricas de éxito
- **Catálogo de servicios** ofrecidos por la organización
- **Páginas informativas** (misión, visión, objetivos, contacto)
- **Dashboard ejecutivo** con indicadores clave (KPIs)

**Impacto:** Facilita la toma de decisiones y comunicación con stakeholders.

---

### **Sprint 6: Administración Avanzada y Soporte** ✅

**Requerimientos implementados:** RF34, RF36, RF37, RF46

**Tablas creadas:**
- `tickets` (sistema de soporte técnico)
- `logs_sistema` (auditoría de acciones)

**Funcionalidades:**
- **Sistema de tickets** (crear, asignar, resolver incidencias)
- **Panel administrativo avanzado** con métricas del sistema
- **Monitoreo de actividad** (logs de acceso, cambios, errores)
- **Visualización de logs del sistema** con filtros (nivel, origen, fecha)
- **Estadísticas de tickets** (abiertos, en proceso, resueltos)
- **Gestión de usuarios del sistema** (activar, desactivar, cambiar roles)

**Impacto:** Permite mantener el sistema saludable y dar soporte efectivo a los usuarios.

---

## 4. FLUJO GENERAL DEL SISTEMA

### Flujo de Autenticación (Ejemplo: Login de Usuario)

```
1. Usuario accede a login.html
   ↓
2. Ingresa email y contraseña
   ↓
3. JavaScript captura el formulario y hace:
   fetch('/api/auth/login', {
     method: 'POST',
     body: JSON.stringify({ email, password }),
     headers: { 'Content-Type': 'application/json' }
   })
   ↓
4. Servidor recibe petición en authRoutes.js
   ↓
5. authController.login() procesa:
   - Busca usuario por email en la BD
   - Verifica contraseña con PBKDF2
   - Crea sesión y genera cookie
   ↓
6. Respuesta JSON:
   { success: true, user: { nombre, rol } }
   ↓
7. JavaScript almacena datos en localStorage
   ↓
8. Redirección a dashboard.html
   ↓
9. Dashboard verifica sesión y muestra módulos según el rol
```

---

### Flujo CRUD (Ejemplo: Crear un Proyecto)

```
1. Usuario autenticado navega a proyectos.html
   ↓
2. Hace clic en "Nuevo Proyecto"
   ↓
3. Completa formulario:
   - Nombre del proyecto
   - Categoría
   - Fecha de inicio y fin
   - Descripción
   ↓
4. JavaScript valida campos y hace:
   fetch('/api/projects', {
     method: 'POST',
     credentials: 'include', // Envía cookie de sesión
     body: JSON.stringify(datosProyecto)
   })
   ↓
5. Servidor recibe en projectRoutes.js
   ↓
6. authMiddleware.extractSession():
   - Extrae cookie de sesión
   - Valida que esté activa
   - Verifica permisos (gestor o admin)
   ↓
7. projectController.crear():
   - Valida datos de negocio
   - Llama a ProjectModel.create()
   ↓
8. ProjectModel.create():
   - Ejecuta INSERT en la tabla proyectos
   - Retorna ID del nuevo proyecto
   ↓
9. Controller responde:
   { success: true, projectId: 123 }
   ↓
10. JavaScript actualiza la tabla de proyectos
    sin recargar la página (AJAX)
```

---

### Comunicación Frontend ↔ Backend ↔ Database

**Ejemplo concreto: Listar Proyectos Activos**

**Frontend (proyectos.html):**
```javascript
async function cargarProyectos() {
  const response = await fetch('/api/projects?estado=activo', {
    credentials: 'include' // Importante: envía la cookie de sesión
  });
  const data = await response.json();
  
  // Renderizar proyectos en la tabla
  data.projects.forEach(proyecto => {
    // Crear fila HTML con los datos
  });
}
```

**Backend (projectRoutes.js):**
```javascript
if (pathname === '/api/projects' && method === 'GET') {
  // Extraer parámetros de query
  req.query = parsedUrl.query;
  
  // Verificar sesión
  const sesion = AuthMiddleware.extractSession(req);
  
  // Llamar al controlador
  return ProjectController.listar(req, res);
}
```

**Controller (projectController.js):**
```javascript
async listar(req, res) {
  const { estado } = req.query;
  
  // Obtener proyectos del modelo
  const proyectos = await ProjectModel.findByStatus(estado);
  
  // Responder en formato JSON
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ projects: proyectos }));
}
```

**Model (projectModel.js):**
```javascript
async findByStatus(estado) {
  const query = `
    SELECT p.*, c.nombre as categoria_nombre, u.nombre as responsable_nombre
    FROM proyectos p
    JOIN categorias_proyecto c ON p.categoria_id = c.id
    JOIN usuarios u ON p.responsable_id = u.id
    WHERE p.estado = ?
  `;
  return await db.all(query, [estado]);
}
```

**Database (SQLite/MySQL):**
```sql
-- Ejecución de la consulta SQL
-- Retorna array de objetos con los proyectos
```

---

## 5. BUENAS PRÁCTICAS APLICADAS

### 1. Código Modular y Reutilizable

**Separación por responsabilidades:**
- Cada módulo tiene una única responsabilidad clara
- Funciones pequeñas y específicas (principio de responsabilidad única)
- Reutilización mediante importación de módulos

**Ejemplo:**
```javascript
// En lugar de repetir código de autenticación en cada controlador,
// se creó un middleware reutilizable:
const sesion = AuthMiddleware.extractSession(req);
```

---

### 2. Seguridad de Primer Nivel

**Contraseñas seguras:**
- Cifrado con **PBKDF2** (100,000 iteraciones + salt único)
- NUNCA se almacenan contraseñas en texto plano
- No se devuelven hashes en las respuestas de la API

**Prevención de SQL Injection:**
```javascript
// Uso de consultas parametrizadas (prepared statements)
const query = 'SELECT * FROM usuarios WHERE email = ?';
db.get(query, [email]); // Parámetro escapado automáticamente
```

**Sesiones seguras:**
- Cookies HttpOnly (no accesibles desde JavaScript del cliente)
- SameSite=Strict (prevención de CSRF)
- Expiración automática después de 24 horas o 2 horas de inactividad

**Control de acceso por roles:**
```javascript
// Verificación en cada endpoint sensible
if (sesion.rol !== 'administrador') {
  return res.writeHead(403, { error: 'Acceso denegado' });
}
```

---

### 3. Integridad de Datos

**Base de datos relacional con foreign keys:**
```sql
CREATE TABLE proyectos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  categoria_id INTEGER NOT NULL,
  responsable_id INTEGER NOT NULL,
  FOREIGN KEY (categoria_id) REFERENCES categorias_proyecto(id),
  FOREIGN KEY (responsable_id) REFERENCES usuarios(id)
);
```

**Validaciones en múltiples capas:**
1. **Frontend:** Validación inmediata (email válido, campos requeridos)
2. **Controller:** Validación de reglas de negocio
3. **Model:** Validación de tipos de datos antes de INSERT
4. **Database:** Constraints (NOT NULL, UNIQUE, CHECK)

---

### 4. Manejo de Errores Robusto

**Try-catch en todas las operaciones asíncronas:**
```javascript
try {
  const proyecto = await ProjectModel.findById(id);
  // Procesamiento...
} catch (error) {
  console.error('Error al obtener proyecto:', error);
  res.writeHead(500, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Error interno del servidor' }));
}
```

**Respuestas HTTP consistentes:**
- 200 OK - Operación exitosa
- 201 Created - Recurso creado
- 400 Bad Request - Datos inválidos
- 401 Unauthorized - No autenticado
- 403 Forbidden - Sin permisos
- 404 Not Found - Recurso no existe
- 500 Internal Server Error - Error del servidor

---

### 5. Experiencia de Usuario (UX)

**Diseño consistente:**
- Archivo `base.css` compartido en todas las páginas
- Navegación idéntica en todo el sistema
- Paleta de colores coherente (verde agrícola)

**Retroalimentación visual:**
- Mensajes de éxito/error claros
- Indicadores de carga durante operaciones asíncronas
- Confirmación antes de acciones destructivas (eliminar)

**Responsive Design:**
- Uso de flexbox y media queries
- Adaptable a móviles, tablets y escritorio

---

### 6. Auditoría y Trazabilidad

**Sistema de logs:**
- Registro de todas las acciones importantes (login, creación de proyectos, modificaciones)
- Niveles de log: INFO, WARNING, ERROR
- Almacenamiento persistente en tabla `logs_sistema`
- Filtrado por fecha, nivel, origen, usuario

**Ejemplo:**
```javascript
await LogModel.create({
  nivel: 'INFO',
  origen: 'auth',
  mensaje: 'Usuario autenticado exitosamente',
  usuario_id: usuario.id,
  ip_address: req.headers['x-forwarded-for']
});
```

---

### 7. Documentación Técnica

Cada módulo incluye:
- Comentarios JSDoc en funciones clave
- README.md en cada carpeta (`src/controllers/README.md`, etc.)
- Descripción de requerimientos funcionales cubiertos
- Ejemplos de uso

---

## 6. CONCLUSIÓN

### Beneficios del Sistema AgroTechNova

**Para la Organización:**
- ✅ **Centralización de información** - Toda la operación en un solo lugar
- ✅ **Mejora en la toma de decisiones** - Reportes y métricas en tiempo real
- ✅ **Control financiero** - Seguimiento de presupuesto vs gastos
- ✅ **Optimización de recursos** - Prevención de desabastecimiento y sobrecostos
- ✅ **Trazabilidad completa** - Auditoría de todas las acciones

**Para los Usuarios:**
- ✅ **Interfaz intuitiva** - Fácil de aprender y usar
- ✅ **Acceso según rol** - Cada usuario ve solo lo que necesita
- ✅ **Disponibilidad 24/7** - Acceso desde cualquier dispositivo con navegador
- ✅ **Seguridad garantizada** - Protección de datos mediante cifrado y sesiones

---

### Escalabilidad y Crecimiento

El sistema está diseñado para **crecer fácilmente**:

**Escalabilidad horizontal:**
- Migración de SQLite a MySQL ya implementada (solo cambiar conexión)
- Preparado para múltiples instancias de servidor (load balancing)
- Sesiones pueden moverse a Redis para distribución

**Extensibilidad funcional:**
- Arquitectura modular permite agregar nuevos módulos sin afectar existentes
- API REST lista para integrarse con aplicaciones móviles
- Preparado para agregar notificaciones push, webhooks, integraciones externas

**Ejemplo de crecimiento futuro:**
- Sprint 7: Aplicación móvil (consume la misma API)
- Sprint 8: Integración con sensores IoT (temperatura, humedad)
- Sprint 9: Machine Learning para predicción de cosechas
- Sprint 10: Sistema de facturación electrónica

---

### Aprendizajes Técnicos Aplicados

Durante el desarrollo del proyecto se aplicaron conocimientos de:

✅ **Programación backend:** Node.js, HTTP, manejo de peticiones asíncronas  
✅ **Bases de datos:** Diseño de esquemas relacionales, SQL, integridad referencial  
✅ **Arquitectura de software:** MVC, separación de capas, modularización  
✅ **Seguridad:** Cifrado, autenticación, autorización, prevención de vulnerabilidades  
✅ **Frontend:** HTML5, CSS3, JavaScript, DOM, fetch API  
✅ **Control de versiones:** Git, GitHub, trabajo colaborativo  
✅ **Metodologías ágiles:** Sprints, historias de usuario, desarrollo iterativo

---

### Reflexión Final

AgroTechNova demuestra que es posible construir un **sistema robusto, escalable y profesional** utilizando únicamente tecnologías nativas, sin dependencias de frameworks costosos o complejos.

El proyecto no solo cumple con los requerimientos funcionales establecidos, sino que también sirve como **plataforma educativa** para comprender los fundamentos de la arquitectura web moderna.

Cada línea de código es **explicable y comprensible**, sin "magia" oculta detrás de abstracciones de frameworks. Esto permite que cualquier desarrollador pueda entender, mantener y extender el sistema en el futuro.

---

## 📊 DATOS TÉCNICOS DEL PROYECTO

**Líneas de código aproximadas:** 15,000+  
**Archivos totales:** 70+  
**Endpoints API:** 60+  
**Tablas de base de datos:** 15  
**Páginas HTML:** 20+  
**Sprints completados:** 6/6 (100%)  
**Requerimientos funcionales cubiertos:** 50+  

**Tiempo de desarrollo:** 6 sprints (aproximadamente 12 semanas)  
**Equipo:** Desarrollo académico colaborativo  
**Stack:** Node.js + SQLite/MySQL + HTML/CSS/JS Vanilla  

---

## 🎤 GUION PARA EXPOSICIÓN ORAL (3-5 minutos)

### Introducción (30 segundos)
"Buenos días/tardes. Hoy presentamos **AgroTechNova**, un sistema web completo para la gestión integral de proyectos agroindustriales. Este sistema permite administrar proyectos, recursos, presupuestos, inventario y generar reportes ejecutivos, todo desde una plataforma centralizada y segura."

### Arquitectura (1 minuto)
"El sistema está construido con **Node.js puro**, sin frameworks externos, siguiendo una **arquitectura en capas** inspirada en MVC. Tenemos la capa de presentación con HTML, CSS y JavaScript vanilla; la capa de aplicación con routes, middlewares, controllers y models; y la capa de datos con SQLite en desarrollo y MySQL en producción. Esta separación nos da control total, código limpio y facilita el mantenimiento."

### Desarrollo por Sprints (1 minuto)
"El proyecto se desarrolló en 6 sprints:
- Sprint 1 estableció la autenticación con cifrado PBKDF2 y control de acceso por roles.
- Sprint 2 implementó la gestión completa de proyectos con fases e hitos.
- Sprint 3 agregó el control financiero con presupuestos y gastos.
- Sprint 4 incorporó el inventario y gestión de proveedores.
- Sprint 5 habilitó la generación de reportes en PDF y Excel.
- Sprint 6 completó el sistema con soporte técnico mediante tickets y monitoreo avanzado con logs de auditoría."

### Flujo de Operación (1 minuto)
"Voy a explicar cómo funciona el sistema con un ejemplo: cuando un usuario crea un proyecto, el frontend envía una petición fetch al endpoint `/api/projects`. El servidor valida la sesión mediante cookies HttpOnly, el controlador procesa la lógica de negocio, el modelo ejecuta el INSERT en la base de datos con consultas parametrizadas para prevenir SQL injection, y finalmente se devuelve una respuesta JSON al cliente, que actualiza la interfaz sin recargar la página."

### Buenas Prácticas (30 segundos)
"Aplicamos buenas prácticas en todo el desarrollo: código modular y reutilizable, seguridad con cifrado de contraseñas y sesiones HttpOnly, validaciones en múltiples capas, manejo robusto de errores, y un sistema de logs para auditoría completa."

### Conclusión (30 segundos)
"AgroTechNova es un sistema escalable y profesional que demuestra que con tecnologías nativas se pueden construir aplicaciones robustas. El sistema está listo para producción y preparado para crecer con nuevas funcionalidades como aplicaciones móviles o integración con IoT. Gracias por su atención. ¿Alguna pregunta?"

---

**Documento generado para: Proyecto AgroSpinoff2 - AgroTechNova**  
**Fecha:** Octubre 2025  
**Universidad Pontificia Bolivariana - Proyecto Integrador 1**
