# Hervala's ~~Patrik's~~ configurations

This repository contains my personal configurations for
things like Windows, Linux, my terminals etc. I will 
therefore not accept any pull requests or changes to this repo.

This repository originated as a fork from Patrik Svensson. I 
have modified it with my personal preferences. I really liked 
the way he used Install.ps1 to bootstrap everything nicely.

Feel free to fork this repository or use it as an
inspiration for your own configurations.

# Quick Start (Windows)

Download and unzip this repository
```
PS> Invoke-WebRequest -Uri https://github.com/hervala/machine/archive/master.zip -OutFile ./machine_master.zip -UseBasicParsing ; Expand-Archive -Path ./machine_master.zip -DestinationPath ./
```

Set PowerShell Execution policy so that the Install script can be run
```
PS> Set-ExecutionPolicy RemoteSigned
```

Install Prerequisites and adjust basic Windows settings
```
PS> cd ./machine-master/windows/
PS> Install.ps1 -Prereqs
```

Reboot

Install Apps
```
PS> Install.ps1 -Apps
```

Install WSL
```
PS> Install.ps1 -Ubuntu
```



## Disclaimer

Running the scripts here without knowing what they do
will most likely make you sad and/or change your
computer settings to something that you don't want. 