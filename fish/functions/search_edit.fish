function search_edit -d "Re-run the latest git grep command and open all the results in vim"
    # Find all interesting commands in recent history

    set latest ""
    
    # Check git grep
    set latest_gg (history -R --prefix "git grep" --max 5 |  tail -n 1 | sed "s/grep/grep --name-only/")
    if string length -q -- $latest_gg
        set latest "$latest_gg"
    end

    # Check regular grep
    set latest_g (history -R --prefix "grep" --max 5 | tail -n 1 | sed "s/grep/grep -r/")
    if string length -q -- $latest_g
        set latest (string join -n "\n" "$latest" "$latest_g")
    end

    # Check fd
    set latest_fd (history -R --prefix "fd" --max 5 | tail -n 1)
    if string length -q -- $latest_fd
        set latest (string join -n "\n" "$latest" "$latest_fd")
    end

    # Select or execute
    if test "$latest" = ""
        echo "Couldn't find a grep command."
        return 1
    end
    if test (echo -e "$latest" | wc -l) -eq 1
        echo "Only one command found"
        set cmd "$latest"
    else
        set cmd (echo -e "$latest" | fzf)
    end
    vim (eval $cmd)
end
