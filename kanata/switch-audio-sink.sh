#!/bin/bash
# Switch audio output — cycle automatically, or pick interactively with fzf

MODE="${1:-cycle}"

mapfile -t SINK_NAMES < <(pactl list sinks | awk '
    /^Sink #/         { idx = substr($2, 2) }
    /Description:/    { sub(/.*Description: /, ""); print idx ": " $0 }
')
mapfile -t SINK_IDS < <(pactl list short sinks | awk '{print $2}')

if [ ${#SINK_IDS[@]} -eq 0 ]; then
    notify-send "Audio" "No sinks found"
    exit 1
fi

get_current_idx() {
    local CURRENT
    CURRENT=$(pactl get-default-sink)
    for i in "${!SINK_IDS[@]}"; do
        [[ "${SINK_IDS[$i]}" == "$CURRENT" ]] && echo "$i" && return
    done
    echo 0
}

apply_sink() {
    local SINK="$1"
    local LABEL="$2"
    pactl set-default-sink "$SINK"
    pactl list short sink-inputs | awk '{print $1}' | while read -r INPUT; do
        pactl move-sink-input "$INPUT" "$SINK"
    done
    notify-send "🔊 Audio Output" "Switched to: $LABEL" --expire-time=2000
}

if [[ "$MODE" == "choose" ]]; then
    CURRENT_IDX=$(get_current_idx)
    TMPFILE=$(mktemp /tmp/audio-sink-XXXXXX)

    # Build display list, marking current device with ✓
    DISPLAY_LIST=()
    for i in "${!SINK_NAMES[@]}"; do
        if [[ "$i" -eq "$CURRENT_IDX" ]]; then
            DISPLAY_LIST+=("✓ ${SINK_NAMES[$i]}")
        else
            DISPLAY_LIST+=("  ${SINK_NAMES[$i]}")
        fi
    done

    # Detect available terminal emulator
    if command -v gnome-terminal &>/dev/null; then
        TERM_CMD="gnome-terminal --wait --"
    elif command -v xterm &>/dev/null; then
        TERM_CMD="xterm -e"
    elif command -v kitty &>/dev/null; then
        TERM_CMD="kitty"
    elif command -v alacritty &>/dev/null; then
        TERM_CMD="alacritty -e"
    else
        notify-send "Audio Switcher" "No supported terminal found. Install gnome-terminal or xterm."
        exit 1
    fi

    # Launch fzf in terminal, write chosen line to tmpfile
    $TERM_CMD zsh -c "
        printf '%s\n' $(printf '%q ' "${DISPLAY_LIST[@]}") | \
        fzf --prompt='🔊 Audio output > ' \
            --height=100% \
            --border=rounded \
            --header='Select output device  (Enter = confirm, Esc = cancel)' \
            --color='header:italic:cyan' \
            --no-info \
        > '$TMPFILE'
    "

    CHOSEN=$(cat "$TMPFILE")
    rm -f "$TMPFILE"

    [[ -z "$CHOSEN" ]] && exit 0

    # Match chosen line back to sink (strip leading ✓ or spaces)
    CHOSEN_CLEAN=$(echo "$CHOSEN" | sed 's/^[✓ ]*//')
    for i in "${!SINK_NAMES[@]}"; do
        if [[ "${SINK_NAMES[$i]}" == "$CHOSEN_CLEAN" ]]; then
            apply_sink "${SINK_IDS[$i]}" "$CHOSEN_CLEAN"
            break
        fi
    done

else
    # Cycle mode
    CURRENT_IDX=$(get_current_idx)
    NEXT_IDX=$(( (CURRENT_IDX + 1) % ${#SINK_IDS[@]} ))
    apply_sink "${SINK_IDS[$NEXT_IDX]}" "${SINK_NAMES[$NEXT_IDX]}"
fi
