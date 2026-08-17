
PROMPT_COLOR_TIME=140      # purple
PROMPT_COLOR_USER=116      # baby blue
PROMPT_COLOR_HOST=140      # purple
PROMPT_COLOR_PATH=42       # green
PROMPT_COLOR_ALERT=216   # orange
PROMPT_COLOR_GIT=211       # pink
PROMPT_COLOR_PROMPT=42     # green
PROMPT_COLOR_TEXT=59       # gray

declare -A PROMPT_COLORS=(
    [time]="\[\033[38;5;${PROMPT_COLOR_TIME}m\]"
    [user]="\[\033[38;5;${PROMPT_COLOR_USER}m\]"
    [host]="\[\033[38;5;${PROMPT_COLOR_HOST}m\]"
    [path]="\[\033[38;5;${PROMPT_COLOR_PATH}m\]"
    [alert]="\[\033[38;5;${PROMPT_COLOR_ALERT}m\]"
    [git]="\[\033[38;5;${PROMPT_COLOR_GIT}m\]"
    [prompt]="\[\033[38;5;${PROMPT_COLOR_PROMPT}m\]"
    [text]="\[\033[38;5;${PROMPT_COLOR_TEXT}m\]"
    [reset]="\[\033[0m\]"
)

# Determine whether there is a message in the directory
function prompt_alert() {
    ALERT_PATH="./fsalert"
    ALERT_SUPPRESSED_PATH="./fsalert.seen"
    
    if [ -f $ALERT_PATH ]; then
        echo -e -n "\n(new message in fsalert) "
    elif [ -f $ALERT_SUPPRESSED_PATH ]; then
        echo -e -n "\n(opened message in fsalert) "
    fi
}


# View or add alert
function fsalert() {
    ALERT_PATH="./fsalert"
    ALERT_SUPPRESSED_PATH="./fsalert.seen"
    
    # View old alert and delete it
    if [ -f $ALERT_SUPPRESSED_PATH ]; then
        less $ALERT_SUPPRESSED_PATH
        read -p "Delete suppressed alert [n|y]? n: " sd
        if [ "$sd" == "y" ]; then
            rm $ALERT_SUPPRESSED_PATH
        fi
    fi
    
    # View current alert and suppress/delete it
    if [ -f $ALERT_PATH ]; then
        less $ALERT_PATH
        read -p "Suppress (default) or delete alert [s|d]? s: " sd
        if [ "$sd" == "d" ]; then
            rm $ALERT_PATH
        else
            mv $ALERT_PATH $ALERT_SUPPRESSED_PATH
        fi
    fi
    
    # Save new alert
    new_alert="$*"
    if [ ! -z "$new_alert" ]; then
        if [ -f $ALERT_PATH ]; then
            read -p "Overwrite alert with new message [n|y]? n: " ny
            if [ "$ny" == "y" ]; then
                mv $ALERT_PATH $ALERT_PATH.bak
                echo "$new_alert" > $ALERT_PATH
                cat $ALERT_PATH.bak > $ALERT_PATH
                rm $ALERT_PATH.bak
            else
                echo "$new_alert" > $ALERT_PATH
            fi
        else
            echo "$new_alert" > $ALERT_PATH
        fi
    fi
}
export function fsalert

# Function to get git branch
function parse_git_branch() {
    local value
    value=$(git symbolic-ref -q --short HEAD 2>/dev/null || \
            git describe --tags --exact-match 2>/dev/null || \
            git rev-parse --short HEAD 2>/dev/null)
    if [[ -n $value ]]; then
        echo -e -n "\n($value) "
    fi
}

# Set the prompt
function __prompt_command() {

    #PS1="bruh ${VAR}>"
    
    line2="${PROMPT_COLORS[git]}\$(parse_git_branch)${PROMPT_COLORS[user]}\$(prompt_alert)"
    
    PS1="${PROMPT_COLORS[time]}\@\[$(tput sgr0)\]${PROMPT_COLORS[text]} as ${PROMPT_COLORS[user]}\u${PROMPT_COLORS[text]} on ${PROMPT_COLORS[host]}\h${PROMPT_COLORS[text]} in ${PROMPT_COLORS[path]}\w${PROMPT_COLORS[git]}\$(parse_git_branch)${PROMPT_COLORS[alert]}\$(prompt_alert)\n ${PROMPT_COLORS[prompt]}>${PROMPT_COLORS[reset]} "
    
}

PROMPT_COMMAND=__prompt_command

