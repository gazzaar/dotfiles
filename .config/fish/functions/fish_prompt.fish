function fish_prompt
    set -l __last_command_exit_status $status

    if not set -q -g __fish_arrow_functions_defined
        set -g __fish_arrow_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            not command git diff-index --cached --quiet HEAD -- &>/dev/null
            or not command git diff --no-ext-diff --quiet --exit-code &>/dev/null
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            set -l stat (hg status -mard 2>/dev/null)
            test -n "$stat"
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_hg_repo
                echo hg
                return 0
            else if _is_git_repo
                echo git
                return 0
            end
            return 1
        end
    end

    # Dim colors for less highlight
    set -l dim_gray (set_color brblack)       # for repo type label "git:" dimmed
    set -l dim_cyan (set_color -o blue)       # for slightly dimmed folder name
    set -l branch_highlight (set_color -d green) # bright green for branch name
    set -l yellow (set_color yellow)           # yellow for dirty marker
    set -l red (set_color red)                  # red for error arrow
    set -l green (set_color green)              # green for success arrow
    set -l normal (set_color normal)            # reset color

    # Determine arrow color by last command status
    set -l arrow_color $green
    if test $__last_command_exit_status != 0
        set arrow_color $red
    end

    set -l arrow "$arrow_color❯"
    if fish_is_root_user
        set arrow "$arrow_color# "
    end

    # Dimmed current working directory basename
    set -l cwd $dim_cyan (basename (prompt_pwd))

    # Git repo info with dimmed 'git:' label and bright branch name
    set -l repo_info
    if set -l repo_type (_repo_type)
        set -l repo_label "$dim_gray$repo_type: "
        set -l repo_branch "$branch_highlight"(_repo_branch_name $repo_type)
        set repo_info "$repo_label$repo_branch"

        if _is_repo_dirty $repo_type
            set repo_info "$repo_info $yellow✗"
        end
    end

    # Output full prompt
  echo -n -s $cwd " " $repo_info " " $arrow $normal " "
end

function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo 'N '
        case insert
            set_color --bold green
            echo 'I '
        case replace_one
            set_color --bold green
            echo 'R '
        case visual
            set_color --bold brmagenta
            echo 'V '
    end
    set_color normal
end
