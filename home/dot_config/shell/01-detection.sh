
############################### DETECTION ##############################

## Detection of interactivity. Shell *must* be
## interactive or *none* of this applies.

case $- in
  *i*) ;;
  *) return
esac

## Detection of major operating systems.

[ -z "$OS" ] && export OS=`uname`
case "$OS" in
  Linux)          export PLATFORM=linux ;;
  *indows*)       export PLATFORM=windows ;;
  FreeBSD|Darwin) export PLATFORM=mac ;;
  *)              export PLATFORM=unknown ;;
esac
