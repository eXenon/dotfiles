function wiki
    set saved_dir (pwd)
    if count $argv > /dev/null
        switch $argv[1]
            case 'add'
                vim $KBFS/private/xaviernunn/wiki/$argv[2]
            case '*'
                echo "Unknown command"
        end
    else
        cd $KBFS/private/xaviernunn/wiki/
        set f (fzf --preview "head {}")
        if test -n f
            vim $f
        end
    end
    cd $saved_dir
end

abbr  -g k wiki
