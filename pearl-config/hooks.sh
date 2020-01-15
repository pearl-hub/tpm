
_initialize_config() {
    apply "# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)" ${HOME}/.tmux.conf false
    link tmux $PEARL_PKGDIR/tpm.conf false

    # If tmux server is running, source the config file
    if tmux info &> /dev/null
    then
        tmux source ${HOME}/.tmux.conf || warn "Warn: Could not source ~/.tmux.conf"
    fi

    info "Press 'prefix + I' inside a tmux session to install/update the initial plugins"
}

post_install() {
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
    _initialize_config
    return 0
}

post_update() {
    _initialize_config
    return 0
}

pre_remove() {
    rm -rf ${HOME}/.tmux/plugins
    unapply "# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)" ${HOME}/.tmux.conf
    unlink tmux $PEARL_PKGDIR/tpm.conf
    return 0
}

