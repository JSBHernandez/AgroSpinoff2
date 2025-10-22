# Script para limpiar caracteres `n literales en todos los archivos HTML

$archivos = @(
    "usuarios.html",
    "productos.html",
    "inventario.html",
    "presupuestos.html",
    "hitos.html",
    "gastos.html",
    "fases.html",
    "recursos.html",
    "proveedores.html",
    "agendaReuniones.html"
)

foreach ($archivo in $archivos) {
    $rutaCompleta = "pages\$archivo"
    
    if (Test-Path $rutaCompleta) {
        Write-Host "Limpiando: $archivo" -ForegroundColor Cyan
        
        # Leer contenido
        $contenido = Get-Content $rutaCompleta -Raw
        
        # Reemplazar `n literal con saltos de línea reales
        $contenido = $contenido -replace '`n', "`n"
        
        # Guardar cambios
        Set-Content $rutaCompleta -Value $contenido -Encoding UTF8 -NoNewline
        
        Write-Host "✓ Limpiado: $archivo" -ForegroundColor Green
    }
}

Write-Host "`n✅ Caracteres `n corregidos en todos los archivos" -ForegroundColor Green
