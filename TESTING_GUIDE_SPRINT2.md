# 🧪 GUÍA DE PRUEBAS RÁPIDAS — SPRINT 2 BACKEND

**Proyecto:** AgroTechnova  
**Sprint:** 2 — Gestión de Proyectos  
**Fecha:** Octubre 2024

---

## 🎯 OBJETIVO

Validar que todos los endpoints del Sprint 2 funcionan correctamente mediante pruebas manuales con PowerShell (cURL).

---

## 📋 PRE-REQUISITOS

1. **Iniciar el servidor:**
   ```powershell
   cd C:\Users\sebas\OneDrive\Documentos\AgroSpinoff2
   node server.js
   ```

2. **Verificar salida esperada:**
   ```
   ✅ Paso 10 completado: Tabla 'hitos' creada
   📊 Resumen de Base de Datos:
   ├─ Tablas Sprint 1: roles, usuarios
   ├─ Tablas Sprint 2: categorias_proyecto, proyectos, fases, hitos
   └─ Total: 7 tablas + sqlite_sequence
   ✅ Todas las migraciones completadas exitosamente
   🌱 AgroTechnova API corriendo en http://localhost:3000
   ```

3. **Abrir nueva terminal PowerShell** para ejecutar pruebas

---

## 🔐 PASO 0: AUTENTICACIÓN

### Test 0.1: Login Administrador
```powershell
curl -X POST http://localhost:3000/api/auth/login `
  -H "Content-Type: application/json" `
  -d '{\"email\":\"admin@agrotechnova.com\",\"password\":\"admin123\"}'
```

**Response Esperado (200):**
```json
{
  "success": true,
  "message": "Inicio de sesión exitoso",
  "sessionId": "abc123...",
  "user": {
    "id": 1,
    "nombre": "Administrador",
    "email": "admin@agrotechnova.com",
    "rol": "administrador"
  }
}
```

⚠️ **IMPORTANTE:** Copiar el `sessionId` para usarlo en todas las pruebas siguientes.

**Para pruebas posteriores, usar:**
```powershell
$sessionId = "PEGAR_SESSION_ID_AQUI"
```

---

## 📦 PRUEBAS DE CATEGORÍAS (RF23)

### Test 1: Listar Categorías
```powershell
curl http://localhost:3000/api/projects/categories `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "categories": [
    { "id": 1, "nombre": "Agrícola", "descripcion": "..." },
    { "id": 2, "nombre": "Pecuario", "descripcion": "..." },
    { "id": 3, "nombre": "Agroindustrial", "descripcion": "..." },
    { "id": 4, "nombre": "Mixto", "descripcion": "..." }
  ]
}
```

✅ **Validación:** Debe retornar 4 categorías por defecto.

---

## 🗂️ PRUEBAS DE PROYECTOS (RF41, RF15, RF62)

### Test 2: Crear Proyecto Válido (RF41)
```powershell
curl -X POST http://localhost:3000/api/projects `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{
    \"nombre\": \"Cultivo de Café Orgánico\",
    \"descripcion\": \"Proyecto piloto de producción sostenible\",
    \"fecha_inicio\": \"2024-11-01\",
    \"fecha_fin\": \"2025-10-31\",
    \"categoria_id\": 1
  }'
```

**Response Esperado (201):**
```json
{
  "success": true,
  "message": "Proyecto creado exitosamente",
  "projectId": 1
}
```

✅ **Validación:** 
- HTTP Status 201 Created
- Retorna `projectId`
- Console del servidor muestra: `✅ Proyecto creado: Cultivo de Café Orgánico (ID: 1)`

---

### Test 3: Crear Proyecto con Nombre Duplicado (RF41)
```powershell
# Repetir el comando anterior
curl -X POST http://localhost:3000/api/projects `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{
    \"nombre\": \"Cultivo de Café Orgánico\",
    \"descripcion\": \"Duplicado\",
    \"fecha_inicio\": \"2024-11-01\",
    \"fecha_fin\": \"2025-10-31\",
    \"categoria_id\": 1
  }'
```

**Response Esperado (409 Conflict):**
```json
{
  "error": "Ya existe un proyecto con ese nombre"
}
```

✅ **Validación:** HTTP Status 409, nombre único validado.

---

### Test 4: Crear Proyecto con Fechas Incoherentes (RF41)
```powershell
curl -X POST http://localhost:3000/api/projects `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{
    \"nombre\": \"Proyecto Inválido\",
    \"descripcion\": \"Fechas incorrectas\",
    \"fecha_inicio\": \"2025-12-31\",
    \"fecha_fin\": \"2024-01-01\",
    \"categoria_id\": 1
  }'
```

**Response Esperado (400 Bad Request):**
```json
{
  "error": "La fecha de finalización no puede ser anterior a la de inicio"
}
```

✅ **Validación:** HTTP Status 400, validación de fechas funciona.

---

### Test 5: Listar Todos los Proyectos
```powershell
curl http://localhost:3000/api/projects `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "projects": [
    {
      "id": 1,
      "nombre": "Cultivo de Café Orgánico",
      "descripcion": "...",
      "fecha_inicio": "2024-11-01",
      "fecha_fin": "2025-10-31",
      "estado": "planificacion",
      "categoria": "Agrícola",
      "responsable": "Administrador",
      "responsable_email": "admin@agrotechnova.com"
    }
  ],
  "count": 1
}
```

✅ **Validación:** JOINs funcionan, retorna datos completos.

---

### Test 6: Buscar Proyecto por Nombre (RF62)
```powershell
curl "http://localhost:3000/api/projects/search?nombre=Café" `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "projects": [
    { "id": 1, "nombre": "Cultivo de Café Orgánico", ... }
  ],
  "count": 1,
  "filters": { "nombre": "Café" }
}
```

✅ **Validación:** Búsqueda parcial funciona (RF62).

---

### Test 7: Buscar por Estado (RF62)
```powershell
curl "http://localhost:3000/api/projects/search?estado=planificacion" `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "projects": [ ... ],
  "count": 1,
  "filters": { "estado": "planificacion" }
}
```

✅ **Validación:** Filtro por estado funciona.

---

### Test 8: Actualizar Proyecto en Planificación (RF15)
```powershell
curl -X PUT http://localhost:3000/api/projects/1 `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{
    \"descripcion\": \"Descripción actualizada con éxito\",
    \"estado\": \"ejecucion\"
  }'
```

**Response Esperado (200):**
```json
{
  "success": true,
  "message": "Proyecto actualizado exitosamente"
}
```

✅ **Validación:** Edición permitida en estado `planificacion`.

---

### Test 9: Intentar Actualizar Proyecto Finalizado (RF15)
```powershell
# Primero marcar como finalizado
curl -X PUT http://localhost:3000/api/projects/1 `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{\"estado\": \"finalizado\"}'

# Luego intentar editar
curl -X PUT http://localhost:3000/api/projects/1 `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{\"descripcion\": \"No debería funcionar\"}'
```

**Response Esperado (403 Forbidden):**
```json
{
  "error": "Solo proyectos en planificación o ejecución pueden editarse"
}
```

✅ **Validación:** RF15 cumplido — restricción de edición por estado.

---

## 📅 PRUEBAS DE FASES (RF13)

### Test 10: Crear Fase en Proyecto
```powershell
curl -X POST http://localhost:3000/api/projects/1/phases `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{
    \"nombre\": \"Preparación del Terreno\",
    \"descripcion\": \"Limpieza, nivelación y análisis de suelo\",
    \"fecha_inicio\": \"2024-11-01\",
    \"fecha_fin\": \"2024-11-30\",
    \"porcentaje_avance\": 0
  }'
```

**Response Esperado (201):**
```json
{
  "success": true,
  "message": "Fase creada exitosamente",
  "phaseId": 1
}
```

✅ **Validación:** Fase vinculada a proyecto correctamente.

---

### Test 11: Listar Fases del Proyecto (RF13)
```powershell
curl http://localhost:3000/api/projects/1/phases `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "projectId": "1",
  "projectName": "Cultivo de Café Orgánico",
  "phases": [
    {
      "id": 1,
      "nombre": "Preparación del Terreno",
      "porcentaje_avance": 0,
      ...
    }
  ],
  "count": 1
}
```

✅ **Validación:** Fases listadas con nombre del proyecto.

---

### Test 12: Actualizar Porcentaje de Avance (RF13)
```powershell
curl -X PUT http://localhost:3000/api/phases/1 `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{\"porcentaje_avance\": 50}'
```

**Response Esperado (200):**
```json
{
  "success": true,
  "message": "Fase actualizada exitosamente"
}
```

✅ **Validación:** Porcentaje actualizado.

---

### Test 13: Obtener Progreso del Proyecto (RF13)
```powershell
curl http://localhost:3000/api/projects/1/progress `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "projectId": "1",
  "averageProgress": 50,
  "totalPhases": 1
}
```

✅ **Validación:** Cálculo de progreso promedio funciona.

---

## 📌 PRUEBAS DE HITOS (RF25)

### Test 14: Crear Hito en Fase (RF25)
```powershell
curl -X POST http://localhost:3000/api/phases/1/milestones `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{
    \"nombre\": \"Compra de Insumos\",
    \"descripcion\": \"Adquirir fertilizantes y semillas\",
    \"fecha_limite\": \"2024-11-10\"
  }'
```

**Response Esperado (201):**
```json
{
  "success": true,
  "message": "Hito creado exitosamente",
  "milestoneId": 1
}
```

✅ **Validación:** Hito vinculado a fase, responsable asignado automáticamente.

---

### Test 15: Listar Hitos de Fase
```powershell
curl http://localhost:3000/api/phases/1/milestones `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "phaseId": "1",
  "phaseName": "Preparación del Terreno",
  "milestones": [
    {
      "id": 1,
      "nombre": "Compra de Insumos",
      "estado": "pendiente",
      ...
    }
  ],
  "count": 1
}
```

✅ **Validación:** Hitos listados con nombre de fase.

---

### Test 16: Marcar Hito como Completado (RF25)
```powershell
curl -X PUT http://localhost:3000/api/milestones/1 `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{\"estado\": \"completado\"}'
```

**Response Esperado (200):**
```json
{
  "success": true,
  "message": "Hito actualizado exitosamente"
}
```

**Console del servidor debe mostrar:**
```
✅ Hito 1 marcado como completado (fecha_completado auto-generada)
```

✅ **Validación:** Auto-timestamp de `fecha_completado` funciona.

---

### Test 17: Estadísticas de Hitos del Proyecto (RF25)
```powershell
curl http://localhost:3000/api/projects/1/stats `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (200):**
```json
{
  "success": true,
  "projectId": "1",
  "stats": {
    "total": 1,
    "completados": 1,
    "pendientes": 0,
    "en_progreso": 0,
    "retrasados": 0
  }
}
```

✅ **Validación:** Agregación de estadísticas funciona correctamente.

---

## ⛓️ PRUEBAS DE CASCADA (DELETE CASCADE)

### Test 18: Verificar Cascada al Eliminar Fase
```powershell
# 1. Crear hito adicional
curl -X POST http://localhost:3000/api/phases/1/milestones `
  -H "Content-Type: application/json" `
  -H "Cookie: sessionId=$sessionId" `
  -d '{
    \"nombre\": \"Hito para Cascada\",
    \"fecha_limite\": \"2024-11-15\"
  }'

# 2. Verificar hitos existentes
curl http://localhost:3000/api/phases/1/milestones `
  -H "Cookie: sessionId=$sessionId"

# Debe retornar 2 hitos

# 3. Eliminar la fase
curl -X DELETE http://localhost:3000/api/phases/1 `
  -H "Cookie: sessionId=$sessionId"

# 4. Intentar listar hitos (deben estar eliminados)
curl http://localhost:3000/api/phases/1/milestones `
  -H "Cookie: sessionId=$sessionId"
```

**Response Esperado (404):**
```json
{
  "error": "Fase no encontrada"
}
```

✅ **Validación:** CASCADE DELETE funciona — hitos eliminados automáticamente.

---

## 📊 RESUMEN DE VALIDACIONES

| Test | Endpoint | RF | Resultado Esperado |
|------|----------|----|--------------------|
| 1 | GET /api/projects/categories | RF23 | 4 categorías |
| 2 | POST /api/projects | RF41 | Proyecto creado |
| 3 | POST /api/projects (duplicado) | RF41 | Error 409 |
| 4 | POST /api/projects (fechas inválidas) | RF41 | Error 400 |
| 5 | GET /api/projects | - | Lista con JOINs |
| 6 | GET /api/projects/search?nombre | RF62 | Búsqueda parcial |
| 7 | GET /api/projects/search?estado | RF62 | Filtro por estado |
| 8 | PUT /api/projects/:id (planificación) | RF15 | Actualización exitosa |
| 9 | PUT /api/projects/:id (finalizado) | RF15 | Error 403 |
| 10 | POST /api/projects/:id/phases | RF13 | Fase creada |
| 11 | GET /api/projects/:id/phases | RF13 | Lista de fases |
| 12 | PUT /api/phases/:id | RF13 | Porcentaje actualizado |
| 13 | GET /api/projects/:id/progress | RF13 | Progreso promedio |
| 14 | POST /api/phases/:id/milestones | RF25 | Hito creado |
| 15 | GET /api/phases/:id/milestones | RF25 | Lista de hitos |
| 16 | PUT /api/milestones/:id | RF25 | Auto-timestamp |
| 17 | GET /api/projects/:id/stats | RF25 | Estadísticas |
| 18 | DELETE /api/phases/:id | - | Cascada funciona |

**Total de Pruebas:** 18  
**Cobertura de RF:** RF41, RF13, RF15, RF25, RF62, RF23

---

## ✅ CHECKLIST DE VALIDACIÓN

Marcar al completar cada test:

- [ ] Test 0: Login exitoso y sessionId obtenido
- [ ] Test 1: 4 categorías listadas
- [ ] Test 2: Proyecto creado correctamente
- [ ] Test 3: Nombre duplicado rechazado (409)
- [ ] Test 4: Fechas incoherentes rechazadas (400)
- [ ] Test 5: Lista de proyectos con JOINs
- [ ] Test 6: Búsqueda por nombre funciona
- [ ] Test 7: Búsqueda por estado funciona
- [ ] Test 8: Edición en planificación permitida
- [ ] Test 9: Edición en finalizado bloqueada (403)
- [ ] Test 10: Fase creada en proyecto
- [ ] Test 11: Fases listadas con nombre de proyecto
- [ ] Test 12: Porcentaje de avance actualizado
- [ ] Test 13: Progreso promedio calculado
- [ ] Test 14: Hito creado en fase
- [ ] Test 15: Hitos listados con nombre de fase
- [ ] Test 16: Estado completado con auto-timestamp
- [ ] Test 17: Estadísticas de hitos calculadas
- [ ] Test 18: CASCADE DELETE funciona correctamente

---

## 🎯 RESULTADO ESPERADO

✅ **18/18 pruebas exitosas** = Sprint 2 Backend 100% funcional

---

**FIN DE GUÍA DE PRUEBAS**
