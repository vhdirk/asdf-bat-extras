export ASDF_INSTALL_VERSION="2023.09.19"
export ASDF_INSTALL_PATH=/tmp

Describe 'asdf-bat-extras'
Include 'bin/install'

Describe 'get_download_url()'
It 'returns correct URL'
When call get_download_url "${ASDF_INSTALL_VERSION}" 'bat-extras'
The output should equal "https://github.com/eth-p/bat-extras/releases/download/v2023.09.19/bat-extras-202309.19.zip"
End
End
End
