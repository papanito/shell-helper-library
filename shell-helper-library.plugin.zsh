INSTALL_DIR="${0:a:h}"
function loadShellHelperLibray()
{
    for filename in $(find $INSTALL_DIR -name "*.sh" ); do
        source $filename
    done
}
loadShellHelperLibray