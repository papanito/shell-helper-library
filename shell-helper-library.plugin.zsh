0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

function loadShellHelperLibray()
{
    for filename in $(find ${0:h} -name "*.sh" ); do
        source $filename
    done
}
loadShellHelperLibray