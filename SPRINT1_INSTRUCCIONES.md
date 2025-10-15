# 📝 SPRINT 1 - IMPLEMENTACIÓN COMPLETA

## ✅ Archivos Ya Creados

### 1. Utilidades (`src/utils/`)
- ✅ `crypto.js` - Cifrado de contraseñas con Node.js nativo
- ✅ `validators.js` - Validaciones de datos
- ✅ `sessionManager.js` - Manejo de sesiones en memoria

### 2. Modelos (`src/models/`)
- ✅ `roleModel.js` - Gestión de roles y permisos
- ✅ `userModel.js` - Gestión de usuarios

### 3. Base de Datos (`src/db/`)
- ✅ `database.js` - Conexión SQLite (ya existía)
- ✅ `migrations.js` - Script de inicialización

---

## 🚀 PASOS PARA COMPLETAR EL SPRINT 1

### PASO 1: Ejecutar las migraciones

```bash
# Instalar dependencias (solo sqlite3)
npm install

# Ejecutar migraciones para crear las tablas
node src/db/migrations.js
```

**Resultado esperado:**
- Se crea la base de datos en `database/agrotechnova.db`
- Se crean las tablas `roles` y `usuarios`
- Se inserta el usuario administrador:
  - **Email:** admin@agrotechnova.com
  - **Password:** Admin123!

---

### PASO 2: Crear los controladores

Necesitas crear estos 2 archivos:

#### `src/controllers/authController.js`

```javascript
/**
 * CONTROLADOR DE AUTENTICACIÓN
 * 
 * Maneja login, logout y recuperación de contraseña
 * 
 * Cumple con:
 * - RF58: Inicio de sesión seguro
 * - RF59: Recuperación de contraseña
 */

const url = require('url');
const UserModel = require('../models/userModel');
const { verifyPassword, generateToken } = require('../utils/crypto');
const { createSession, destroySession, getSession } = require('../utils/sessionManager');
const { isValidEmail, isNotEmpty } = require('../utils/validators');

class AuthController {
  /**
   * POST /api/auth/login
   * Inicia sesión de usuario
   */
  static async login(req, res) {
    let body = '';

    req.on('data', chunk => {
      body += chunk.toString();
    });

    req.on('end', async () => {
      try {
        const { email, password } = JSON.parse(body);

        // Validaciones
        if (!isValidEmail(email)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Email inválido' }));
          return;
        }

        if (!isNotEmpty(password)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Contraseña requerida' }));
          return;
        }

        // Buscar usuario
        const usuario = await UserModel.findByEmail(email);

        if (!usuario) {
          res.writeHead(401, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Credenciales inválidas' }));
          return;
        }

        // Verificar que el usuario esté activo (RF51)
        if (usuario.estado !== 'activo') {
          res.writeHead(403, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Usuario inactivo' }));
          return;
        }

        // Verificar contraseña
        const isValid = verifyPassword(password, usuario.password_hash);

        if (!isValid) {
          res.writeHead(401, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Credenciales inválidas' }));
          return;
        }

        // Actualizar último acceso
        await UserModel.updateLastAccess(usuario.id);

        // Crear sesión
        const sessionId = createSession({
          id: usuario.id,
          email: usuario.email,
          nombre: usuario.nombre,
          rol: usuario.rol_nombre
        });

        // Configurar cookie de sesión
        res.writeHead(200, {
          'Content-Type': 'application/json',
          'Set-Cookie': `sessionId=${sessionId}; HttpOnly; Path=/; Max-Age=86400` // 24h
        });

        res.end(JSON.stringify({
          success: true,
          user: {
            id: usuario.id,
            nombre: usuario.nombre,
            email: usuario.email,
            rol: usuario.rol_nombre
          }
        }));

      } catch (error) {
        console.error('❌ Error en login:', error);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Error interno del servidor' }));
      }
    });
  }

  /**
   * POST /api/auth/logout
   * Cierra sesión de usuario
   */
  static async logout(req, res) {
    try {
      // Obtener cookie de sesión
      const cookies = req.headers.cookie || '';
      const sessionId = cookies.split('; ')
        .find(row => row.startsWith('sessionId='))
        ?.split('=')[1];

      if (sessionId) {
        destroySession(sessionId);
      }

      // Eliminar cookie
      res.writeHead(200, {
        'Content-Type': 'application/json',
        'Set-Cookie': 'sessionId=; HttpOnly; Path=/; Max-Age=0'
      });

      res.end(JSON.stringify({ success: true, message: 'Sesión cerrada' }));

    } catch (error) {
      console.error('❌ Error en logout:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Error al cerrar sesión' }));
    }
  }

  /**
   * GET /api/auth/session
   * Verifica si hay una sesión activa
   */
  static async checkSession(req, res) {
    try {
      const cookies = req.headers.cookie || '';
      const sessionId = cookies.split('; ')
        .find(row => row.startsWith('sessionId='))
        ?.split('=')[1];

      if (!sessionId) {
        res.writeHead(401, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ authenticated: false }));
        return;
      }

      const session = getSession(sessionId);

      if (!session) {
        res.writeHead(401, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ authenticated: false }));
        return;
      }

      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({
        authenticated: true,
        user: {
          id: session.userId,
          email: session.email,
          nombre: session.nombre,
          rol: session.rol
        }
      }));

    } catch (error) {
      console.error('❌ Error en checkSession:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Error al verificar sesión' }));
    }
  }

  /**
   * POST /api/auth/forgot-password
   * Recuperación de contraseña (RF59)
   * NOTA: Simulado sin envío real de email
   */
  static async forgotPassword(req, res) {
    let body = '';

    req.on('data', chunk => {
      body += chunk.toString();
    });

    req.on('end', async () => {
      try {
        const { email } = JSON.parse(body);

        if (!isValidEmail(email)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Email inválido' }));
          return;
        }

        // Verificar que el usuario existe (sin revelar si existe o no - RF59)
        const usuario = await UserModel.findByEmail(email);

        // Generar token (simulado)
        const resetToken = generateToken();

        // En producción, aquí se enviaría el email con el token
        // Por ahora, solo se simula
        console.log(`🔑 Token de recuperación para ${email}: ${resetToken}`);

        // Siempre responder lo mismo (seguridad - RF59)
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
          success: true,
          message: 'Si el email existe, recibirás instrucciones para recuperar tu contraseña.'
        }));

      } catch (error) {
        console.error('❌ Error en forgot-password:', error);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Error al procesar solicitud' }));
      }
    });
  }
}

module.exports = AuthController;
```

#### `src/controllers/userController.js`

```javascript
/**
 * CONTROLADOR DE USUARIOS
 * 
 * Gestión CRUD de usuarios
 * 
 * Cumple con:
 * - RF39: Actualización de la lista de usuarios
 * - RF40: Modificación de datos de usuario
 * - RF51: Activar y desactivar usuarios
 */

const url = require('url');
const UserModel = require('../models/userModel');
const RoleModel = require('../models/roleModel');
const { validatePasswordStrength } = require('../utils/crypto');
const { isValidEmail, isNotEmpty, isValidId, isValidRole, isValidEstado } = require('../utils/validators');
const { destroyUserSessions } = require('../utils/sessionManager');

class UserController {
  /**
   * GET /api/users
   * Lista todos los usuarios (solo admin)
   */
  static async list(req, res) {
    try {
      const usuarios = await UserModel.findAll();

      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({
        success: true,
        users: usuarios
      }));

    } catch (error) {
      console.error('❌ Error al listar usuarios:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Error al obtener usuarios' }));
    }
  }

  /**
   * GET /api/users/:id
   * Obtiene un usuario específico
   */
  static async getById(req, res, userId) {
    try {
      if (!isValidId(userId)) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'ID inválido' }));
        return;
      }

      const usuario = await UserModel.findById(userId);

      if (!usuario) {
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Usuario no encontrado' }));
        return;
      }

      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({
        success: true,
        user: usuario
      }));

    } catch (error) {
      console.error('❌ Error al obtener usuario:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Error al obtener usuario' }));
    }
  }

  /**
   * POST /api/users
   * Crea un nuevo usuario (solo admin - RF39)
   */
  static async create(req, res) {
    let body = '';

    req.on('data', chunk => {
      body += chunk.toString();
    });

    req.on('end', async () => {
      try {
        const { nombre, email, password, rol_id } = JSON.parse(body);

        // Validaciones
        if (!isNotEmpty(nombre, 3)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Nombre debe tener al menos 3 caracteres' }));
          return;
        }

        if (!isValidEmail(email)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Email inválido' }));
          return;
        }

        const passwordValidation = validatePasswordStrength(password);
        if (!passwordValidation.valid) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: passwordValidation.message }));
          return;
        }

        if (rol_id && !isValidRole(rol_id)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Rol inválido' }));
          return;
        }

        // Crear usuario
        const userId = await UserModel.create({
          nombre,
          email,
          password,
          rol_id: rol_id || 3 // Por defecto: productor
        });

        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
          success: true,
          message: 'Usuario creado exitosamente',
          userId
        }));

      } catch (error) {
        console.error('❌ Error al crear usuario:', error);
        
        if (error.message.includes('email')) {
          res.writeHead(409, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: error.message }));
        } else {
          res.writeHead(500, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Error al crear usuario' }));
        }
      }
    });
  }

  /**
   * PUT /api/users/:id
   * Actualiza un usuario (RF40)
   */
  static async update(req, res, userId) {
    let body = '';

    req.on('data', chunk => {
      body += chunk.toString();
    });

    req.on('end', async () => {
      try {
        if (!isValidId(userId)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'ID inválido' }));
          return;
        }

        const updates = JSON.parse(body);

        // Validaciones
        if (updates.nombre && !isNotEmpty(updates.nombre, 3)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Nombre debe tener al menos 3 caracteres' }));
          return;
        }

        if (updates.email && !isValidEmail(updates.email)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Email inválido' }));
          return;
        }

        if (updates.rol_id && !isValidRole(updates.rol_id)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Rol inválido' }));
          return;
        }

        // Actualizar
        const success = await UserModel.update(userId, updates);

        if (!success) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Usuario no encontrado' }));
          return;
        }

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
          success: true,
          message: 'Usuario actualizado exitosamente'
        }));

      } catch (error) {
        console.error('❌ Error al actualizar usuario:', error);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Error al actualizar usuario' }));
      }
    });
  }

  /**
   * PATCH /api/users/:id/status
   * Activa o desactiva un usuario (RF51)
   */
  static async changeStatus(req, res, userId) {
    let body = '';

    req.on('data', chunk => {
      body += chunk.toString();
    });

    req.on('end', async () => {
      try {
        if (!isValidId(userId)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'ID inválido' }));
          return;
        }

        const { estado } = JSON.parse(body);

        if (!isValidEstado(estado)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Estado inválido (debe ser "activo" o "inactivo")' }));
          return;
        }

        // No permitir desactivar al admin principal
        if (userId === '1' && estado === 'inactivo') {
          res.writeHead(403, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'No se puede desactivar el administrador principal' }));
          return;
        }

        const success = await UserModel.changeStatus(userId, estado);

        if (!success) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Usuario no encontrado' }));
          return;
        }

        // Si se desactiva, cerrar todas sus sesiones
        if (estado === 'inactivo') {
          destroyUserSessions(parseInt(userId));
        }

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
          success: true,
          message: `Usuario ${estado === 'activo' ? 'activado' : 'desactivado'} exitosamente`
        }));

      } catch (error) {
        console.error('❌ Error al cambiar estado:', error);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Error al cambiar estado del usuario' }));
      }
    });
  }

  /**
   * PATCH /api/users/:id/password
   * Cambia la contraseña de un usuario
   */
  static async changePassword(req, res, userId) {
    let body = '';

    req.on('data', chunk => {
      body += chunk.toString();
    });

    req.on('end', async () => {
      try {
        if (!isValidId(userId)) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'ID inválido' }));
          return;
        }

        const { newPassword } = JSON.parse(body);

        const passwordValidation = validatePasswordStrength(newPassword);
        if (!passwordValidation.valid) {
          res.writeHead(400, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: passwordValidation.message }));
          return;
        }

        const success = await UserModel.updatePassword(userId, newPassword);

        if (!success) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Usuario no encontrado' }));
          return;
        }

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({
          success: true,
          message: 'Contraseña actualizada exitosamente'
        }));

      } catch (error) {
        console.error('❌ Error al cambiar contraseña:', error);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Error al cambiar contraseña' }));
      }
    });
  }
}

module.exports = UserController;
```

---

### PASO 3: Crear middlewares

Crear `src/middlewares/authMiddleware.js`:

```javascript
/**
 * MIDDLEWARE DE AUTENTICACIÓN
 * 
 * Verifica que el usuario esté autenticado
 */

const { getSession } = require('../utils/sessionManager');

/**
 * Extrae la sesión de las cookies
 * 
 * @param {Object} req - Request
 * @returns {Object|null} - Sesión o null
 */
function extractSession(req) {
  const cookies = req.headers.cookie || '';
  const sessionId = cookies.split('; ')
    .find(row => row.startsWith('sessionId='))
    ?.split('=')[1];

  if (!sessionId) {
    return null;
  }

  return getSession(sessionId);
}

/**
 * Middleware de autenticación
 * Adjunta la sesión a req.session
 * 
 * @param {Object} req
 * @param {Object} res
 * @returns {boolean} - true si autenticado, false si no
 */
function requireAuth(req, res) {
  const session = extractSession(req);

  if (!session) {
    res.writeHead(401, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      error: 'No autenticado',
      message: 'Debes iniciar sesión para acceder a este recurso'
    }));
    return false;
  }

  // Adjuntar sesión al request
  req.session = session;
  return true;
}

/**
 * Middleware para verificar rol de administrador
 * 
 * @param {Object} req
 * @param {Object} res
 * @returns {boolean}
 */
function requireAdmin(req, res) {
  // Primero verificar autenticación
  if (!requireAuth(req, res)) {
    return false;
  }

  // Verificar rol
  if (req.session.rol !== 'administrador') {
    res.writeHead(403, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      error: 'Acceso denegado',
      message: 'No tienes permisos para acceder a este recurso'
    }));
    return false;
  }

  return true;
}

module.exports = {
  requireAuth,
  requireAdmin,
  extractSession
};
```

---

**NOTA: La respuesta continúa siendo muy extensa. He creado los archivos principales. ¿Deseas que:**

1. ✅ **Continúe creando los archivos de rutas y la integración en server.js**
2. ✅ **Cree un script de prueba completo**
3. ✅ **Actualice el frontend (login.html) para conectar con el backend**
4. ✅ **Genere la documentación final del Sprint 1**

**¿Por cuál opción prefieres que continúe?** O si prefieres, puedo crear un archivo `SPRINT1_COMPLETE.md` con TODO el código restante de una vez.
