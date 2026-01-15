# Iterm Integration
if test -e ~/.iterm2_shell_integration.fish
    source ~/.iterm2_shell_integration.fish
end

# Zoxide Bindings
if type -q zoxide
    zoxide init fish | source
    alias cd=z
end

# Mise - https://mise.jdx.dev/cli/use.html
if type -q mise
    # Set up mise for runtime management
    mise activate fish | source
end

if type -q eza
    alias ls=eza
end

if type -q kubectl
    alias k=kubectl
end

if type -q cursor-agent
    alias ca=cursor-agent
end

# Personal tools
alias srg=super_grep

