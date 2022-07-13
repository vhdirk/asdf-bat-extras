
export ASDF_INSTALL_VERSION=0.21.0
export ASDF_INSTALL_PATH=/tmp

Describe 'asdf-cosign'
  Include 'bin/install'

  Describe 'get_download_url()'
    Parameters
      "OSX"     "apple-darwin" "x86_64" "https://github.com/sharkdp/bat/releases/download/v${ASDF_INSTALL_VERSION}/bat-v${ASDF_INSTALL_VERSION}-x86_64-apple-darwin.tar.gz"
      "Linux"   "unknown-linux-gnu" "x86_64" "https://github.com/sharkdp/bat/releases/download/v${ASDF_INSTALL_VERSION}/bat-v${ASDF_INSTALL_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
      "Linux"   "unknown-linux-gnueabihf" "arm" "https://github.com/sharkdp/bat/releases/download/v${ASDF_INSTALL_VERSION}/bat-v${ASDF_INSTALL_VERSION}-arm-unknown-linux-gnueabihf.tar.gz"
    End

    Context "when OS is $1"
      Mock 'uname'
        echo "$2"
      End

      # Have to cheat here as can not mock uname twice
      get_arch() {
        echo "$3"
      }

      It 'returns correct URL'
        When call get_download_url "${ASDF_INSTALL_VERSION}" 'bat'
        The output should equal "$4"
      End
    End
  End
End
