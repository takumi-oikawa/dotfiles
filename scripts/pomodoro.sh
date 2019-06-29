VERSION="1.0.0"

__help () {
    echo "Usage: $filename [OPTION]... [TASK_NAME]

    [TASK_NAME]    The task name to do at this block.
    -h, --help     Display this help and exit.
    -v, --version  Display version information and exit.

    Example:
        pomodoro "Implement Unit Test"
    "
    exit 1
}

function __version {
    echo "simple pomodoro timer" "ver:" $VERSION
    exit 1
}

__check_dependency () {
    if ! type $1 > /dev/null; then
        echo "this command depends on $1"
        echo "try brew install $1"
        exit 1
    fi
}

__take_log () {
    LOG_FILE=$HOME/.local/share/pomodoro/pomodoro.log
    test -e $(dirname $LOG_FILE) || mkdir $(dirname $LOG_FILE)
    touch $LOG_FILE
    echo $1\\t$(gdate "+%Y/%m/%d %H:%M:%S") >> $LOG_FILE
}

__notificate () {
    terminal-notifier -title $1 -message $2 -subtitle $3 -sound Hero
}

__timer () {
  secs=0
  goal_minute=$(( ($1/60) % 60))
  goal_second=$(( ($1 % 60) ))
  while [ $secs -le $1 ]
  do
    sleep 1
    printf "\r%02d:%02d / %02d:%02d" $(( (secs/60)%60)) $((secs%60)) $goal_minute $goal_second
    secs=$(( $secs + 1 ))
  done
  echo
}

__error_help () {
    echo "Invalid: $filename ${*}\n"
    help
}


TITLE="POMODORO TIMER"
END_TASK_MESSAGE="Time to Break!"
END_REST_MESSAGE="End of rest, gatta work!"
ICON="TODO"
TASK_DURATION=1500 # 25 minute
REST_DURATION=300 # 5 minute

# os check
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Sorry! supports only for Mac";
    exit 1
fi

__check_dependency "terminal-notifier"
__check_dependency "gdate"

# option check
case $# in
0) __help ;;
1)
    case $1 in
        -h | --help)    __help    ;;
        -v | --version) __version ;;
        -*)
            __error_help $*
        ;;
    esac
;;
*)
    __error_help $*
;;
esac

[[ -n $1 ]] && TASK_NAME=$1 || TASK_NAME="名称未設定"

echo "$TASK_NAME's pomodoro timer start! ganbare!"

__timer $TASK_DURATION

echo "$TASK_NAME's pomodoro timer end! otsukare!"

__notificate $TITLE $END_TASK_MESSAGE $TASK_NAME

__take_log $TASK_NAME

echo "rest start!"

__timer $REST_DURATION

echo "rest end! bye!"

__notificate $TITLE $END_REST_MESSAGE $TASK_NAME
