
export ASDF_INSTALL_VERSION=0.21.0
export ASDF_INSTALL_PATH=/tmp

Describe 'asdf-bat'
  Include 'bin/install'

  Describe 'get_download_url()'
    Context "when OS is OSX"
      Mock 'uname'
        echo "apple-darwin"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "x86_64"
      }

      It 'returns correct URL'
        When call get_download_url "${ASDF_INSTALL_VERSION}" 'bat'
        The output should equal "https://github.com/sharkdp/bat/releases/download/v${ASDF_INSTALL_VERSION}/bat-v${ASDF_INSTALL_VERSION}-x86_64-apple-darwin.tar.gz"
      End
    End

    Context "when OS is Linux on Intel CPU"
      Mock 'uname'
        echo "unknown-linux-gnu"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "x86_64"
      }

      It 'returns correct URL'
        When call get_download_url "${ASDF_INSTALL_VERSION}" 'bat'
        The output should equal "https://github.com/sharkdp/bat/releases/download/v${ASDF_INSTALL_VERSION}/bat-v${ASDF_INSTALL_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
      End
    End

    Context "when OS is Linux on ARM CPU"
      Mock 'uname'
        echo "unknown-linux-gnueabihf"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "arm"
      }

      It 'returns correct URL'
        When call get_download_url "${ASDF_INSTALL_VERSION}" 'bat'
        The output should equal "https://github.com/sharkdp/bat/releases/download/v${ASDF_INSTALL_VERSION}/bat-v${ASDF_INSTALL_VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
      End
    End
  End
End
