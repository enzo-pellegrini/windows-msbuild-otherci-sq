# $ErrorActionPreference = 'Stop'

# # SonarQube needs a full clone to work correctly but some CIs perform shallow clones
# # so we first need to make sure that the source repository is complete
# git fetch --unshallow

# $SONAR_SERVER_URL = "$env:SONAR_HOST_URL" # Url to your SonarQube instance. In this example, it is defined in the environement through a Github secret.
# #$SONAR_TOKEN = # Access token coming from SonarQube projet creation page. In this example, it is defined in the environement through a Github secret.
# $SONAR_SCANNER_VERSION = "5.0.1.3006" # Find the latest version in the "Windows" link on this page:
#                                       # https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/
# $BUILD_WRAPPER_OUT_DIR = "bw-output" # Directory where build-wrapper output will be placed

# mkdir $HOME/.sonar

# # Prepare downloading and extraction of build-wrapper and sonar-scanner
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Add-Type -AssemblyName System.IO.Compression.FileSystem

# # Download build-wrapper
# $path = "$HOME/.sonar/build-wrapper-win-x86.zip"
# (New-Object System.Net.WebClient).DownloadFile("$SONAR_SERVER_URL/static/cpp/build-wrapper-win-x86.zip", $path)
# [System.IO.Compression.ZipFile]::ExtractToDirectory($path, "$HOME/.sonar")
# $env:Path += ";$HOME/.sonar/build-wrapper-win-x86"

# # Download sonar-scanner
# $path = "$HOME/.sonar/sonar-scanner-cli-$SONAR_SCANNER_VERSION-windows.zip"
# (New-Object System.Net.WebClient).DownloadFile("https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-windows.zip", $path)
# [System.IO.Compression.ZipFile]::ExtractToDirectory($path, "$HOME/.sonar")
# $env:Path += ";$HOME/.sonar/sonar-scanner-$SONAR_SCANNER_VERSION-windows/bin"

# # Build inside the build-wrapper
# build-wrapper-win-x86-64 --out-dir $BUILD_WRAPPER_OUT_DIR msbuild sonar_scanner_example.vcxproj /t:rebuild /nodeReuse:false

# # Run sonar scanner
# sonar-scanner.bat --define sonar.host.url=$SONAR_SERVER_URL --define sonar.login=$SONAR_TOKEN --define sonar.cfamily.compile-commands=$BUILD_WRAPPER_OUT_DIR/compile_commands.json
# # if you are using using SonarQube 10.5 or earlier, replace sonar.cfamily.compile-commands with sonar.cfamily.build-wrapper-output=$BUILD_WRAPPER_OUT_DIR
# # as build-wrapper does not generate a compile_commands.json file before SonarQube 10.6


git fetch --unshallow

# $env:SONAR_SCANNER_VERSION = "6.1.0.4477"
# $env:SONAR_DIRECTORY = [System.IO.Path]::Combine($(get-location).Path,".sonar")
# $env:SONAR_SCANNER_HOME = "$env:SONAR_DIRECTORY/sonar-scanner-$env:SONAR_SCANNER_VERSION-windows-x64"
# rm $env:SONAR_SCANNER_HOME -Force -Recurse -ErrorAction SilentlyContinue
# New-Item -path $env:SONAR_SCANNER_HOME -type directory
# (New-Object System.Net.WebClient).DownloadFile("https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$env:SONAR_SCANNER_VERSION-windows-x64.zip", "$env:SONAR_DIRECTORY/sonar-scanner.zip")
# Add-Type -AssemblyName System.IO.Compression.FileSystem
# [System.IO.Compression.ZipFile]::ExtractToDirectory("$env:SONAR_DIRECTORY/sonar-scanner.zip", "$env:SONAR_DIRECTORY")
# rm ./.sonar/sonar-scanner.zip -Force -ErrorAction SilentlyContinue
# $env:SONAR_SCANNER_OPTS="-server"

# rm "$env:SONAR_DIRECTORY/build-wrapper-win-x86" -Force -Recurse -ErrorAction SilentlyContinue
# (New-Object System.Net.WebClient).DownloadFile("https://sonarcloud.io/static/cpp/build-wrapper-win-x86.zip", "$env:SONAR_DIRECTORY/build-wrapper-win-x86.zip")
# [System.IO.Compression.ZipFile]::ExtractToDirectory("$env:SONAR_DIRECTORY/build-wrapper-win-x86.zip", "$env:SONAR_DIRECTORY")


# & $env:SONAR_DIRECTORY/build-wrapper-win-x86/build-wrapper-win-x86-64.exe --out-dir bw-output msbuild sonar_scanner_example.vcxproj /t:rebuild /nodeReuse:false

# & $env:SONAR_SCANNER_HOME/bin/sonar-scanner.bat `
# -D"sonar.organization=enzopellegrini" `
# -D"sonar.projectKey=enzo-pellegrini_windows-msbuild-otherci-sq" `
# -D"sonar.sources=." `
# -D"sonar.cfamily.compile-commands=bw-output/compile_commands.json" `
# -D"sonar.host.url=https://sonarcloud.io"


$env:SONAR_DIRECTORY = [System.IO.Path]::Combine($(get-location).Path,".sonar")
rm "$env:SONAR_DIRECTORY/build-wrapper-win-x86" -Force -Recurse -ErrorAction SilentlyContinue
New-Item -path $env:SONAR_DIRECTORY/build-wrapper-win-x86 -type directory
(New-Object System.Net.WebClient).DownloadFile("https://3f29989d583a.ngrok.app/static/cpp/build-wrapper-win-x86.zip", "$env:SONAR_DIRECTORY/build-wrapper-win-x86.zip")
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$env:SONAR_DIRECTORY/build-wrapper-win-x86.zip", "$env:SONAR_DIRECTORY")
$env:Path += ";$env:SONAR_DIRECTORY/build-wrapper-win-x86"


$env:SONAR_SCANNER_VERSION = "6.1.0.4477"
$env:SONAR_DIRECTORY = [System.IO.Path]::Combine($(get-location).Path,".sonar")
$env:SONAR_SCANNER_HOME = "$env:SONAR_DIRECTORY/sonar-scanner-$env:SONAR_SCANNER_VERSION-windows-x64"
rm $env:SONAR_SCANNER_HOME -Force -Recurse -ErrorAction SilentlyContinue
New-Item -path $env:SONAR_SCANNER_HOME -type directory
(New-Object System.Net.WebClient).DownloadFile("https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$env:SONAR_SCANNER_VERSION-windows-x64.zip", "$env:SONAR_DIRECTORY/sonar-scanner.zip")
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$env:SONAR_DIRECTORY/sonar-scanner.zip", "$env:SONAR_DIRECTORY")
rm ./.sonar/sonar-scanner.zip -Force -ErrorAction SilentlyContinue
$env:Path += ";$env:SONAR_SCANNER_HOME/bin"
$env:SONAR_SCANNER_OPTS="-server"


build-wrapper-win-x86-64.exe --out-dir bw-output msbuild sonar_scanner_example.vcxproj /t:rebuild /nodeReuse:false


sonar-scanner.bat -D"sonar.projectKey=linux-cmake-gitlab-ci-sc" -D"sonar.sources=." -D"sonar.cfamily.compile-commands=bw-output/compile_commands.json" -D"sonar.host.url=https://3f29989d583a.ngrok.app"
