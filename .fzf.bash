# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ionel/.fzf/bin* ]]; then
  export PATH="$PATH:/home/ionel/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ionel/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/ionel/.fzf/shell/key-bindings.bash"

