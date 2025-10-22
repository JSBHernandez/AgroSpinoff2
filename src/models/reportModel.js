const db = require('../db/database');

const ReportModel = {
  /**
   * Obtener reporte financiero completo por proyecto
   */
  getFinancialReport: (proyectoId, callback) => {
    const query = `
      SELECT 
        p.id as proyecto_id,
        p.nombre as proyecto_nombre,
        p.estado,
        p.fecha_inicio,
        p.fecha_fin,
        
        -- Presupuesto
        pr.monto_total as presupuesto_total,
        pr.monto_gastado as presupuesto_gastado,
        (pr.monto_total - pr.monto_gastado) as presupuesto_disponible,
        ROUND((pr.monto_gastado * 100.0 / pr.monto_total), 2) as porcentaje_ejecucion,
        
        -- Recursos
        (SELECT COUNT(*) FROM recursos WHERE proyecto_id = p.id) as total_recursos,
        (SELECT SUM(costo_unitario * cantidad) FROM recursos WHERE proyecto_id = p.id) as costo_total_recursos,
        
        -- Gastos
        (SELECT COUNT(*) FROM gastos WHERE proyecto_id = p.id) as total_gastos,
        (SELECT SUM(monto) FROM gastos WHERE proyecto_id = p.id) as total_monto_gastos,
        
        -- Inventario asociado
        (SELECT COUNT(DISTINCT producto_id) 
         FROM movimientos_inventario 
         WHERE proyecto_id = p.id AND tipo = 'salida') as productos_utilizados
        
      FROM proyectos p
      LEFT JOIN presupuestos pr ON pr.proyecto_id = p.id
      WHERE p.id = ?
    `;

    db.get(query, [proyectoId], callback);
  },

  /**
   * Obtener detalle de gastos por categoría
   */
  getExpensesByCategory: (proyectoId, callback) => {
    const query = `
      SELECT 
        categoria,
        COUNT(*) as cantidad,
        SUM(monto) as total,
        ROUND(AVG(monto), 2) as promedio
      FROM gastos
      WHERE proyecto_id = ?
      GROUP BY categoria
      ORDER BY total DESC
    `;

    db.all(query, [proyectoId], callback);
  },

  /**
   * Obtener detalle de recursos por tipo
   */
  getResourcesByType: (proyectoId, callback) => {
    const query = `
      SELECT 
        tipo,
        COUNT(*) as cantidad,
        SUM(costo_unitario * cantidad) as costo_total,
        SUM(cantidad) as cantidad_total
      FROM recursos
      WHERE proyecto_id = ?
      GROUP BY tipo
      ORDER BY costo_total DESC
    `;

    db.all(query, [proyectoId], callback);
  },

  /**
   * Obtener movimientos de inventario del proyecto
   */
  getInventoryMovements: (proyectoId, callback) => {
    const query = `
      SELECT 
        mi.id,
        mi.tipo,
        mi.cantidad,
        mi.costo_unitario,
        mi.costo_total,
        mi.fecha,
        p.nombre as producto_nombre,
        p.tipo as producto_tipo
      FROM movimientos_inventario mi
      INNER JOIN productos p ON p.id = mi.producto_id
      WHERE mi.proyecto_id = ?
      ORDER BY mi.fecha DESC
    `;

    db.all(query, [proyectoId], callback);
  },

  /**
   * Obtener resumen de todos los proyectos finalizados
   */
  getFinishedProjects: (callback) => {
    const query = `
      SELECT 
        p.id,
        p.nombre,
        p.descripcion,
        p.categoria,
        p.ubicacion,
        p.fecha_inicio,
        p.fecha_fin,
        p.estado,
        pr.monto_total as presupuesto,
        pr.monto_gastado as gastado,
        (SELECT COUNT(*) FROM recursos WHERE proyecto_id = p.id) as recursos_asignados,
        (SELECT COUNT(*) FROM gastos WHERE proyecto_id = p.id) as gastos_registrados,
        u.nombre as responsable
      FROM proyectos p
      LEFT JOIN presupuestos pr ON pr.proyecto_id = p.id
      LEFT JOIN usuarios u ON u.id = p.responsable_id
      WHERE p.estado = 'finalizado'
      ORDER BY p.fecha_fin DESC
    `;

    db.all(query, [], callback);
  },

  /**
   * Obtener reporte consolidado de todos los proyectos
   */
  getConsolidatedReport: (callback) => {
    const query = `
      SELECT 
        COUNT(*) as total_proyectos,
        SUM(CASE WHEN estado = 'finalizado' THEN 1 ELSE 0 END) as proyectos_finalizados,
        SUM(CASE WHEN estado = 'ejecucion' THEN 1 ELSE 0 END) as proyectos_en_ejecucion,
        (SELECT SUM(monto_total) FROM presupuestos) as presupuesto_total_sistema,
        (SELECT SUM(monto_gastado) FROM presupuestos) as total_gastado_sistema,
        (SELECT COUNT(*) FROM recursos) as total_recursos,
        (SELECT COUNT(*) FROM gastos) as total_gastos,
        (SELECT COUNT(*) FROM productos) as total_productos
      FROM proyectos
    `;

    db.get(query, [], callback);
  }
};

module.exports = ReportModel;
