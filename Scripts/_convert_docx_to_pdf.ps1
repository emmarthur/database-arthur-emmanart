$ErrorActionPreference = 'Stop'
$inPath = Join-Path $PSScriptRoot 'In-ClassActivity 03-1.docx'
$outPath = Join-Path $PSScriptRoot 'In-ClassActivity 03-1.pdf'

if (-not (Test-Path -LiteralPath $inPath)) {
    Write-Error "Input not found: $inPath"
}

try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $doc = $word.Documents.Open($inPath)
    # 17 = wdExportFormatPDF
    $doc.ExportAsFixedFormat($outPath, 17)
    $doc.Close([ref]$false)
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($doc) | Out-Null
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
    Write-Host "Wrote: $outPath"
    exit 0
}
catch {
    Write-Host "Word COM failed: $($_.Exception.Message)"
    exit 1
}
