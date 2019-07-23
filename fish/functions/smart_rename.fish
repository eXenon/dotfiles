function smart_rename
    echo "Smart replacing $argv[1] with $argv[2]"
    find . -not -path '*/\.*' -type f -print0 | xargs -0 sed -i "s/$argv[1]/$argv[2]/g"
    find . -not -path '*/\.*' -type f -print0 | xargs -0 sed -i "s/$argv[1]/(echo $argv[2] | string lower)/g"
    find . -not -path '*/\.*' -type f -print0 | xargs -0 sed -i "s/$argv[1]/(echo $argv[2] | string upper)/g"
end
