source /usr/share/cachyos-fish-config/cachyos-config.fish

pyenv init - fish | source
load_nvm > /dev/stderr

if status is-interactive
    # Starship custom prompt
    starship init fish | source

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
end

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# pnpm
set -gx PNPM_HOME "/home/dadangdut33/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
