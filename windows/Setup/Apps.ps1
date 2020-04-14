##########################################################################
# Disable UAC (temporarily)
##########################################################################

Disable-UAC

##########################################################################
# Utility methods
##########################################################################

Function Test-Rust() {
    return Test-Path -Path (Join-Path $env:USERPROFILE ".cargo");
}

##########################################################################
# Create temporary directory
##########################################################################

# Workaround choco / boxstarter path too long error
# https://github.com/chocolatey/boxstarter/issues/241
$ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey"
New-Item -Path $ChocoCachePath -ItemType Directory -Force

##########################################################################
# Install applications
##########################################################################

#--- Tools ---
choco upgrade --cache="$ChocoCachePath" --yes sysinternals
choco upgrade --cache="$ChocoCachePath" --yes git -params "/GitAndUnixToolsOnPath /WindowsTerminal"
choco upgrade --cache="$ChocoCachePath" --yes git-credential-manager-for-windows
choco upgrade --cache="$ChocoCachePath" --yes poshgit
choco upgrade --cache="$ChocoCachePath" --yes golang
choco upgrade --cache="$ChocoCachePath" --yes autohotkey 
choco upgrade --cache="$ChocoCachePath" --yes vagrant 
choco upgrade --cache="$ChocoCachePath" --yes jq 
choco upgrade --cache="$ChocoCachePath" --yes curl 
choco upgrade --cache="$ChocoCachePath" --yes openssl.light
choco upgrade --cache="$ChocoCachePath" --yes hxd 
choco upgrade --cache="$ChocoCachePath" --yes bind-toolsonly 
choco upgrade --cache="$ChocoCachePath" --yes sharex
choco upgrade --cache="$ChocoCachePath" --yes powershell-core
choco upgrade --cache="$ChocoCachePath" --yes microsoft-windows-terminal
choco upgrade --cache="$ChocoCachePath" --yes starship
choco upgrade --cache="$ChocoCachePath" --yes kdiff3

#--- Apps ---
choco upgrade --cache="$ChocoCachePath" --yes microsoft-edge
choco upgrade --cache="$ChocoCachePath" --yes docker-for-windows
choco upgrade --cache="$ChocoCachePath" --yes geforce-experience
choco upgrade --cache="$ChocoCachePath" --yes vscode
choco upgrade --cache="$ChocoCachePath" --yes googlechrome
choco upgrade --cache="$ChocoCachePath" --yes 7zip.install
choco upgrade --cache="$ChocoCachePath" --yes paint.net
choco upgrade --cache="$ChocoCachePath" --yes googledrive
choco upgrade --cache="$ChocoCachePath" --yes notepadplusplus.install
choco upgrade --cache="$ChocoCachePath" --yes foxitreader
choco upgrade --cache="$ChocoCachePath" --yes qbittorrent
choco upgrade --cache="$ChocoCachePath" --yes windirstat
choco upgrade --cache="$ChocoCachePath" --yes everything
#choco upgrade --cache="$ChocoCachePath" --yes visualstudio2019professional --package-parameters "--add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended --norestart --passive --locale en-US"

#--- Leisure ---
choco upgrade --cache="$ChocoCachePath" --yes steam

##########################################################################
# Install VSCode extensions
##########################################################################

code --install-extension ms-vscode.powershell
code --install-extension alefragnani.project-manager
code --install-extension bbenoist.vagrant
code --install-extension bpruitt-goddard.mermaid-markdown-syntax-highlighting
code --install-extension bungcip.better-toml
code --install-extension cake-build.cake-vscode
code --install-extension donjayamanne.githistory
code --install-extension DotJoshJohnson.xml
code --install-extension eamodio.gitlens
code --install-extension EditorConfig.EditorConfig
code --install-extension formulahendry.docker-explorer
code --install-extension haaaad.ansible
code --install-extension humao.rest-client
code --install-extension ilich8086.classic-asp
code --install-extension jebbs.plantuml
code --install-extension luggage66.VBScript
code --install-extension marcostazi.VS-code-vagrantfile
code --install-extension mdickin.markdown-shortcuts
code --install-extension mitchdenny.ecdc
code --install-extension mohsen1.prettify-json
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-mssql.mssql
code --install-extension ms-python.python
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode.csharp
code --install-extension ms-vscode.Go
code --install-extension ms-vscode.powershell
code --install-extension rogalmic.vscode-xml-complete
code --install-extension vscode-icons-team.vscode-icons
code --install-extension vstirbu.vscode-mermaid-preview
code --install-extension yzhang.markdown-all-in-one
code --install-extension zhuangtongfa.Material-theme
code --install-extension zxh404.vscode-proto3

##########################################################################
# Install Rust
##########################################################################

if (!(Test-Rust)) {
    Write-Host "Installing Rust..."
    $Client = New-Object System.Net.WebClient;
    $Client.DownloadFile("https://win.rustup.rs/x86_64", "$HOME/Downloads/rustup-init.exe");
    Start-Process -FilePath "$HOME/Downloads/rustup-init.exe" -NoNewWindow -Wait -ArgumentList "-y";
    RefreshEnv
} else {
    Write-Host "Updating Rust..."
    rustup update
}

##########################################################################
# Restore Temporary Settings
##########################################################################

Enable-UAC
Enable-MicrosoftUpdate
