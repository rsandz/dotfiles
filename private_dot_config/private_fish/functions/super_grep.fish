# Interactive grep with fuzzy finding and file preview
#
# Usage:
#   super_grep <pattern> [directory]
#
# Arguments:
#   pattern   - Search pattern (supports regex, smart-case)
#   directory - Optional directory to search in (defaults to current directory)
#
# Output:
#   Outputs the selected file path 
#
# Dependencies:
#   - rg (ripgrep) - for fast searching
#   - fzf - for interactive fuzzy selection
#   - bat - for syntax-highlighted preview
#
# Examples:
#   super_grep "TODO"           # Search for TODO in current directory
#   super_grep "func" ./src     # Search for func in ./src directory

function super_grep --description "Interactive grep with fuzzy finding and preview"
    if not type -q bat
        echo "bat is needed - please install it first."
        return 1
    end

    if not type -q fzf
        echo "fzf is needed - please install it first"
        return 1
    end

    if not type -q rg
        echo "rg is needed - please install it first"
        return 1
    end

    if test (count $argv) -lt 1
        echo "Usage: super_grep <pattern> [directory]"
        return 1
    end

    set -l pattern $argv[1]
    set -l dir .
    if test (count $argv) -ge 2
        set dir $argv[2]
    end

    rg --color=always --line-number --no-heading --smart-case $pattern $dir | \
      fzf --ansi \
          --color "hl:-1:underline,hl+:-1:underline:reverse" \
          --delimiter : \
          --preview 'bat --color=always {1} --highlight-line {2}' \
          --preview-window '+{2}+3/3,~3' \
          --bind 'enter:become(echo {1})'
end

