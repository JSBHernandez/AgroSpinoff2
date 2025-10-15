/**
 * SCRIPT DE MIGRACIÓN E INICIALIZACIÓN - AGROTECHNOVA
 * 
 * Este script:
 * 1. Crea las tablas necesarias (roles, usuarios)
 * 2. Inserta roles por defecto
 * 3. Crea usuario administrador por defecto (RF48)
 * 
 * Ejecutar: node src/db/migrations.js
 */

const db = require('./database');
const RoleModel = require('../models/roleModel');
const UserModel = require('../models/userModel');

async function runMigrations() {
  console.log('🚀 Iniciando migraciones de base de datos...\n');

  try {
    // 1. Inicializar conexión a la base de datos
    console.log('📦 Paso 1: Inicializando base de datos...');
    await db.initialize();
    console.log('✅ Base de datos inicializada\n');

    // 2. Crear tabla de roles
    console.log('📦 Paso 2: Creando tabla de roles...');
    await RoleModel.createTable();
    console.log('✅ Tabla de roles creada\n');

    // 3. Crear tabla de usuarios
    console.log('📦 Paso 3: Creando tabla de usuarios...');
    await UserModel.createTable();
    console.log('✅ Tabla de usuarios creada\n');

    // 4. Insertar roles por defecto
    console.log('📦 Paso 4: Insertando roles por defecto...');
    await RoleModel.seedDefaultRoles();
    console.log('✅ Roles por defecto insertados\n');

    // 5. Crear usuario administrador por defecto (RF48)
    console.log('📦 Paso 5: Creando usuario administrador...');
    await UserModel.seedDefaultAdmin();
    console.log('✅ Usuario administrador creado\n');

    console.log('='.repeat(50));
    console.log('✨ MIGRACIONES COMPLETADAS EXITOSAMENTE');
    console.log('='.repeat(50));
    console.log('\n📋 CREDENCIALES DE ADMINISTRADOR:');
    console.log('   📧 Email: admin@agrotechnova.com');
    console.log('   🔑 Password: Admin123!');
    console.log('\n⚠️  IMPORTANTE: Cambiar la contraseña después del primer login\n');

    // 6. Mostrar estadísticas
    const usuarios = await UserModel.findAll();
    const roles = await RoleModel.findAll();
    
    console.log('📊 RESUMEN:');
    console.log(`   - Roles creados: ${roles.length}`);
    console.log(`   - Usuarios creados: ${usuarios.length}`);
    console.log('');

  } catch (error) {
    console.error('\n❌ ERROR EN MIGRACIONES:');
    console.error(error);
    process.exit(1);
  }
}

/**
 * Inicialización de base de datos (sin inicializar conexión)
 * Para usar cuando la conexión ya está activa
 */
async function initDatabase() {
  try {
    // Crear tabla de roles
    await RoleModel.createTable();
    
    // Crear tabla de usuarios
    await UserModel.createTable();
    
    // Insertar roles por defecto
    await RoleModel.seedDefaultRoles();
    
    // Crear usuario administrador por defecto
    await UserModel.seedDefaultAdmin();

  } catch (error) {
    // Si las tablas ya existen, no es error fatal
    if (error.message && error.message.includes('already exists')) {
      console.log('ℹ️  Tablas ya existentes, continuando...');
    } else {
      throw error;
    }
  }
}

// Ejecutar migraciones
if (require.main === module) {
  runMigrations()
    .then(() => {
      console.log('👋 Migraciones finalizadas. Cerrando conexión...');
      process.exit(0);
    })
    .catch((error) => {
      console.error('❌ Error fatal:', error);
      process.exit(1);
    });
}

module.exports = { runMigrations, initDatabase };
