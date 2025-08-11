function ai-feature -d "Start building a feature in a worktree with AI"
    set FEATURE "$argv[1]"
    set DIRECTORY "ai-feature-(uuidgen)"
    set PROMPT "Implement the feature described in @.features/$FEATURE.md"
    git worktree add -B feature/$FEATURE ../$DIRECTORY
    cd ../$DIRECTORY
    vim .features/$FEATURE.md
    if test -e "GEMINI.md" then
        gemini -y -p $PROMPT
    end
    if test -e "CLAUDE.md" then
        claude --dangerously-skip-permissions -p $PROMPT
    end
end
