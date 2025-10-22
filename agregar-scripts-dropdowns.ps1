# Script para agregar funcionalidad de dropdowns inline en cada página

$archivos = @(
    "proyectos.html",
    "usuarios.html",
    "agendaReuniones.html",
    "productos.html",
    "inventario.html",
    "proveedores.html",
    "recursos.html",
    "presupuestos.html",
    "gastos.html",
    "fases.html",
    "hitos.html"
)

$scriptDropdowns = @'

<script>
// Funcionalidad de dropdowns
document.addEventListener('DOMContentLoaded', function() {
  const dropdownButtons = document.querySelectorAll('.nav-dropdown-btn');
  
  dropdownButtons.forEach(btn => {
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
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
  document.addEventListener('click', function() {
    document.querySelectorAll('.nav-dropdown').forEach(dd => {
      dd.classList.remove('open');
    });
  });
});
</script>
'@

foreach ($archivo in $archivos) {
    $rutaCompleta = "pages\$archivo"
    
    if (Test-Path $rutaCompleta) {
        Write-Host "Procesando: $archivo" -ForegroundColor Cyan
        
        # Leer contenido
        $contenido = Get-Content $rutaCompleta -Raw
        
        # Verificar si ya tiene el script de dropdowns
        if ($contenido -notmatch 'Funcionalidad de dropdowns') {
            # Agregar script antes del último </script> o antes de </body>
            if ($contenido -match '</script>[\s\S]*</body>') {
                # Hay scripts, agregarlo antes del último
                $contenido = $contenido -replace '(</script>\s*</body>)', "$scriptDropdowns`n$1"
            } else {
                # No hay scripts, agregarlo antes de </body>
                $contenido = $contenido -replace '(</body>)', "$scriptDropdowns`n$1"
            }
            
            # Guardar cambios
            Set-Content $rutaCompleta -Value $contenido -Encoding UTF8
            
            Write-Host "✓ Script agregado: $archivo" -ForegroundColor Green
        } else {
            Write-Host "○ Ya tiene script: $archivo" -ForegroundColor Yellow
        }
    }
}

Write-Host "`n✅ Scripts de dropdowns agregados" -ForegroundColor Green
