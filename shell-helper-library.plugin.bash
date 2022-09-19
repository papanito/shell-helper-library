INSTALL_DIR=$(dirname -- "${BASH_SOURCE[0]}")
loadShellHelperLibray() {
    for filename in $(find ${INSTALL_DIR} -name "*.sh" ); do
        source $filename
    done
}
loadShellHelperLibray