#if status is-login
#    and status is-interactive
    set -lx SHELL fish
    # Add your SSH keys to autoload
    set -e SSH_KEYS_TO_AUTOLOAD
    set -Ua SSH_KEYS_TO_AUTOLOAD ~/.ssh/atlas ~/.ssh/id_ed25519
    keychain --eval $SSH_KEYS_TO_AUTOLOAD | source
#end
