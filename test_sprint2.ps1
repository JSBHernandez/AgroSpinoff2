# ========================================
# SPRINT 2 - FUNCTIONAL REGRESSION TEST
# ========================================

$results = @()
$ErrorActionPreference = 'Continue'

function Add-TestResult {
    param($TestName, $Status, $Details)
    $script:results += [PSCustomObject]@{
        Test = $TestName
        Status = $Status
        Details = $Details
    }
}

Write-Host "🧪 STARTING SPRINT 2 FUNCTIONAL REGRESSION TESTS" -ForegroundColor Cyan
Write-Host "=" * 60

# ========================================
# TEST 1: AUTHENTICATION (Sprint 1)
# ========================================
Write-Host "`n📋 TEST GROUP 1: AUTHENTICATION" -ForegroundColor Yellow

try {
    $body = '{"email":"admin@agrotechnova.com","password":"Admin123!"}'
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/auth/login' -Method POST -Body $body -ContentType 'application/json' -SessionVariable session
    $loginData = $resp.Content | ConvertFrom-Json
    Add-TestResult "1.1 - Admin Login" "PASS" "Status: $($resp.StatusCode), User: $($loginData.user.nombre)"
    Write-Host "  ✅ 1.1 - Admin Login: PASS" -ForegroundColor Green
    $global:testSession = $session
} catch {
    Add-TestResult "1.1 - Admin Login" "FAIL" $_.Exception.Message
    Write-Host "  ❌ 1.1 - Admin Login: FAIL" -ForegroundColor Red
    exit 1
}

try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/auth/session' -Method GET -WebSession $global:testSession
    Add-TestResult "1.2 - Session Verification" "PASS" "Status: $($resp.StatusCode)"
    Write-Host "  ✅ 1.2 - Session Verification: PASS" -ForegroundColor Green
} catch {
    Add-TestResult "1.2 - Session Verification" "FAIL" $_.Exception.Message
    Write-Host "  ❌ 1.2 - Session Verification: FAIL" -ForegroundColor Red
}

# ========================================
# TEST 2: PROJECT CATEGORIES (RF23)
# ========================================
Write-Host "`n📋 TEST GROUP 2: PROJECT CATEGORIES (RF23)" -ForegroundColor Yellow

try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects/categories' -Method GET -WebSession $global:testSession
    $categories = $resp.Content | ConvertFrom-Json
    $categoryNames = $categories | ForEach-Object { $_.nombre }
    
    if ($categories.Count -eq 4 -and $categoryNames -contains "Agrícola" -and $categoryNames -contains "Pecuario") {
        Add-TestResult "2.1 - Get Categories" "PASS" "Found 4 categories: $($categoryNames -join ', ')"
        Write-Host "  ✅ 2.1 - Get Categories: PASS (4 categories)" -ForegroundColor Green
    } else {
        Add-TestResult "2.1 - Get Categories" "FAIL" "Expected 4 categories, got $($categories.Count)"
        Write-Host "  ❌ 2.1 - Get Categories: FAIL" -ForegroundColor Red
    }
} catch {
    Add-TestResult "2.1 - Get Categories" "FAIL" $_.Exception.Message
    Write-Host "  ❌ 2.1 - Get Categories: FAIL" -ForegroundColor Red
}

# ========================================
# TEST 3: PROJECTS CRUD (RF41, RF15)
# ========================================
Write-Host "`n📋 TEST GROUP 3: PROJECTS CRUD (RF41, RF15)" -ForegroundColor Yellow

# Test 3.1: Create Project
try {
    $projectData = @{
        nombre = "Proyecto Test $(Get-Date -Format 'HHmmss')"
        descripcion = "Proyecto de prueba funcional"
        fecha_inicio = "2025-01-15"
        fecha_fin = "2025-12-31"
        categoria_id = 1
        estado = "planificacion"
    } | ConvertTo-Json
    
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects' -Method POST -Body $projectData -ContentType 'application/json' -WebSession $global:testSession
    $newProject = $resp.Content | ConvertFrom-Json
    $global:testProjectId = $newProject.id
    Add-TestResult "3.1 - Create Project (RF41)" "PASS" "Status: $($resp.StatusCode), Project ID: $($newProject.id)"
    Write-Host "  ✅ 3.1 - Create Project (RF41): PASS - ID: $($newProject.id)" -ForegroundColor Green
} catch {
    Add-TestResult "3.1 - Create Project (RF41)" "FAIL" $_.Exception.Message
    Write-Host "  ❌ 3.1 - Create Project (RF41): FAIL" -ForegroundColor Red
}

# Test 3.2: List Projects
try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects' -Method GET -WebSession $global:testSession
    $projects = $resp.Content | ConvertFrom-Json
    Add-TestResult "3.2 - List Projects" "PASS" "Status: $($resp.StatusCode), Count: $($projects.Count)"
    Write-Host "  ✅ 3.2 - List Projects: PASS ($($projects.Count) projects)" -ForegroundColor Green
} catch {
    Add-TestResult "3.2 - List Projects" "FAIL" $_.Exception.Message
    Write-Host "  ❌ 3.2 - List Projects: FAIL" -ForegroundColor Red
}

# Test 3.3: Get Single Project
if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)" -Method GET -WebSession $global:testSession
        $project = $resp.Content | ConvertFrom-Json
        Add-TestResult "3.3 - Get Project by ID" "PASS" "Status: $($resp.StatusCode), Name: $($project.nombre)"
        Write-Host "  ✅ 3.3 - Get Project by ID: PASS" -ForegroundColor Green
    } catch {
        Add-TestResult "3.3 - Get Project by ID" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 3.3 - Get Project by ID: FAIL" -ForegroundColor Red
    }
}

# Test 3.4: Update Project (RF15)
if ($global:testProjectId) {
    try {
        $updateData = @{
            nombre = "Proyecto Test Actualizado"
            descripcion = "Descripción actualizada"
            estado = "ejecucion"
        } | ConvertTo-Json
        
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)" -Method PUT -Body $updateData -ContentType 'application/json' -WebSession $global:testSession
        Add-TestResult "3.4 - Update Project (RF15)" "PASS" "Status: $($resp.StatusCode)"
        Write-Host "  ✅ 3.4 - Update Project (RF15): PASS" -ForegroundColor Green
    } catch {
        Add-TestResult "3.4 - Update Project (RF15)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 3.4 - Update Project (RF15): FAIL" -ForegroundColor Red
    }
}

# Test 3.5: Validate Date Restriction
try {
    $invalidProject = @{
        nombre = "Proyecto Fechas Invalidas $(Get-Date -Format 'HHmmss')"
        descripcion = "Test"
        fecha_inicio = "2025-12-31"
        fecha_fin = "2025-01-01"
        categoria_id = 1
        estado = "planificacion"
    } | ConvertTo-Json
    
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects' -Method POST -Body $invalidProject -ContentType 'application/json' -WebSession $global:testSession
    Add-TestResult "3.5 - Date Validation" "FAIL" "Should reject invalid dates but accepted"
    Write-Host "  ❌ 3.5 - Date Validation: FAIL (should reject)" -ForegroundColor Red
} catch {
    if ($_.Exception.Response.StatusCode -eq 400) {
        Add-TestResult "3.5 - Date Validation" "PASS" "Correctly rejected invalid dates (400)"
        Write-Host "  ✅ 3.5 - Date Validation: PASS" -ForegroundColor Green
    } else {
        Add-TestResult "3.5 - Date Validation" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 3.5 - Date Validation: FAIL" -ForegroundColor Red
    }
}

# ========================================
# TEST 4: PROJECT SEARCH (RF62)
# ========================================
Write-Host "`n📋 TEST GROUP 4: PROJECT SEARCH (RF62)" -ForegroundColor Yellow

# Test 4.1: Search by name
try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects/search?nombre=Test' -Method GET -WebSession $global:testSession
    $results = $resp.Content | ConvertFrom-Json
    Add-TestResult "4.1 - Search by Name (RF62)" "PASS" "Status: $($resp.StatusCode), Results: $($results.Count)"
    Write-Host "  ✅ 4.1 - Search by Name (RF62): PASS ($($results.Count) results)" -ForegroundColor Green
} catch {
    Add-TestResult "4.1 - Search by Name (RF62)" "FAIL" $_.Exception.Message
    Write-Host "  ❌ 4.1 - Search by Name (RF62): FAIL" -ForegroundColor Red
}

# Test 4.2: Search by status
try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects/search?estado=ejecucion' -Method GET -WebSession $global:testSession
    $results = $resp.Content | ConvertFrom-Json
    Add-TestResult "4.2 - Search by Status (RF62)" "PASS" "Status: $($resp.StatusCode), Results: $($results.Count)"
    Write-Host "  ✅ 4.2 - Search by Status (RF62): PASS ($($results.Count) results)" -ForegroundColor Green
} catch {
    Add-TestResult "4.2 - Search by Status (RF62)" "FAIL" $_.Exception.Message
    Write-Host "  ❌ 4.2 - Search by Status (RF62): FAIL" -ForegroundColor Red
}

# ========================================
# TEST 5: PHASES CRUD (RF13)
# ========================================
Write-Host "`n📋 TEST GROUP 5: PHASES CRUD (RF13)" -ForegroundColor Yellow

# Test 5.1: Create Phase
if ($global:testProjectId) {
    try {
        $phaseData = @{
            nombre = "Fase Preparación"
            descripcion = "Preparación del terreno"
            fecha_inicio = "2025-01-15"
            fecha_fin = "2025-03-31"
            porcentaje_avance = 0
        } | ConvertTo-Json
        
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)/phases" -Method POST -Body $phaseData -ContentType 'application/json' -WebSession $global:testSession
        $newPhase = $resp.Content | ConvertFrom-Json
        $global:testPhaseId = $newPhase.id
        Add-TestResult "5.1 - Create Phase (RF13)" "PASS" "Status: $($resp.StatusCode), Phase ID: $($newPhase.id)"
        Write-Host "  ✅ 5.1 - Create Phase (RF13): PASS - ID: $($newPhase.id)" -ForegroundColor Green
    } catch {
        Add-TestResult "5.1 - Create Phase (RF13)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 5.1 - Create Phase (RF13): FAIL" -ForegroundColor Red
    }
}

# Test 5.2: List Phases
if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)/phases" -Method GET -WebSession $global:testSession
        $phases = $resp.Content | ConvertFrom-Json
        Add-TestResult "5.2 - List Phases" "PASS" "Status: $($resp.StatusCode), Count: $($phases.Count)"
        Write-Host "  ✅ 5.2 - List Phases: PASS ($($phases.Count) phases)" -ForegroundColor Green
    } catch {
        Add-TestResult "5.2 - List Phases" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 5.2 - List Phases: FAIL" -ForegroundColor Red
    }
}

# Test 5.3: Update Phase Progress
if ($global:testPhaseId) {
    try {
        $updateData = @{
            porcentaje_avance = 25
        } | ConvertTo-Json
        
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)" -Method PUT -Body $updateData -ContentType 'application/json' -WebSession $global:testSession
        Add-TestResult "5.3 - Update Phase Progress (RF13)" "PASS" "Status: $($resp.StatusCode)"
        Write-Host "  ✅ 5.3 - Update Phase Progress (RF13): PASS" -ForegroundColor Green
    } catch {
        Add-TestResult "5.3 - Update Phase Progress (RF13)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 5.3 - Update Phase Progress (RF13): FAIL" -ForegroundColor Red
    }
}

# Test 5.4: Get Project Progress
if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)/progress" -Method GET -WebSession $global:testSession
        $progress = $resp.Content | ConvertFrom-Json
        Add-TestResult "5.4 - Calculate Project Progress (RF13)" "PASS" "Status: $($resp.StatusCode), Progress: $($progress.porcentaje_promedio)%"
        Write-Host "  ✅ 5.4 - Calculate Project Progress (RF13): PASS ($($progress.porcentaje_promedio)%)" -ForegroundColor Green
    } catch {
        Add-TestResult "5.4 - Calculate Project Progress (RF13)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 5.4 - Calculate Project Progress (RF13): FAIL" -ForegroundColor Red
    }
}

# ========================================
# TEST 6: MILESTONES CRUD (RF25)
# ========================================
Write-Host "`n📋 TEST GROUP 6: MILESTONES CRUD (RF25)" -ForegroundColor Yellow

# Test 6.1: Create Milestone
if ($global:testPhaseId) {
    try {
        $milestoneData = @{
            nombre = "Compra de Insumos"
            descripcion = "Adquisición de semillas y fertilizantes"
            fecha_objetivo = "2025-02-15"
            estado = "pendiente"
        } | ConvertTo-Json
        
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)/milestones" -Method POST -Body $milestoneData -ContentType 'application/json' -WebSession $global:testSession
        $newMilestone = $resp.Content | ConvertFrom-Json
        $global:testMilestoneId = $newMilestone.id
        Add-TestResult "6.1 - Create Milestone (RF25)" "PASS" "Status: $($resp.StatusCode), Milestone ID: $($newMilestone.id)"
        Write-Host "  ✅ 6.1 - Create Milestone (RF25): PASS - ID: $($newMilestone.id)" -ForegroundColor Green
    } catch {
        Add-TestResult "6.1 - Create Milestone (RF25)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 6.1 - Create Milestone (RF25): FAIL" -ForegroundColor Red
    }
}

# Test 6.2: List Milestones
if ($global:testPhaseId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)/milestones" -Method GET -WebSession $global:testSession
        $milestones = $resp.Content | ConvertFrom-Json
        Add-TestResult "6.2 - List Milestones" "PASS" "Status: $($resp.StatusCode), Count: $($milestones.Count)"
        Write-Host "  ✅ 6.2 - List Milestones: PASS ($($milestones.Count) milestones)" -ForegroundColor Green
    } catch {
        Add-TestResult "6.2 - List Milestones" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 6.2 - List Milestones: FAIL" -ForegroundColor Red
    }
}

# Test 6.3: Update Milestone to Completed
if ($global:testMilestoneId) {
    try {
        $updateData = @{
            estado = "completado"
        } | ConvertTo-Json
        
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/milestones/$($global:testMilestoneId)" -Method PUT -Body $updateData -ContentType 'application/json' -WebSession $global:testSession
        $updated = $resp.Content | ConvertFrom-Json
        
        if ($updated.fecha_completado) {
            Add-TestResult "6.3 - Auto-timestamp on Completion (RF25)" "PASS" "Fecha completado: $($updated.fecha_completado)"
            Write-Host "  ✅ 6.3 - Auto-timestamp on Completion (RF25): PASS" -ForegroundColor Green
        } else {
            Add-TestResult "6.3 - Auto-timestamp on Completion (RF25)" "FAIL" "fecha_completado not set"
            Write-Host "  ❌ 6.3 - Auto-timestamp on Completion (RF25): FAIL" -ForegroundColor Red
        }
    } catch {
        Add-TestResult "6.3 - Auto-timestamp on Completion (RF25)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 6.3 - Auto-timestamp on Completion (RF25): FAIL" -ForegroundColor Red
    }
}

# Test 6.4: Get Milestone Statistics
if ($global:testPhaseId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)/milestones/stats" -Method GET -WebSession $global:testSession
        $stats = $resp.Content | ConvertFrom-Json
        Add-TestResult "6.4 - Milestone Statistics (RF25)" "PASS" "Total: $($stats.total), Completados: $($stats.completados)"
        Write-Host "  ✅ 6.4 - Milestone Statistics (RF25): PASS" -ForegroundColor Green
    } catch {
        Add-TestResult "6.4 - Milestone Statistics (RF25)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 6.4 - Milestone Statistics (RF25): FAIL" -ForegroundColor Red
    }
}

# ========================================
# TEST 7: CLEANUP
# ========================================
Write-Host "`n📋 TEST GROUP 7: CLEANUP (CASCADE DELETE)" -ForegroundColor Yellow

# Test 7.1: Delete Phase (should cascade to milestones)
if ($global:testPhaseId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)" -Method DELETE -WebSession $global:testSession
        Add-TestResult "7.1 - Delete Phase (Cascade)" "PASS" "Status: $($resp.StatusCode)"
        Write-Host "  ✅ 7.1 - Delete Phase (Cascade): PASS" -ForegroundColor Green
    } catch {
        Add-TestResult "7.1 - Delete Phase (Cascade)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 7.1 - Delete Phase (Cascade): FAIL" -ForegroundColor Red
    }
}

# Test 7.2: Delete Project (should cascade to phases)
if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)" -Method DELETE -WebSession $global:testSession
        Add-TestResult "7.2 - Delete Project (Cascade)" "PASS" "Status: $($resp.StatusCode)"
        Write-Host "  ✅ 7.2 - Delete Project (Cascade): PASS" -ForegroundColor Green
    } catch {
        Add-TestResult "7.2 - Delete Project (Cascade)" "FAIL" $_.Exception.Message
        Write-Host "  ❌ 7.2 - Delete Project (Cascade): FAIL" -ForegroundColor Red
    }
}

# ========================================
# SUMMARY
# ========================================
Write-Host "`n" + "=" * 60
Write-Host "📊 TEST SUMMARY" -ForegroundColor Cyan
Write-Host "=" * 60

$passCount = ($results | Where-Object { $_.Status -eq "PASS" }).Count
$failCount = ($results | Where-Object { $_.Status -eq "FAIL" }).Count
$totalCount = $results.Count

Write-Host "`nTotal Tests: $totalCount"
Write-Host "Passed: $passCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host "Success Rate: $([math]::Round(($passCount / $totalCount) * 100, 2))%"

Write-Host "`n📝 DETAILED RESULTS:" -ForegroundColor Yellow
$results | Format-Table -AutoSize

# Export to JSON
$results | ConvertTo-Json -Depth 10 | Out-File "test_results.json" -Encoding UTF8
Write-Host "`n✅ Results exported to test_results.json" -ForegroundColor Green

Write-Host "`n🏁 TESTING COMPLETE" -ForegroundColor Cyan
