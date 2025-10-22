# Script mejorado para agregar JavaScript de dropdowns
# AgroTechnova - Sprint 4

$scriptDropdown = @'

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
    "proyectos.html",
    "usuarios.html", 
    "agendaReuniones.html",
    "proveedores.html",
    "productos.html",
    "inventario.html",
    "recursos.html",
    "presupuestos.html",
    "gastos.html",
    "fases.html",
    "hitos.html"
)

Write-Host "=== AGREGANDO JAVASCRIPT DE DROPDOWNS (v2) ===" -ForegroundColor Cyan
Write-Host ""

foreach ($archivo in $archivos) {
    $rutaArchivo = "pages\$archivo"
    
    if (Test-Path $rutaArchivo) {
        Write-Host "Procesando: $archivo" -ForegroundColor Yellow
        
        # Leer contenido
        $contenido = Get-Content $rutaArchivo -Raw -Encoding UTF8
        
        # Verificar si ya tiene el script de dropdowns
        if ($contenido -match "Funcionalidad de dropdowns") {
            Write-Host "  ✓ Ya tiene el script de dropdowns - OMITIDO" -ForegroundColor Green
        }
        else {
            # Buscar </script></html> o </script></body> o similar
            if ($contenido -match "(.*)(  </script>)(</html>|</body>|$)") {
                $antesScript = $matches[1]
                $tagScript = $matches[2]
                $despuesScript = $matches[3]
                
                # Insertar el nuevo script antes del cierre de script
                $nuevoContenido = $antesScript + $scriptDropdown + "`n" + $tagScript + $despuesScript
                
                # Guardar archivo
                [System.IO.File]::WriteAllText($rutaArchivo, $nuevoContenido, [System.Text.UTF8Encoding]::new($false))
                
                Write-Host "  ✓ Script agregado exitosamente" -ForegroundColor Green
            }
            else {
                Write-Host "  ✗ No se pudo encontrar patrón de cierre - REVISAR MANUALMENTE" -ForegroundColor Red
            }
        }
    }
    else {
        Write-Host "  ✗ Archivo no encontrado: $rutaArchivo" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "=== PROCESO COMPLETADO ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "NOTA: Refresca las páginas con Ctrl+F5 para ver los cambios" -ForegroundColor Yellow
