# Script para limpiar código mal insertado y corregirlo
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

Write-Host "=== LIMPIANDO Y CORRIGIENDO DROPDOWNS ===" -ForegroundColor Cyan
Write-Host ""

foreach ($archivo in $archivos) {
    $rutaArchivo = "pages\$archivo"
    
    if (Test-Path $rutaArchivo) {
        Write-Host "Procesando: $archivo" -ForegroundColor Yellow
        
        # Leer contenido
        $contenido = Get-Content $rutaArchivo -Raw -Encoding UTF8
        
        # Verificar si tiene el texto mal insertado (sin etiquetas script)
        if ($contenido -match "(?s)^[\r\n\s]*// Funcionalidad de dropdowns") {
            Write-Host "  ⚠ Detectado código mal insertado al inicio - LIMPIANDO" -ForegroundColor Red
            
            # Eliminar el código mal insertado del inicio
            $contenido = $contenido -replace "(?s)^[\r\n\s]*// Funcionalidad de dropdowns.*?\}\);[\r\n\s]*", ""
            
            Write-Host "  ✓ Código mal insertado eliminado" -ForegroundColor Green
        }
        
        # Ahora buscar el lugar correcto para insertar (antes del cierre de </script> final)
        if ($contenido -notmatch "// Funcionalidad de dropdowns") {
            # Buscar el último </script> antes de </body> o </html>
            if ($contenido -match "(.*)([\r\n\s]+</script>)([\r\n\s]*</(?:body|html)>.*?)$") {
                $antesScript = $matches[1]
                $tagScript = $matches[2]
                $despuesScript = $matches[3]
                
                # Insertar el script en el lugar correcto
                $contenido = $antesScript + $scriptDropdown + $tagScript + $despuesScript
                
                Write-Host "  ✓ Script insertado correctamente" -ForegroundColor Green
            }
            else {
                Write-Host "  ✗ No se pudo encontrar ubicación correcta" -ForegroundColor Red
            }
        }
        else {
            Write-Host "  ✓ Script ya está correctamente insertado" -ForegroundColor Green
        }
        
        # Guardar archivo
        [System.IO.File]::WriteAllText($rutaArchivo, $contenido, [System.Text.UTF8Encoding]::new($false))
    }
    else {
        Write-Host "  ✗ Archivo no encontrado: $rutaArchivo" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "=== PROCESO COMPLETADO ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "NOTA: Refresca las páginas con Ctrl+F5 para ver los cambios" -ForegroundColor Yellow
