/**
 * SCRIPT DE MIGRACIÓN E INICIALIZACIÓN - AGROTECHNOVA
 * 
 * Este script:
 * 1. Crea las tablas necesarias (roles, usuarios, categorías, proyectos, fases, hitos)
 * 2. Inserta roles y categorías por defecto
 * 3. Crea usuario administrador por defecto (RF48)
 * 
 * Sprint 1: Autenticación (roles, usuarios)
 * Sprint 2: Gestión de Proyectos (categorías, proyectos, fases, hitos)
 * 
 * Ejecutar: node src/db/migrations.js
 */

const db = require('./database');
const RoleModel = require('../models/roleModel');
const UserModel = require('../models/userModel');
const CategoryModel = require('../models/categoryModel');
const ProjectModel = require('../models/projectModel');
const PhaseModel = require('../models/phaseModel');
const MilestoneModel = require('../models/milestoneModel');

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

    // 6. Crear tabla de categorías de proyecto (Sprint 2 - RF23)
    console.log('📦 Paso 6: Creando tabla de categorías de proyecto...');
    await CategoryModel.createTable();
    console.log('✅ Tabla de categorías creada\n');

    // 7. Insertar categorías por defecto (Sprint 2 - RF23)
    console.log('📦 Paso 7: Insertando categorías por defecto...');
    await CategoryModel.seedDefaultCategories();
    console.log('✅ Categorías por defecto insertadas\n');

    // 8. Crear tabla de proyectos (Sprint 2 - RF41)
    console.log('📦 Paso 8: Creando tabla de proyectos...');
    await ProjectModel.createTable();
    console.log('✅ Tabla de proyectos creada\n');

    // 9. Crear tabla de fases (Sprint 2 - RF13)
    console.log('📦 Paso 9: Creando tabla de fases...');
    await PhaseModel.createTable();
    console.log('✅ Tabla de fases creada\n');

    // 10. Crear tabla de hitos (Sprint 2 - RF25)
    console.log('📦 Paso 10: Creando tabla de hitos...');
    await MilestoneModel.createTable();
    console.log('✅ Tabla de hitos creada\n');

    console.log('='.repeat(50));
    console.log('✨ MIGRACIONES COMPLETADAS EXITOSAMENTE');
    console.log('='.repeat(50));
    console.log('\n📋 CREDENCIALES DE ADMINISTRADOR:');
    console.log('   📧 Email: admin@agrotechnova.com');
    console.log('   🔑 Password: Admin123!');
    console.log('\n⚠️  IMPORTANTE: Cambiar la contraseña después del primer login\n');

    // 11. Mostrar estadísticas
    const usuarios = await UserModel.findAll();
    const roles = await RoleModel.findAll();
    const categorias = await CategoryModel.findAll();
    
    console.log('📊 RESUMEN:');
    console.log(`   - Roles creados: ${roles.length}`);
    console.log(`   - Usuarios creados: ${usuarios.length}`);
    console.log(`   - Categorías de proyecto: ${categorias.length}`);
    console.log('   - Tablas Sprint 1: roles, usuarios');
    console.log('   - Tablas Sprint 2: categorias_proyecto, proyectos, fases, hitos');
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
    // Sprint 1: Autenticación
    await RoleModel.createTable();
    await UserModel.createTable();
    await RoleModel.seedDefaultRoles();
    await UserModel.seedDefaultAdmin();

    // Sprint 2: Gestión de Proyectos
    await CategoryModel.createTable();
    await CategoryModel.seedDefaultCategories();
    await ProjectModel.createTable();
    await PhaseModel.createTable();
    await MilestoneModel.createTable();

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
