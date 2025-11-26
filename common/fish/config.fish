alias ls "eza --icons"
alias ll "eza -lh --icons"
alias la "eza -lah --icons"
alias lt "eza -T --icons"

if status is-interactive
    and not set -q TMUX
    # Define your preferred session name
    set session_name "main"

    # Try to find the session; if it doesn't exist, set it up
    if not tmux has-session -t $session_name 2>/dev/null
        # 1. Create the session (detached)
        tmux new-session -d -s $session_name

        # 2. Split the window horizontally (-h) and run opencode in the new pane
        # Note: -l 40% makes the right pane take up 40% of the screen. Adjust as you like.
        tmux split-window -h -l 40% -t $session_name "opencode"

        # 3. Select the left pane (so you can start typing commands immediately)
        tmux select-pane -t $session_name:0.0
    end

    # Attach to the session (this replaces your current shell view)
    exec tmux attach-session -t $session_name
end

# opencode
fish_add_path /home/aditya/.opencode/bin
