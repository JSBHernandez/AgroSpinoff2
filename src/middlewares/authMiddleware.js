/**
 * MIDDLEWARE DE AUTENTICACIÓN - AGROTECHNOVA
 * 
 * Protege rutas y verifica permisos de acceso.
 * 
 * Cumple con:
 * - RNF16: Autenticación y control de accesos
 * - RF49: Control de permisos por rol
 */

const { getSession } = require('../utils/sessionManager');

class AuthMiddleware {
  /**
   * Extrae y valida la sesión desde las cookies
   */
  static extractSession(req) {
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
   * Middleware: Requiere autenticación
   * Verifica que el usuario tenga una sesión activa
   */
  static requireAuth(req, res, next) {
    const session = AuthMiddleware.extractSession(req);

    if (!session) {
      res.writeHead(401, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        error: 'No autenticado',
        message: 'Debe iniciar sesión para acceder a este recurso'
      }));
      return;
    }

    // Agregar información de sesión al request
    req.session = session;
    next();
  }

  /**
   * Middleware: Requiere rol de administrador
   * Solo permite acceso a usuarios con rol "admin"
   */
  static requireAdmin(req, res, next) {
    const session = AuthMiddleware.extractSession(req);

    if (!session) {
      res.writeHead(401, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        error: 'No autenticado',
        message: 'Debe iniciar sesión para acceder a este recurso'
      }));
      return;
    }

    if (session.rol !== 'admin') {
      res.writeHead(403, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        error: 'Acceso denegado',
        message: 'No tiene permisos para realizar esta acción'
      }));
      return;
    }

    req.session = session;
    next();
  }

  /**
   * Middleware: Requiere roles específicos
   * @param {Array<string>} allowedRoles - Roles permitidos
   */
  static requireRoles(...allowedRoles) {
    return (req, res, next) => {
      const session = AuthMiddleware.extractSession(req);

      if (!session) {
        res.writeHead(401, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          error: 'No autenticado',
          message: 'Debe iniciar sesión para acceder a este recurso'
        }));
        return;
      }

      if (!allowedRoles.includes(session.rol)) {
        res.writeHead(403, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          error: 'Acceso denegado',
          message: 'No tiene permisos para realizar esta acción'
        }));
        return;
      }

      req.session = session;
      next();
    };
  }
}

module.exports = AuthMiddleware;
