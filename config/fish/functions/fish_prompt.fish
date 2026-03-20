function fish_prompt --description 'Write out the prompt'
        set -l last_status $status
        set -l normal (set_color normal)
        set -l status_color (set_color brgreen)
        set -l cwd_color (set_color $fish_color_cwd)
        set -l vcs_color (set_color brpurple)
        set -l prompt_status ""

        set -g __fish_git_prompt_show_informative_status 1
        set -g __fish_git_prompt_showuntrackedfiles 1
        set -g __fish_git_prompt_showdirtystate 1
        set -g __fish_git_prompt_showcolorhints 1
        set -g __fish_git_prompt_showstashstate 1
        set -g __fish_git_prompt_showupstream informative
    
        # Since we display the prompt on a new line allow the directory names to be longer.
        set -q fish_prompt_pwd_dir_length
        or set -lx fish_prompt_pwd_dir_length 0
    
        # Color the prompt differently when we're root
        set -l suffix '❯'
        if functions -q fish_is_root_user; and fish_is_root_user
                if set -q fish_color_cwd_root
                        set cwd_color (set_color $fish_color_cwd_root)
                end
                set suffix '#'
        end
    
        # Color the prompt in red on error
        if test $last_status -ne 0
                set status_color (set_color $fish_color_error)
                set prompt_status $status_color "[" $last_status "]" $normal
        end
    
        echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
        set -l venv_info ""
        if set -q VIRTUAL_ENV
                set venv_info (set_color bryellow) "(" (basename $VIRTUAL_ENV) ")" $normal " "
        end
        echo -n -s $venv_info $status_color $suffix ' ' $normal
end
