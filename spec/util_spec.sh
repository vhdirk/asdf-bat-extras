
export ASDF_INSTALL_VERSION=123
export ASDF_INSTALL_PATH=/tmp

Describe 'asdf-bat'
  Include 'bin/install'

  Describe 'get_arch()'
    Context "when CPU is Intel"
      Mock 'uname'
        echo "x86_64"
      End

      It "returns x86_64"
        When call get_arch
        The output should equal "x86_64"
      End
    End

    Context "when CPU is ARM64"
      Mock 'uname'
        echo "arm64"
      End

      It "returns aarch64"
        When call get_arch
        The output should equal "aarch64"
      End
    End

    Context "when CPU is ARM"
      Mock 'uname'
        echo "armv7l"
      End

      It "returns arm"
        When call get_arch
        The output should equal "arm"
      End
    End
  End

  Describe 'get_platform()'
    Context "when OS is OSX"
      Mock uname
        echo "Darwin"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "x86_64"
      }

      It "returns apple-darwin"
        When call get_platform
        The output should equal "apple-darwin"
      End
    End

    Context "when OS is Linux on Intel CPU"
      Mock uname
        echo "Linux"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "x86_64"
      }

      It "returns unknown-linux-gnu"
        When call get_platform
        The output should equal "unknown-linux-gnu"
      End
    End

    Context "when OS is Linux on ARM CPU"
      Mock uname
        echo "Linux"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "arm"
      }

      It "returns unknown-linux-gnueabihf"
        When call get_platform
        The output should equal "unknown-linux-gnueabihf"
      End
    End

    Context "when OS is Windows"
      Mock uname
        echo "Windows"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "x86_64"
      }

      It "returns pc-windows-msvc"
        When call get_platform
        The output should equal "pc-windows-msvc"
      End
    End
  End
End


