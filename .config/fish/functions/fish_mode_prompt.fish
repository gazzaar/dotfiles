
function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo -n 'N '
        case replace 
            set_color --bold red
            echo -n 'N '
        case replace_one
            set_color --bold red
            echo -n 'N '
        case insert
            set_color --bold brblack
            echo -n 'I '
        case visual
            set_color --bold green
            echo -n 'V '
    end
    set_color normal
end
