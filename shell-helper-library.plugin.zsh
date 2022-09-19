INSTALL_DIR="${0:a:h}"
loadShellHelperLibray() {
    for filename in $(find $INSTALL_DIR -name "*.sh" ); do
        source $filename
    done
}
loadShellHelperLibray