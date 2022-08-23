# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Add Homebrew PATH Vars, supporting both Intel + Apple Silicon
__HOMEBREW_PREFIX="/usr/local"
if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
    __HOMEBREW_PREFIX="/opt/homebrew"
fi

eval "$($__HOMEBREW_PREFIX/bin/brew shellenv)"
