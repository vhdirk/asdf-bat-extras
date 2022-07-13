
export ASDF_INSTALL_VERSION=123
export ASDF_INSTALL_PATH=/tmp

Describe 'asdf-cosign'
  Include 'bin/install'

  Describe 'get_arch()'
    Parameters
      "Intel" "x86_64" "x86_64"
      "ARM64" "arm64" "aarch64"
      "ARMV"  "armv7l" "arm"
    End

    Context "when CPU is $1"
      Mock 'uname'
        echo "$2"
      End

      It "returns $3 on $1 CPU"
        When call get_arch
        The output should equal "$3"
      End
    End
  End

  Describe 'get_platform()'
    Parameters
      "OSX"    "Darwin"  "apple-darwin"   "x86_64"
      "Linux"  "Linux"   "unknown-linux-gnu"  "x86_64"
      "Linux"  "Linux"   "unknown-linux-gnueabihf"   "arm"
      "Windows" "Windows"  "pc-windows-msvc"    "x86_64"
    End

    Context "when OS is $1"
      Mock uname
        echo "$2"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "$4"
      }

      It "returns $3"
        When call get_platform
        The output should equal "$3"
      End
    End
  End
End


