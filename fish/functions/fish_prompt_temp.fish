set col_text 009B95
set col_hl1  FFA900

function fish_prompt
	set_color $col_text
	echo -n -s "$USER "
	set_color $col_hl1
	echo -n -s ">"
end
