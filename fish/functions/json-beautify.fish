function json-beautify
    python3 -c "import json, sys
if '-h' in sys.argv or 'help' in sys.argv or '-help' in sys.argv:
    print('Read JSON from stdin and print it nicely to stdout.')
    print('    -l [line]: Interpret input line by line.')
    print('               Optionnally only print one given line')
    print('')
    print('(Side note: dont try to debug this. It\'s horrible...')
    sys.exit(0)
if '-l' in sys.argv:
    if len(sys.argv) > sys.argv.index('-l'):
        print(json.dumps(json.loads(list(sys.stdin.readlines())[int(sys.argv[sys.argv.index('-l') + 1])]),sort_keys=True,indent=2))
    else:
        print(json.dumps([json.loads(l) for l in sys.stdin.readlines()],sort_keys=True,indent=2))
else:
    print(json.dumps(json.loads('\n'.join(sys.stdin.readlines())),sort_keys=True,indent=2))" $argv
end
