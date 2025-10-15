/**
 * SERVIDOR PRINCIPAL - AGROTECHNOVA
 * 
 * Archivo de inicialización del servidor HTTP usando Node.js puro.
 * Sin frameworks externos (no Express).
 * 
 * Funcionalidades:
 * - Servir archivos estáticos (HTML, CSS, JS, imágenes)
 * - Manejar rutas API REST
 * - Integrar con módulos de rutas definidos en /src/routes
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

// Importar configuración de base de datos y rutas
const Database = require('./src/db/database');
const { initDatabase } = require('./src/db/migrations');
const handleAuthRoutes = require('./src/routes/authRoutes');
const handleUserRoutes = require('./src/routes/userRoutes');
const { startSessionCleaner } = require('./src/utils/sessionManager');

// Configuración del servidor
const PORT = process.env.PORT || 3000;
const HOST = '127.0.0.1';

/**
 * Tipos MIME para servir archivos estáticos correctamente
 */
const MIME_TYPES = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'text/javascript',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.txt': 'text/plain'
};

/**
 * Función para servir archivos estáticos
 * @param {string} filePath - Ruta del archivo solicitado
 * @param {object} res - Objeto de respuesta HTTP
 */
function serveStaticFile(filePath, res) {
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/html' });
      res.end('<h1>404 - Archivo no encontrado</h1>');
      return;
    }

    const ext = path.extname(filePath);
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';

    res.writeHead(200, { 'Content-Type': contentType });
    res.end(data);
  });
}

/**
 * Función para manejar rutas API
 * @param {object} req - Objeto de solicitud HTTP
 * @param {object} res - Objeto de respuesta HTTP
 */
function handleAPIRoutes(req, res) {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;
  const method = req.method;

  // Habilitar CORS para desarrollo (eliminar en producción)
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  // Manejar preflight OPTIONS
  if (method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  // Rutas de autenticación (/api/auth/*)
  if (pathname.startsWith('/api/auth/')) {
    handleAuthRoutes(pathname, method, req, res);
    return;
  }

  // Rutas de usuarios (/api/users/* y /api/roles)
  if (pathname.startsWith('/api/users/') || pathname === '/api/users' || pathname === '/api/roles') {
    handleUserRoutes(pathname, method, req, res);
    return;
  }

  // Ruta API no encontrada
  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Ruta API no encontrada' }));
}

/**
 * Servidor HTTP principal
 */
const server = http.createServer((req, res) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);

  const parsedUrl = url.parse(req.url, true);
  let pathname = parsedUrl.pathname;

  // Manejar rutas API primero
  if (pathname.startsWith('/api/')) {
    handleAPIRoutes(req, res);
    return;
  }

  // Redirecciones amigables para páginas comunes
  if (pathname === '/') {
    pathname = '/pages/Pagina.html';
  } else if (pathname === '/login' || pathname === '/login.html') {
    pathname = '/pages/login.html';
  } else if (pathname === '/register' || pathname === '/register.html') {
    pathname = '/pages/register.html';
  } else if (pathname === '/dashboard' || pathname === '/dashboard.html') {
    pathname = '/pages/dashboard.html';
  } else if (pathname === '/usuarios' || pathname === '/usuarios.html') {
    pathname = '/pages/usuarios.html';
  }

  // Construir ruta del archivo
  const filePath = path.join(__dirname, pathname);

  // Verificar si el archivo existe
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
      res.writeHead(404, { 'Content-Type': 'text/html' });
      res.end('<h1>404 - Página no encontrada</h1>');
      return;
    }

    // Servir el archivo
    serveStaticFile(filePath, res);
  });
});

/**
 * Inicializar base de datos y arrancar servidor
 */
async function startServer() {
  try {
    console.log('🔧 Inicializando base de datos...');
    
    // Inicializar base de datos SQLite
    await Database.initialize();
    await initDatabase();
    
    console.log('✅ Base de datos lista');

    // Iniciar limpiador de sesiones (cada 15 minutos)
    startSessionCleaner();
    console.log('✅ Limpiador de sesiones activo');

    // Iniciar servidor HTTP
    server.listen(PORT, HOST, () => {
      console.log('='.repeat(50));
      console.log('🚀 SERVIDOR AGROTECHNOVA INICIADO');
      console.log('='.repeat(50));
      console.log(`📡 Servidor corriendo en: http://${HOST}:${PORT}`);
      console.log(`📂 Directorio base: ${__dirname}`);
      console.log(`⏰ Hora de inicio: ${new Date().toLocaleString()}`);
      console.log('='.repeat(50));
      console.log('📋 ENDPOINTS DISPONIBLES:');
      console.log('   POST /api/auth/login');
      console.log('   POST /api/auth/logout');
      console.log('   GET  /api/auth/session');
      console.log('   POST /api/auth/forgot-password');
      console.log('   GET  /api/users (admin)');
      console.log('   POST /api/users (admin)');
      console.log('   GET  /api/roles (autenticado)');
      console.log('='.repeat(50));
      console.log('Presiona CTRL+C para detener el servidor');
      console.log('='.repeat(50));
    });

  } catch (error) {
    console.error('❌ Error al iniciar servidor:', error);
    process.exit(1);
  }
}

// Iniciar servidor
startServer();

/**
 * Manejo de cierre del servidor
 */
process.on('SIGINT', () => {
  console.log('\n\n🛑 Cerrando servidor...');
  server.close(() => {
    Database.close();
    console.log('✅ Servidor cerrado correctamente');
    process.exit(0);
  });
});

process.on('SIGTERM', () => {
  console.log('\n\n🛑 Señal SIGTERM recibida, cerrando servidor...');
  server.close(() => {
    Database.close();
    console.log('✅ Servidor cerrado correctamente');
    process.exit(0);
  });
});
