
# =======================================
# PARAMETRI
# =======================================

$RepoRoot 					= 'C:\Repositories\RRL'
$AppRoot 					= Join-Path $RepoRoot 'src\RugbyRadio'
$BlogSourcePath 			= Join-Path $RepoRoot 'src\RugbyRadioBlog'
$SeoSourcePath 				= Join-Path $RepoRoot 'src\RugbyRadioSitemap'
$SqlComposeFile 			= Join-Path $AppRoot 'compose.sqlserver.yml'
$SftpComposeFile 			= Join-Path $AppRoot 'compose.sftp.yml'
$ReverseProxyComposeFile 	= Join-Path $AppRoot 'compose.reverse-proxy.yml'
$ApiComposeFile 			= Join-Path $AppRoot 'compose.api.yml'
$HangfireComposeFile 		= Join-Path $AppRoot 'compose.hangfire.yml'
$StorageComposeFile 		= Join-Path $AppRoot 'compose.storage.yml'
$BlogComposeFile 			= Join-Path $AppRoot 'compose.blog.yml'
$SeoComposeFile 			= Join-Path $AppRoot 'compose.seo.yml'
$SqlEnvFile 				= Join-Path $AppRoot '.env.sqlserver'
$SftpEnvFile 				= Join-Path $AppRoot '.env.sftp'
$ReverseProxyEnvFile 		= Join-Path $AppRoot '.env.reverse-proxy'
$ApiEnvFile 				= Join-Path $AppRoot '.env.api'
$HangfireEnvFile 			= Join-Path $AppRoot '.env.hangfire'
$StorageEnvFile 			= Join-Path $AppRoot '.env.storage'
$BlogEnvFile 				= Join-Path $AppRoot '.env.blog'
$SeoEnvFile 				= Join-Path $AppRoot '.env.seo'
$SqlEnvTemplate 			= Join-Path $AppRoot '.env.sqlserver.example'
$SftpEnvTemplate 			= Join-Path $AppRoot '.env.sftp.example'
$ReverseProxyEnvTemplate 	= Join-Path $AppRoot '.env.reverse-proxy.example'
$ApiEnvTemplate 			= Join-Path $AppRoot '.env.api.example'
$HangfireEnvTemplate 		= Join-Path $AppRoot '.env.hangfire.example'
$StorageEnvTemplate 		= Join-Path $AppRoot '.env.storage.example'
$BlogEnvTemplate 			= Join-Path $AppRoot '.env.blog.example'
$SeoEnvTemplate 			= Join-Path $AppRoot '.env.seo.example'
$FirebaseKeyPath 			= Join-Path $AppRoot 'Api\FirebaseKey.json'

$BackupFile 				= 'C:\Repositories\RRL\backup\RugbyRadioLive.bak'
$HangfireBackupFile 		= 'C:\Repositories\RRL\backup\RugbyRadioLive-HF.bak'
$StorageBackupPath 			= 'C:\Repositories\RRL\backup\RugbyRadioStorage'
	
$ContainerName 				= 'sqlserver-express'
$SharedNetworkName 			= 'shared-net'
	
$DatabaseName 				= 'RugbyRadioLive'
$HangfireDatabaseName 		= 'RugbyRadioLive-HF'
$SqlCmdPath 				= '/opt/mssql-tools18/bin/sqlcmd'
$SqlSaPassword 				= 'gfR-45r-ad!-Ew1'
$SqlHostPort 				= '14333'
	
$SftpHostPort 				= '2222'
$SftpUser 					= 'storage'
$SftpPassword 				= 'RrlStorageSftpLocal2026'
$ReverseProxyHostPort 		= '8080'
$ReverseProxyApiUpstream 	= 'rrl-api-s1'

$ApiS1HostPort 				= '5101'
$ApiS2HostPort 				= '5102'
$ApiSecuritySecretKey 		= 'htR-ut2-a3a-R19-mkl-eTw-qW4-jeE-7tR'
$ApiValidIssuer 			= 'https://localhost'
$ApiValidAudience 			= 'https://localhost'
$ApiExpirationMinutes 		= '525600'

$HangfireHostPort 			= '5200'

$StorageHostPort 			= '5300'
$StorageContainerName 		= 'rrl-storage'
	
$BlogHostPort 				= '5400'
$BlogContainerName 			= 'rrl-blog'
	
$SeoHostPort 				= '5500'
$SeoContainerName 			= 'rrl-seo'
	
$ApiS1PublicUrl 			= 'http://localhost:5101'
$ApiS2PublicUrl 			= 'http://localhost:5102'
$HangfirePublicUrl 			= 'http://localhost:5200'
$StoragePublicUrl 			= 'http://localhost:5300'
$BlogPublicUrl 				= 'http://localhost:5400'
$SeoPublicUrl 				= 'http://localhost:5500'
$ReverseProxyPublicUrl 		= 'http://localhost:8080'
	
$ErrorActionPreference 		= 'Stop'

# =======================================
# =======================================

function Assert-PathExists([string]$Path, [string]$Description) {
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Non trovato ${Description}: $Path"
    }
}

function Remove-ContainerIfExists([string]$Name) {
    $existingName = & docker container ls --all --format '{{.Names}}' |
        Where-Object { $_ -eq $Name } |
        Select-Object -First 1

    if ($existingName) {
        & docker container rm --force $Name
        if ($LASTEXITCODE -ne 0) {
            throw "Impossibile rimuovere il container $Name."
        }
    }
}

function Read-DotEnvValue([string]$Path, [string]$Name) {
    $line = Get-Content -LiteralPath $Path |
        Where-Object { $_ -match "^\s*$([regex]::Escape($Name))\s*=" } |
        Select-Object -First 1

    if (-not $line) {
        throw "Variabile $Name non trovata in $Path"
    }

    $value = ($line -split '=', 2)[1].Trim()
    if ($value.Length -ge 2 -and $value.StartsWith('"') -and $value.EndsWith('"')) {
        $value = $value.Substring(1, $value.Length - 2)
    }
    if ($value.Length -ge 2 -and $value.StartsWith("'") -and $value.EndsWith("'")) {
        $value = $value.Substring(1, $value.Length - 2)
    }
    if ([string]::IsNullOrWhiteSpace($value) -or $value -like 'CHANGE_ME*') {
        throw "Variabile $Name non valorizzata correttamente in $Path"
    }
    return $value
}

function Set-DotEnvValue([string]$Content, [string]$Name, [string]$Value) {
    if ($Value.Contains("`r") -or $Value.Contains("`n")) {
        throw "Il valore di $Name contiene un ritorno a capo non valido per un file env."
    }

    $pattern = "(?m)^(?<prefix>\s*$([regex]::Escape($Name))\s*=).*$"
    $matches = [regex]::Matches($Content, $pattern)
    if ($matches.Count -eq 0) {
        throw "Variabile $Name non trovata nel template env."
    }

    $result = [regex]::Replace($Content, $pattern, {
        param($match)
        $match.Groups['prefix'].Value + $Value
    })

    return $result
}

function Write-LocalEnvFiles {
    Assert-PathExists $SqlEnvTemplate 'il template env SQL Server'
    Assert-PathExists $SftpEnvTemplate 'il template env SFTP'
    Assert-PathExists $ReverseProxyEnvTemplate 'il template env reverse proxy'
    Assert-PathExists $ApiEnvTemplate 'il template env API'
    Assert-PathExists $HangfireEnvTemplate 'il template env Hangfire'
    Assert-PathExists $StorageEnvTemplate 'il template env Storage'
    Assert-PathExists $StorageBackupPath 'la cartella di backup dello Storage'
    Assert-PathExists $BlogEnvTemplate 'il template env Blog'
    Assert-PathExists $BlogSourcePath 'la sorgente del Blog'
    Assert-PathExists $SeoEnvTemplate 'il template env SEO'
    Assert-PathExists $SeoSourcePath 'la sorgente SEO'

    if ($SqlSaPassword -like 'CHANGE_ME*' -or $ApiSecuritySecretKey -like 'CHANGE_ME*') {
        throw 'Impostare $SqlSaPassword e $ApiSecuritySecretKey nella sezione PARAMETRI prima di eseguire lo script.'
    }
    if ($ApiSecuritySecretKey.Length -lt 32) {
        throw '$ApiSecuritySecretKey deve contenere almeno 32 caratteri.'
    }
    Assert-PathExists $FirebaseKeyPath 'la Firebase key'

    $sqlContent = Get-Content -LiteralPath $SqlEnvTemplate -Raw
    $sqlContent = Set-DotEnvValue $sqlContent 'SHARED_SQLSERVER_SA_PASSWORD' $SqlSaPassword
    $sqlContent = Set-DotEnvValue $sqlContent 'SHARED_SQLSERVER_HOST_PORT' $SqlHostPort
    Set-Content -LiteralPath $SqlEnvFile -Value $sqlContent -Encoding utf8

    $sftpContent = Get-Content -LiteralPath $SftpEnvTemplate -Raw
    $sftpContent = Set-DotEnvValue $sftpContent 'SHARED_SFTP_HOST_PORT' $SftpHostPort
    $sftpContent = Set-DotEnvValue $sftpContent 'SHARED_SFTP_USER' $SftpUser
    $sftpContent = Set-DotEnvValue $sftpContent 'SHARED_SFTP_PASSWORD' $SftpPassword
    Set-Content -LiteralPath $SftpEnvFile -Value $sftpContent -Encoding utf8

    $reverseProxyContent = Get-Content -LiteralPath $ReverseProxyEnvTemplate -Raw
    $reverseProxyContent = Set-DotEnvValue $reverseProxyContent 'SHARED_REVERSE_PROXY_HOST_PORT' $ReverseProxyHostPort
    $reverseProxyContent = Set-DotEnvValue $reverseProxyContent 'SHARED_REVERSE_PROXY_API_UPSTREAM' $ReverseProxyApiUpstream
    Set-Content -LiteralPath $ReverseProxyEnvFile -Value $reverseProxyContent -Encoding utf8

    $connectionString = "Server=sql-server-express,1433;Database=$DatabaseName;User ID=sa;Password=$SqlSaPassword;TrustServerCertificate=True;Encrypt=False;"
    $apiContent = Get-Content -LiteralPath $ApiEnvTemplate -Raw
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_CONNECTION_STRING' $connectionString
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_FIREBASE_KEY_PATH' $FirebaseKeyPath
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_SECURITY_SECRET_KEY' $ApiSecuritySecretKey
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_SECURITY_VALID_ISSUER' $ApiValidIssuer
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_SECURITY_VALID_AUDIENCE' $ApiValidAudience
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_SECURITY_EXPIRATION_MINUTES' $ApiExpirationMinutes
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_S1_PUBLIC_URL' $ApiS1PublicUrl
    $apiContent = Set-DotEnvValue $apiContent 'RRL_API_S2_PUBLIC_URL' $ApiS2PublicUrl
    Set-Content -LiteralPath $ApiEnvFile -Value $apiContent -Encoding utf8

    $hangfireAppConnection = "Server=sql-server-express,1433;Database=$DatabaseName;User ID=sa;Password=$SqlSaPassword;TrustServerCertificate=True;Encrypt=False;"
    $hangfireConnection = "Server=sql-server-express,1433;Database=$HangfireDatabaseName;User ID=sa;Password=$SqlSaPassword;TrustServerCertificate=True;Encrypt=False;"
    $hangfireContent = Get-Content -LiteralPath $HangfireEnvTemplate -Raw
    $hangfireContent = Set-DotEnvValue $hangfireContent 'RRL_HF_HOST_PORT' $HangfireHostPort
    $hangfireContent = Set-DotEnvValue $hangfireContent 'RRL_HF_APP_CONNECTION_STRING' $hangfireAppConnection
    $hangfireContent = Set-DotEnvValue $hangfireContent 'RRL_HF_HANGFIRE_CONNECTION_STRING' $hangfireConnection
    $hangfireContent = Set-DotEnvValue $hangfireContent 'RRL_HF_SECURITY_SECRET_KEY' $ApiSecuritySecretKey
    $hangfireContent = Set-DotEnvValue $hangfireContent 'RRL_HF_STORAGE_PUBLIC_URL' $StoragePublicUrl
    $hangfireContent = Set-DotEnvValue $hangfireContent 'RRL_HF_BLOG_DOMAIN' $BlogPublicUrl
    Set-Content -LiteralPath $HangfireEnvFile -Value $hangfireContent -Encoding utf8

    $storageContent = Get-Content -LiteralPath $StorageEnvTemplate -Raw
    $storageContent = Set-DotEnvValue $storageContent 'RRL_STORAGE_HOST_PORT' $StorageHostPort
    Set-Content -LiteralPath $StorageEnvFile -Value $storageContent -Encoding utf8

    $blogContent = Get-Content -LiteralPath $BlogEnvTemplate -Raw
    $blogContent = Set-DotEnvValue $blogContent 'RRL_BLOG_HOST_PORT' $BlogHostPort
    Set-Content -LiteralPath $BlogEnvFile -Value $blogContent -Encoding utf8

    $seoContent = Get-Content -LiteralPath $SeoEnvTemplate -Raw
    $seoContent = Set-DotEnvValue $seoContent 'RRL_SEO_HOST_PORT' $SeoHostPort
    Set-Content -LiteralPath $SeoEnvFile -Value $seoContent -Encoding utf8
}

function Invoke-SqlCmd([string]$Query) {
    & docker exec -e "SQLCMDPASSWORD=$script:SaPassword" $script:ContainerName `
        $script:SqlCmdPath -S localhost -U sa -C -b -Q $Query
    if ($LASTEXITCODE -ne 0) {
        throw "sqlcmd ha restituito il codice $LASTEXITCODE"
    }
}

function Restore-DatabaseBackup([string]$SourceBackupFile, [string]$TargetDatabaseName) {
    Assert-PathExists $SourceBackupFile 'il backup SQL Server'
    $containerBackup = "/var/opt/mssql/backup/$TargetDatabaseName.bak"
    Write-Host "Copio il backup nel container: $SourceBackupFile" -ForegroundColor Cyan
    & docker cp $SourceBackupFile "${ContainerName}:$containerBackup"
    if ($LASTEXITCODE -ne 0) { throw 'Impossibile copiare il backup nel container.' }

    Invoke-SqlCmd "RESTORE VERIFYONLY FROM DISK = N'$containerBackup';"

    $restoreScript = Join-Path $AppRoot 'sqlserver\restore-database.sql'
    Assert-PathExists $restoreScript 'lo script di restore'
    $dataFile = "/var/opt/mssql/data/$TargetDatabaseName.mdf"
    $logFile = "/var/opt/mssql/data/${TargetDatabaseName}_log.ldf"
    $resolvedRestoreScript = Join-Path ([System.IO.Path]::GetTempPath()) ("rrl-restore-{0}.sql" -f [guid]::NewGuid())
    $restoreContent = Get-Content -LiteralPath $restoreScript -Raw
    $restoreContent = $restoreContent -replace '(?m)^:setvar DatabaseName ".*"$', ":setvar DatabaseName `"$TargetDatabaseName`""
    $restoreContent = $restoreContent -replace '(?m)^:setvar BackupFile ".*"$', ":setvar BackupFile `"$containerBackup`""
    $restoreContent = $restoreContent -replace '(?m)^:setvar DataFile ".*"$', ":setvar DataFile `"$dataFile`""
    $restoreContent = $restoreContent -replace '(?m)^:setvar LogFile ".*"$', ":setvar LogFile `"$logFile`""
    Set-Content -LiteralPath $resolvedRestoreScript -Value $restoreContent -Encoding utf8

    & docker cp $resolvedRestoreScript "${ContainerName}:/tmp/restore-database.sql"
    if ($LASTEXITCODE -ne 0) { throw 'Impossibile copiare lo script di restore nel container.' }

    try {
        & docker exec -e "SQLCMDPASSWORD=$script:SaPassword" $ContainerName `
            $SqlCmdPath -S localhost -U sa -C -b -i /tmp/restore-database.sql
        if ($LASTEXITCODE -ne 0) { throw "Restore database $TargetDatabaseName fallito." }
    } finally {
        & docker exec -u 0 $ContainerName rm -f $containerBackup /tmp/restore-database.sql
        Remove-Item -LiteralPath $resolvedRestoreScript -Force -ErrorAction SilentlyContinue
    }
}

function Initialize-BlogContent {
    $stagingPath = Join-Path ([System.IO.Path]::GetTempPath()) ("rrl-blog-seed-{0}" -f [guid]::NewGuid())
    $storageSourceUrl = 'https://storage-sh.rugbyradiolive.com'
    $textExtensions = @('.html', '.xml', '.css', '.js', '.json', '.txt', '.svg')

    try {
        Copy-Item -LiteralPath $BlogSourcePath -Destination $stagingPath -Recurse

        Get-ChildItem -LiteralPath $stagingPath -Recurse -File |
            Where-Object { $textExtensions -contains $_.Extension.ToLowerInvariant() } |
            ForEach-Object {
                $content = Get-Content -LiteralPath $_.FullName -Raw -Encoding utf8
                $content = $content.Replace($storageSourceUrl, $StoragePublicUrl.TrimEnd('/'))
                Set-Content -LiteralPath $_.FullName -Value $content -Encoding utf8 -NoNewline
            }

        & docker cp "$stagingPath\." "${BlogContainerName}:/usr/share/nginx/html/"
        if ($LASTEXITCODE -ne 0) { throw 'Impossibile copiare la sorgente del Blog nel container.' }
    }
    finally {
        Remove-Item -LiteralPath $stagingPath -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Ensure-DockerNetwork {
    $network = & docker network ls --filter "name=^${SharedNetworkName}$" --format '{{.Name}}' 2>$null
    if ($network -notcontains $SharedNetworkName) {
        Write-Host "Creo la rete Docker esterna $SharedNetworkName..." -ForegroundColor Cyan
        & docker network create $SharedNetworkName
        if ($LASTEXITCODE -ne 0) { throw "Impossibile creare la rete Docker $SharedNetworkName." }
    }
}

function Initialize-GhcrImages {
    $ghcrComposeFile = Join-Path $AppRoot 'compose.ghcr.yml'
    Assert-PathExists $ghcrComposeFile 'il compose GHCR'

    Write-Host 'Login al GitHub Container Registry...' -ForegroundColor Cyan
    $ghcrUser = Read-Host 'Username GitHub'
    $ghcrToken = Read-Host 'Token GitHub con permesso read:packages' -AsSecureString
    $ghcrTokenPlain = [System.Net.NetworkCredential]::new('', $ghcrToken).Password

    try {
        $ghcrTokenPlain | docker login ghcr.io -u $ghcrUser --password-stdin
        if ($LASTEXITCODE -ne 0) { throw 'Login a GHCR fallito.' }
    }
    finally {
        $ghcrTokenPlain = $null
    }

    $env:GHCR_OWNER = 'stebonf'
    $env:RRL_IMAGE_TAG = 'feat-vps'

    Write-Host 'Scarico le immagini GHCR...' -ForegroundColor Cyan
    & docker compose `
        --env-file $ApiEnvFile `
        --env-file $HangfireEnvFile `
        -f $ApiComposeFile `
        -f $HangfireComposeFile `
        -f $ghcrComposeFile pull
    if ($LASTEXITCODE -ne 0) { throw 'Pull delle immagini GHCR fallito.' }
}

Assert-PathExists $AppRoot 'la cartella applicativa'
Assert-PathExists $SqlComposeFile 'il compose SQL Server'
Assert-PathExists $SftpComposeFile 'il compose SFTP'
Assert-PathExists $ReverseProxyComposeFile 'il compose reverse proxy'
Assert-PathExists $ApiComposeFile 'il compose API'
Assert-PathExists $HangfireComposeFile 'il compose Hangfire'
Assert-PathExists $StorageComposeFile 'il compose Storage'
Assert-PathExists $BlogComposeFile 'il compose Blog'
Assert-PathExists $SeoComposeFile 'il compose SEO'
Write-Host 'Genero i file env locali dai template...' -ForegroundColor Cyan
Write-LocalEnvFiles
Ensure-DockerNetwork

$script:SaPassword = Read-DotEnvValue $SqlEnvFile 'SHARED_SQLSERVER_SA_PASSWORD'
Initialize-GhcrImages

Write-Host 'Reset completo dello stack locale richiesto.' -ForegroundColor Yellow
@($ContainerName, 'sftp', 'reverse-proxy', 'rrl-api-s1', 'rrl-api-s2', 'rrl-hangfire', 'rrl-storage', 'rrl-blog', 'rrl-seo') |
    ForEach-Object { Remove-ContainerIfExists $_ }
& docker compose --env-file $ApiEnvFile -f $ApiComposeFile down
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere lo stack API.' }
& docker compose --env-file $HangfireEnvFile -f $HangfireComposeFile down
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere lo stack Hangfire.' }
& docker compose --env-file $BlogEnvFile -f $BlogComposeFile down -v
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere lo stack Blog.' }
& docker compose --env-file $SeoEnvFile -f $SeoComposeFile down -v
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere lo stack SEO.' }
& docker compose --env-file $SftpEnvFile -f $SftpComposeFile down
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere lo stack SFTP.' }
& docker compose --env-file $ReverseProxyEnvFile -f $ReverseProxyComposeFile down
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere il reverse proxy.' }
& docker compose --env-file $StorageEnvFile -f $StorageComposeFile down -v
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere lo stack Storage.' }
& docker compose --env-file $SqlEnvFile -f $SqlComposeFile down -v
if ($LASTEXITCODE -ne 0) { throw 'Impossibile rimuovere lo stack SQL Server.' }

Write-Host 'Avvio SQL Server Express...' -ForegroundColor Cyan
& docker compose --env-file $SqlEnvFile -f $SqlComposeFile up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare SQL Server Express.' }

Write-Host 'Attendo che SQL Server accetti connessioni...' -ForegroundColor Cyan
$connected = $false
for ($attempt = 1; $attempt -le 30; $attempt++) {
    & docker exec -e "SQLCMDPASSWORD=$script:SaPassword" $ContainerName `
        $SqlCmdPath -S localhost -U sa -C -b -Q 'SELECT 1' *> $null
    if ($LASTEXITCODE -eq 0) {
        $connected = $true
        break
    }
    Start-Sleep -Seconds 2
}
if (-not $connected) {
    throw "SQL Server non accetta la password generata da $SqlEnvFile."
}

& docker exec $ContainerName mkdir -p /var/opt/mssql/backup
if ($LASTEXITCODE -ne 0) { throw 'Impossibile creare la cartella backup nel container.' }

Restore-DatabaseBackup $BackupFile $DatabaseName
Restore-DatabaseBackup $HangfireBackupFile $HangfireDatabaseName

Write-Host 'Avvio Storage/CDN e inizializzazione contenuti...' -ForegroundColor Cyan
& docker compose --env-file $StorageEnvFile -f $StorageComposeFile up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare lo Storage.' }
& docker cp "$StorageBackupPath\." "${StorageContainerName}:/usr/share/nginx/html/"
if ($LASTEXITCODE -ne 0) { throw 'Impossibile copiare il backup nello Storage.' }

Write-Host 'Avvio SFTP condiviso...' -ForegroundColor Cyan
& docker compose --env-file $SftpEnvFile -f $SftpComposeFile up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare SFTP.' }

Write-Host 'Avvio Blog statico e inizializzazione contenuti...' -ForegroundColor Cyan
& docker compose --env-file $BlogEnvFile -f $BlogComposeFile up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare il Blog.' }
Initialize-BlogContent

Write-Host 'Avvio SEO statico e inizializzazione contenuti...' -ForegroundColor Cyan
& docker compose --env-file $SeoEnvFile -f $SeoComposeFile up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare il servizio SEO.' }
& docker cp "$SeoSourcePath\." "${SeoContainerName}:/usr/share/nginx/html/"
if ($LASTEXITCODE -ne 0) { throw 'Impossibile copiare la sorgente SEO nel container.' }

Assert-PathExists $ApiEnvFile 'il file env API'
Write-Host 'Avvio API S1 e S2...' -ForegroundColor Cyan
& docker compose --env-file $ApiEnvFile -f $ApiComposeFile -f (Join-Path $AppRoot 'compose.ghcr.yml') up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare le API.' }

Write-Host 'Avvio Hangfire RRL...' -ForegroundColor Cyan
& docker compose --env-file $HangfireEnvFile -f $HangfireComposeFile -f (Join-Path $AppRoot 'compose.ghcr.yml') up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare Hangfire.' }

Write-Host 'Avvio reverse proxy condiviso...' -ForegroundColor Cyan
& docker compose --env-file $ReverseProxyEnvFile -f $ReverseProxyComposeFile up -d
if ($LASTEXITCODE -ne 0) { throw 'Impossibile avviare il reverse proxy.' }

Write-Host ''
Write-Host 'Ambiente locale RRL pronto.' -ForegroundColor Green
Write-Host 'SQL Server: 127.0.0.1:14333'
Write-Host "API S1: http://localhost:$ApiS1HostPort"
Write-Host "API S2: http://localhost:$ApiS2HostPort"
Write-Host "Hangfire: http://localhost:$HangfireHostPort"
Write-Host "Storage/CDN: http://localhost:$StorageHostPort"
Write-Host "SFTP: 127.0.0.1:$SftpHostPort (utente $SftpUser)"
Write-Host "Blog: http://localhost:$BlogHostPort"
Write-Host "SEO: http://localhost:$SeoHostPort"
Write-Host "Reverse proxy: http://localhost:$ReverseProxyHostPort"
