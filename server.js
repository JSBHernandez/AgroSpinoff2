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
 * En futuros sprints, aquí se importarán los módulos de /src/routes
 * @param {object} req - Objeto de solicitud HTTP
 * @param {object} res - Objeto de respuesta HTTP
 */
function handleAPIRoutes(req, res) {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;

  // Ejemplo de estructura para futuros endpoints
  // Las rutas se agregarán en cada sprint según sea necesario

  if (pathname.startsWith('/api/')) {
    // En Sprint 1: se agregarán rutas de autenticación
    // En Sprint 2: se agregarán rutas de proyectos
    // En Sprint 3: se agregarán rutas de recursos
    // etc.

    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Ruta API no encontrada' }));
    return;
  }

  return false; // No es una ruta API
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

  // Ruta raíz -> redirigir a página principal
  if (pathname === '/') {
    pathname = '/pages/Pagina.html';
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
 * Iniciar el servidor
 */
server.listen(PORT, HOST, () => {
  console.log('='.repeat(50));
  console.log('🚀 SERVIDOR AGROTECHNOVA INICIADO');
  console.log('='.repeat(50));
  console.log(`📡 Servidor corriendo en: http://${HOST}:${PORT}`);
  console.log(`📂 Directorio base: ${__dirname}`);
  console.log(`⏰ Hora de inicio: ${new Date().toLocaleString()}`);
  console.log('='.repeat(50));
  console.log('Presiona CTRL+C para detener el servidor');
  console.log('='.repeat(50));
});

/**
 * Manejo de cierre del servidor
 */
process.on('SIGINT', () => {
  console.log('\n\n🛑 Cerrando servidor...');
  server.close(() => {
    console.log('✅ Servidor cerrado correctamente');
    process.exit(0);
  });
});

process.on('SIGTERM', () => {
  console.log('\n\n🛑 Señal SIGTERM recibida, cerrando servidor...');
  server.close(() => {
    console.log('✅ Servidor cerrado correctamente');
    process.exit(0);
  });
});
