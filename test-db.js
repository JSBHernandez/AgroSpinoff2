// test-db.js - Prueba rápida de conexión MySQL usando dotenv y mysql2
require('dotenv').config();
const mysql = require('mysql2/promise');

(async () => {
  try {
    if (!process.env.DATABASE_URL) {
      throw new Error('No se encontró DATABASE_URL en el entorno');
    }

    const dbUrl = new URL(process.env.DATABASE_URL);
    const config = {
      host: dbUrl.hostname,
      port: dbUrl.port ? Number(dbUrl.port) : 3306,
      user: dbUrl.username,
      password: dbUrl.password,
      database: dbUrl.pathname.replace(/^\//, '')
    };

    console.log('Intentando conectar a MySQL con:', {
      host: config.host,
      port: config.port,
      user: config.user,
      database: config.database
    });

    const conn = await mysql.createConnection(config);
    console.log('✅ Conexión OK');
    await conn.end();
    process.exit(0);
  } catch (err) {
    console.error('❌ Fallo al conectar:', err && err.message ? err.message : err);
    process.exit(1);
  }
})();