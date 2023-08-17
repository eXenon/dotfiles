function search_edit -d "Re-run the latest git grep command and open all the results in vim"
    set latest (history -R --prefix "git grep" --max 50 |  tail -n 1 | sed "s/grep/grep --name-only/")
    if test "$latest" = ""
        set latest (history -R --prefix "grep" --max 50 | tail -n 1 | sed "s/grep/grep -r/")
    end
    if test "$latest" = ""
        echo "Couldn't find a grep command."
        exit 1
    end
    echo "Identified previous grep: $latest"
    sleep 1
    vim (eval $latest)
end
