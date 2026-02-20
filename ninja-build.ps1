Set-Location $PSScriptRoot

Remove-Item build -Recurse -Force 
mkdir build 
Set-Location build

cmake -G Ninja `
    -DCMAKE_CXX_COMPILER=clang++ `
    -DCMAKE_BUILD_TYPE=Debug `
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON `
    ..
 
ninja

Set-Location ..