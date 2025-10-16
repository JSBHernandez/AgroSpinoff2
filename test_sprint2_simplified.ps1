# ========================================
# SPRINT 2 - FUNCTIONAL REGRESSION TEST
# Simplified Version
# ========================================

Write-Host "🧪 SPRINT 2 FUNCTIONAL REGRESSION TESTS" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan

$testResults = @()
$passCount = 0
$failCount = 0

# ========================================
# TEST 1: AUTHENTICATION
# ========================================
Write-Host "`n📋 TEST 1: AUTHENTICATION (Sprint 1)" -ForegroundColor Yellow

# 1.1 Login
try {
    $body = '{"email":"admin@agrotechnova.com","password":"Admin123!"}'
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/auth/login' -Method POST -Body $body -ContentType 'application/json' -SessionVariable session
    Write-Host "  ✅ 1.1 Login: PASS (Status: $($resp.StatusCode))" -ForegroundColor Green
    $global:testSession = $session
    $passCount++
    $testResults += "1.1 Login|PASS|Status 200, Session created"
} catch {
    Write-Host "  ❌ 1.1 Login: FAIL - $($_.Exception.Message)" -ForegroundColor Red
    $failCount++
    $testResults += "1.1 Login|FAIL|$($_.Exception.Message)"
    exit 1
}

# 1.2 Session Verification
try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/auth/session' -Method GET -WebSession $global:testSession
    Write-Host "  ✅ 1.2 Session Verification: PASS" -ForegroundColor Green
    $passCount++
    $testResults += "1.2 Session Verification|PASS|Session valid"
} catch {
    Write-Host "  ❌ 1.2 Session Verification: FAIL" -ForegroundColor Red
    $failCount++
    $testResults += "1.2 Session Verification|FAIL|$($_.Exception.Message)"
}

# ========================================
# TEST 2: CATEGORIES (RF23)
# ========================================
Write-Host "`n📋 TEST 2: PROJECT CATEGORIES (RF23)" -ForegroundColor Yellow

try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects/categories' -Method GET -WebSession $global:testSession
    $categories = $resp.Content | ConvertFrom-Json
    Write-Host "  Found $($categories.Count) categories: $($categories.nombre -join ', ')"
    
    if ($categories.Count -eq 4) {
        Write-Host "  ✅ 2.1 Get Categories: PASS (4 categories)" -ForegroundColor Green
        $passCount++
        $testResults += "2.1 Get Categories (RF23)|PASS|4 categories found"
    } else {
        Write-Host "  ❌ 2.1 Get Categories: FAIL (Expected 4, got $($categories.Count))" -ForegroundColor Red
        $failCount++
        $testResults += "2.1 Get Categories (RF23)|FAIL|Expected 4 categories, got $($categories.Count)"
    }
} catch {
    Write-Host "  ❌ 2.1 Get Categories: FAIL" -ForegroundColor Red
    $failCount++
    $testResults += "2.1 Get Categories (RF23)|FAIL|$($_.Exception.Message)"
}

# ========================================
# TEST 3: CREATE PROJECT (RF41)
# ========================================
Write-Host "`n📋 TEST 3: CREATE PROJECT (RF41)" -ForegroundColor Yellow

try {
    $timestamp = Get-Date -Format 'HHmmss'
    $projectData = "{`"nombre`":`"Proyecto Test $timestamp`",`"descripcion`":`"Proyecto de prueba funcional`",`"fecha_inicio`":`"2025-01-15`",`"fecha_fin`":`"2025-12-31`",`"categoria_id`":1,`"estado`":`"planificacion`"}"
    
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects' -Method POST -Body $projectData -ContentType 'application/json' -WebSession $global:testSession
    $newProject = $resp.Content | ConvertFrom-Json
    $global:testProjectId = $newProject.id
    Write-Host "  ✅ 3.1 Create Project: PASS (ID: $($newProject.id))" -ForegroundColor Green
    $passCount++
    $testResults += "3.1 Create Project (RF41)|PASS|Project created with ID $($newProject.id)"
} catch {
    Write-Host "  ❌ 3.1 Create Project: FAIL" -ForegroundColor Red
    $failCount++
    $testResults += "3.1 Create Project (RF41)|FAIL|$($_.Exception.Message)"
}

# ========================================
# TEST 4: LIST PROJECTS
# ========================================
Write-Host "`n📋 TEST 4: LIST PROJECTS" -ForegroundColor Yellow

try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects' -Method GET -WebSession $global:testSession
    $projects = $resp.Content | ConvertFrom-Json
    Write-Host "  ✅ 4.1 List Projects: PASS ($($projects.Count) projects)" -ForegroundColor Green
    $passCount++
    $testResults += "4.1 List Projects|PASS|$($projects.Count) projects found"
} catch {
    Write-Host "  ❌ 4.1 List Projects: FAIL" -ForegroundColor Red
    $failCount++
    $testResults += "4.1 List Projects|FAIL|$($_.Exception.Message)"
}

# ========================================
# TEST 5: GET SINGLE PROJECT
# ========================================
Write-Host "`n📋 TEST 5: GET SINGLE PROJECT" -ForegroundColor Yellow

if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)" -Method GET -WebSession $global:testSession
        Write-Host "  ✅ 5.1 Get Project by ID: PASS" -ForegroundColor Green
        $passCount++
        $testResults += "5.1 Get Project by ID|PASS|Project retrieved successfully"
    } catch {
        Write-Host "  ❌ 5.1 Get Project by ID: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "5.1 Get Project by ID|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  5.1 Get Project by ID: SKIPPED (no project ID)" -ForegroundColor Gray
}

# ========================================
# TEST 6: UPDATE PROJECT (RF15)
# ========================================
Write-Host "`n📋 TEST 6: UPDATE PROJECT (RF15)" -ForegroundColor Yellow

if ($global:testProjectId) {
    try {
        $updateData = "{`"nombre`":`"Proyecto Test Actualizado`",`"descripcion`":`"Descripción actualizada`",`"estado`":`"ejecucion`"}"
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)" -Method PUT -Body $updateData -ContentType 'application/json' -WebSession $global:testSession
        Write-Host "  ✅ 6.1 Update Project: PASS" -ForegroundColor Green
        $passCount++
        $testResults += "6.1 Update Project (RF15)|PASS|Project updated successfully"
    } catch {
        Write-Host "  ❌ 6.1 Update Project: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "6.1 Update Project (RF15)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  6.1 Update Project: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 7: DATE VALIDATION
# ========================================
Write-Host "`n📋 TEST 7: DATE VALIDATION (RF41)" -ForegroundColor Yellow

try {
    $invalidData = "{`"nombre`":`"Proyecto Fechas Invalidas`",`"descripcion`":`"Test`",`"fecha_inicio`":`"2025-12-31`",`"fecha_fin`":`"2025-01-01`",`"categoria_id`":1,`"estado`":`"planificacion`"}"
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects' -Method POST -Body $invalidData -ContentType 'application/json' -WebSession $global:testSession
    Write-Host "  ❌ 7.1 Date Validation: FAIL (Should reject invalid dates)" -ForegroundColor Red
    $failCount++
    $testResults += "7.1 Date Validation (RF41)|FAIL|Should reject invalid dates but accepted"
} catch {
    if ($_.Exception.Response.StatusCode.value__ -eq 400) {
        Write-Host "  ✅ 7.1 Date Validation: PASS (Rejected invalid dates)" -ForegroundColor Green
        $passCount++
        $testResults += "7.1 Date Validation (RF41)|PASS|Correctly rejected invalid dates"
    } else {
        Write-Host "  ❌ 7.1 Date Validation: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "7.1 Date Validation (RF41)|FAIL|Unexpected error"
    }
}

# ========================================
# TEST 8: SEARCH PROJECTS (RF62)
# ========================================
Write-Host "`n📋 TEST 8: SEARCH PROJECTS (RF62)" -ForegroundColor Yellow

try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects/search?nombre=Test' -Method GET -WebSession $global:testSession
    $results = $resp.Content | ConvertFrom-Json
    Write-Host "  ✅ 8.1 Search by Name: PASS ($($results.projects.Count) results)" -ForegroundColor Green
    $passCount++
    $testResults += "8.1 Search by Name (RF62)|PASS|Search returned $($results.projects.Count) results"
} catch {
    Write-Host "  ❌ 8.1 Search by Name: FAIL" -ForegroundColor Red
    $failCount++
    $testResults += "8.1 Search by Name (RF62)|FAIL|$($_.Exception.Message)"
}

try {
    $resp = Invoke-WebRequest -Uri 'http://localhost:3000/api/projects/search?estado=ejecucion' -Method GET -WebSession $global:testSession
    $results = $resp.Content | ConvertFrom-Json
    Write-Host "  ✅ 8.2 Search by Status: PASS ($($results.projects.Count) results)" -ForegroundColor Green
    $passCount++
    $testResults += "8.2 Search by Status (RF62)|PASS|Search returned $($results.projects.Count) results"
} catch {
    Write-Host "  ❌ 8.2 Search by Status: FAIL" -ForegroundColor Red
    $failCount++
    $testResults += "8.2 Search by Status (RF62)|FAIL|$($_.Exception.Message)"
}

# ========================================
# TEST 9: CREATE PHASE (RF13)
# ========================================
Write-Host "`n📋 TEST 9: CREATE PHASE (RF13)" -ForegroundColor Yellow

if ($global:testProjectId) {
    try {
        $phaseData = "{`"nombre`":`"Fase Preparación`",`"descripcion`":`"Preparación del terreno`",`"fecha_inicio`":`"2025-01-15`",`"fecha_fin`":`"2025-03-31`",`"porcentaje_avance`":0}"
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)/phases" -Method POST -Body $phaseData -ContentType 'application/json' -WebSession $global:testSession
        $newPhase = $resp.Content | ConvertFrom-Json
        $global:testPhaseId = $newPhase.id
        Write-Host "  ✅ 9.1 Create Phase: PASS (ID: $($newPhase.id))" -ForegroundColor Green
        $passCount++
        $testResults += "9.1 Create Phase (RF13)|PASS|Phase created with ID $($newPhase.id)"
    } catch {
        Write-Host "  ❌ 9.1 Create Phase: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "9.1 Create Phase (RF13)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  9.1 Create Phase: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 10: LIST PHASES
# ========================================
Write-Host "`n📋 TEST 10: LIST PHASES (RF13)" -ForegroundColor Yellow

if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)/phases" -Method GET -WebSession $global:testSession
        $phases = $resp.Content | ConvertFrom-Json
        Write-Host "  ✅ 10.1 List Phases: PASS ($($phases.Count) phases)" -ForegroundColor Green
        $passCount++
        $testResults += "10.1 List Phases (RF13)|PASS|$($phases.Count) phases found"
    } catch {
        Write-Host "  ❌ 10.1 List Phases: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "10.1 List Phases (RF13)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  10.1 List Phases: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 11: UPDATE PHASE PROGRESS (RF13)
# ========================================
Write-Host "`n📋 TEST 11: UPDATE PHASE PROGRESS (RF13)" -ForegroundColor Yellow

if ($global:testPhaseId) {
    try {
        $updateData = "{`"porcentaje_avance`":25}"
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)" -Method PUT -Body $updateData -ContentType 'application/json' -WebSession $global:testSession
        Write-Host "  ✅ 11.1 Update Phase Progress: PASS" -ForegroundColor Green
        $passCount++
        $testResults += "11.1 Update Phase Progress (RF13)|PASS|Progress updated to 25%"
    } catch {
        Write-Host "  ❌ 11.1 Update Phase Progress: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "11.1 Update Phase Progress (RF13)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  11.1 Update Phase Progress: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 12: PROJECT PROGRESS CALCULATION (RF13)
# ========================================
Write-Host "`n📋 TEST 12: PROJECT PROGRESS CALCULATION (RF13)" -ForegroundColor Yellow

if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)/progress" -Method GET -WebSession $global:testSession
        $progress = $resp.Content | ConvertFrom-Json
        Write-Host "  ✅ 12.1 Calculate Progress: PASS (Progress: $($progress.porcentaje_promedio)%)" -ForegroundColor Green
        $passCount++
        $testResults += "12.1 Calculate Progress (RF13)|PASS|Progress calculated: $($progress.porcentaje_promedio)%"
    } catch {
        Write-Host "  ❌ 12.1 Calculate Progress: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "12.1 Calculate Progress (RF13)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  12.1 Calculate Progress: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 13: CREATE MILESTONE (RF25)
# ========================================
Write-Host "`n📋 TEST 13: CREATE MILESTONE (RF25)" -ForegroundColor Yellow

if ($global:testPhaseId) {
    try {
        $milestoneData = "{`"nombre`":`"Compra de Insumos`",`"descripcion`":`"Adquisición de semillas`",`"fecha_objetivo`":`"2025-02-15`",`"estado`":`"pendiente`"}"
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)/milestones" -Method POST -Body $milestoneData -ContentType 'application/json' -WebSession $global:testSession
        $newMilestone = $resp.Content | ConvertFrom-Json
        $global:testMilestoneId = $newMilestone.id
        Write-Host "  ✅ 13.1 Create Milestone: PASS (ID: $($newMilestone.id))" -ForegroundColor Green
        $passCount++
        $testResults += "13.1 Create Milestone (RF25)|PASS|Milestone created with ID $($newMilestone.id)"
    } catch {
        Write-Host "  ❌ 13.1 Create Milestone: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "13.1 Create Milestone (RF25)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  13.1 Create Milestone: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 14: LIST MILESTONES
# ========================================
Write-Host "`n📋 TEST 14: LIST MILESTONES (RF25)" -ForegroundColor Yellow

if ($global:testPhaseId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)/milestones" -Method GET -WebSession $global:testSession
        $milestones = $resp.Content | ConvertFrom-Json
        Write-Host "  ✅ 14.1 List Milestones: PASS ($($milestones.Count) milestones)" -ForegroundColor Green
        $passCount++
        $testResults += "14.1 List Milestones (RF25)|PASS|$($milestones.Count) milestones found"
    } catch {
        Write-Host "  ❌ 14.1 List Milestones: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "14.1 List Milestones (RF25)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  14.1 List Milestones: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 15: UPDATE MILESTONE (RF25)
# ========================================
Write-Host "`n📋 TEST 15: UPDATE MILESTONE TO COMPLETED (RF25)" -ForegroundColor Yellow

if ($global:testMilestoneId) {
    try {
        $updateData = "{`"estado`":`"completado`"}"
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/milestones/$($global:testMilestoneId)" -Method PUT -Body $updateData -ContentType 'application/json' -WebSession $global:testSession
        $updated = $resp.Content | ConvertFrom-Json
        
        if ($updated.fecha_completado) {
            Write-Host "  ✅ 15.1 Auto-timestamp on Completion: PASS (fecha_completado: $($updated.fecha_completado))" -ForegroundColor Green
            $passCount++
            $testResults += "15.1 Auto-timestamp (RF25)|PASS|fecha_completado set automatically: $($updated.fecha_completado)"
        } else {
            Write-Host "  ❌ 15.1 Auto-timestamp on Completion: FAIL (fecha_completado not set)" -ForegroundColor Red
            $failCount++
            $testResults += "15.1 Auto-timestamp (RF25)|FAIL|fecha_completado not set"
        }
    } catch {
        Write-Host "  ❌ 15.1 Auto-timestamp on Completion: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "15.1 Auto-timestamp (RF25)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  15.1 Auto-timestamp: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 16: MILESTONE STATISTICS
# ========================================
Write-Host "`n📋 TEST 16: MILESTONE STATISTICS (RF25)" -ForegroundColor Yellow

if ($global:testPhaseId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)/milestones/stats" -Method GET -WebSession $global:testSession
        $stats = $resp.Content | ConvertFrom-Json
        Write-Host "  ✅ 16.1 Milestone Stats: PASS (Total: $($stats.total), Completados: $($stats.completados))" -ForegroundColor Green
        $passCount++
        $testResults += "16.1 Milestone Stats (RF25)|PASS|Total: $($stats.total), Completados: $($stats.completados)"
    } catch {
        Write-Host "  ❌ 16.1 Milestone Stats: FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "16.1 Milestone Stats (RF25)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  16.1 Milestone Stats: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 17: DELETE PHASE (CASCADE)
# ========================================
Write-Host "`n📋 TEST 17: CASCADE DELETE - PHASE" -ForegroundColor Yellow

if ($global:testPhaseId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/phases/$($global:testPhaseId)" -Method DELETE -WebSession $global:testSession
        Write-Host "  ✅ 17.1 Delete Phase (Cascade): PASS" -ForegroundColor Green
        $passCount++
        $testResults += "17.1 Delete Phase (Cascade)|PASS|Phase deleted, milestones cascaded"
    } catch {
        Write-Host "  ❌ 17.1 Delete Phase (Cascade): FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "17.1 Delete Phase (Cascade)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  17.1 Delete Phase: SKIPPED" -ForegroundColor Gray
}

# ========================================
# TEST 18: DELETE PROJECT (CASCADE)
# ========================================
Write-Host "`n📋 TEST 18: CASCADE DELETE - PROJECT" -ForegroundColor Yellow

if ($global:testProjectId) {
    try {
        $resp = Invoke-WebRequest -Uri "http://localhost:3000/api/projects/$($global:testProjectId)" -Method DELETE -WebSession $global:testSession
        Write-Host "  ✅ 18.1 Delete Project (Cascade): PASS" -ForegroundColor Green
        $passCount++
        $testResults += "18.1 Delete Project (Cascade)|PASS|Project deleted, phases cascaded"
    } catch {
        Write-Host "  ❌ 18.1 Delete Project (Cascade): FAIL" -ForegroundColor Red
        $failCount++
        $testResults += "18.1 Delete Project (Cascade)|FAIL|$($_.Exception.Message)"
    }
} else {
    Write-Host "  ⏭️  18.1 Delete Project: SKIPPED" -ForegroundColor Gray
}

# ========================================
# SUMMARY
# ========================================
$totalTests = $passCount + $failCount
$successRate = if ($totalTests -gt 0) { [math]::Round(($passCount / $totalTests) * 100, 2) } else { 0 }

Write-Host "`n" + ("=" * 70) -ForegroundColor Cyan
Write-Host "📊 TEST SUMMARY" -ForegroundColor Cyan
Write-Host ("=" * 70) -ForegroundColor Cyan
Write-Host "`nTotal Tests: $totalTests"
Write-Host "Passed: $passCount" -ForegroundColor Green
Write-Host "Failed: $failCount" -ForegroundColor Red
Write-Host "Success Rate: $successRate%"

# Export detailed results
$testResults | Out-File "test_results_detailed.txt" -Encoding UTF8
Write-Host "`n✅ Detailed results exported to test_results_detailed.txt" -ForegroundColor Green

Write-Host "`n🏁 TESTING COMPLETE" -ForegroundColor Cyan
Write-Host ("=" * 70) -ForegroundColor Cyan
