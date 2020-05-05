#
# Customise ZSH THEME
####

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel9k/powerlevel9k"

# customise
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir dir_writable vcs);
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator);

POWERLEVEL9K_STATUS_OK=false;

# dir config
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# VCS config
POWERLEVEL9K_VCS_HIDE_TAGS=false;

POWERLEVEL9K_VCS_SHOW_CHANGESET=true;
POWERLEVEL9K_SHOW_CHANGESET=true;

POWERLEVEL9K_CHANGESET_HASH_LENGTH=8;
POWERLEVEL9K_VCS_CHANGESET_HASH_LENGTH=6;

#POWERLEVEL9K_VCS_SHORTEN_LENGTH=0;
#POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=0;
#POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right";
#POWERLEVEL9K_VCS_SHORTEN_DELIMITER='';
