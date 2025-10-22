# Script SEGURO para agregar dropdowns a archivos HTML restaurados
# Solo agrega si NO tiene dropdowns ya

$dropdownsNav = @'

                
                <!-- Dropdown: Gestión Financiera -->
                <div class="nav-dropdown">
                  <button class="nav-dropdown-btn">
                    Gestión Financiera
                    <i class="fas fa-chevron-down"></i>
                  </button>
                  <div class="nav-dropdown-content">
                    <a href="recursos.html">Recursos</a>
                    <a href="presupuestos.html">Presupuestos</a>
                    <a href="gastos.html">Gastos</a>
                  </div>
                </div>
                
                <!-- Dropdown: Inventario y Proveedores -->
                <div class="nav-dropdown">
                  <button class="nav-dropdown-btn">
                    Inventario y Proveedores
                    <i class="fas fa-chevron-down"></i>
                  </button>
                  <div class="nav-dropdown-content">
                    <a href="proveedores.html">Proveedores</a>
                    <a href="productos.html">Productos</a>
                    <a href="inventario.html">Inventario</a>
                  </div>
                </div>
'@

$scriptDropdowns = @'


        // Funcionalidad de dropdowns
        document.addEventListener('DOMContentLoaded', function() {
          const dropdownButtons = document.querySelectorAll('.nav-dropdown-btn');
          
          dropdownButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
              e.preventDefault();
              const dropdown = this.parentElement;
              const isOpen = dropdown.classList.contains('open');
              
              // Cerrar todos los dropdowns
              document.querySelectorAll('.nav-dropdown').forEach(dd => {
                dd.classList.remove('open');
              });
              
              // Abrir/cerrar el dropdown actual
              if (!isOpen) {
                dropdown.classList.add('open');
              }
            });
          });
          
          // Cerrar dropdowns al hacer clic fuera
          document.addEventListener('click', function(e) {
            if (!e.target.closest('.nav-dropdown')) {
              document.querySelectorAll('.nav-dropdown').forEach(dd => {
                dd.classList.remove('open');
              });
            }
          });
        });
'@

$archivos = @(
    "agendaReuniones.html",
    "recursos.html",
    "presupuestos.html",
    "gastos.html",
    "fases.html",
    "hitos.html"
)

Write-Host "=== AGREGAR DROPDOWNS SEGURO ===" -ForegroundColor Cyan
Write-Host ""

foreach ($archivo in $archivos) {
    $rutaArchivo = "pages\$archivo"
    
    if (!(Test-Path $rutaArchivo)) {
        Write-Host "$archivo - NO EXISTE" -ForegroundColor Red
        continue
    }
    
    Write-Host "Procesando: $archivo" -ForegroundColor Yellow
    
    $contenido = Get-Content $rutaArchivo -Raw -Encoding UTF8
    
    # Verificar si ya tiene dropdowns
    if ($contenido -match 'nav-dropdown') {
        Write-Host "  ✓ Ya tiene dropdowns" -ForegroundColor Green
        continue
    }
    
    # 1. Agregar Font Awesome si no lo tiene
    if ($contenido -notmatch 'font-awesome') {
        $contenido = $contenido -replace '(<title>.*?</title>)', "`$1`n  <link rel=`"stylesheet`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`">"
        Write-Host "  + Font Awesome agregado" -ForegroundColor Cyan
    }
    
    # 2. Agregar dropdowns al nav (buscar </nav> y agregar antes)
    if ($contenido -match '(.*?<nav>.*?agendaReuniones\.html[^>]*>.*?</a>)([\r\n\s]*</nav>)') {
        $contenido = $contenido -replace '(<nav>.*?agendaReuniones\.html[^>]*>.*?</a>)([\r\n\s]*</nav>)', "`$1$dropdownsNav`$2"
        Write-Host "  + Dropdowns en nav agregados" -ForegroundColor Cyan
    } else {
        Write-Host "  ✗ No se pudo agregar nav - estructura no encontrada" -ForegroundColor Red
        continue
    }
    
    # 3. Agregar script de dropdowns antes del cierre de </script>
    if ($contenido -match '(.*)([\r\n\s]+)(</script>[\r\n\s]*</body>[\r\n\s]*</html>)') {
        $contenido = $contenido -replace '([\r\n\s]+)(</script>[\r\n\s]*</body>[\r\n\s]*</html>)', "$scriptDropdowns`$1`$2"
        Write-Host "  + Script de dropdowns agregado" -ForegroundColor Cyan
    } else {
        Write-Host "  ✗ No se pudo agregar script - estructura no encontrada" -ForegroundColor Red
        continue
    }
    
    # Guardar archivo
    [System.IO.File]::WriteAllText($rutaArchivo, $contenido, [System.Text.UTF8Encoding]::new($false))
    Write-Host "  ✅ COMPLETADO" -ForegroundColor Green
    Write-Host ""
}

Write-Host "=== PROCESO FINALIZADO ===" -ForegroundColor Cyan
