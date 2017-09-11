# Author: Pedro Dousseau
# Description: Sets Pedro's custom bash settings for the current user 

echo 'export PS1="\[$(tput bold)\]\[\033[38;5;14m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;11m\]@\h\[$(tput sgr0)\]\[\033[38;5;208m\]:\W\[$(tput sgr0)\]\[\033[38;5;13m\]\\$\[$(tput sgr0)\]"' >> ~/.bashrc
