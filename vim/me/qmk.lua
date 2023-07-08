-- Functions related to QMK keymap files


function is_qmk()
    -- Get the current file path
    local filepath = vim.api.nvim_buf_get_name(0)

    -- Get the absolute path of the current file
    local absolutePath = vim.fn.fnamemodify(filepath, ":p")

    -- Check if the file path contains qmk_firmware/
    if string.find(absolutePath, "/qmk_firmware/") then
        return true
    else
        return false
    end
end

function format_qmk()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()

    -- Get the keys only
    local keyboardArray = string.gsub(line, "^.-LAYOUT_planck_grid%((.-)%).-$", "%1")

    -- Split the array into individual elements
    local elements = {}
    for element in string.gmatch(keyboardArray, "[^,]+") do
        table.insert(elements, element)
    end

    -- Format the elements
    local formattedArray = ""
    for i, element in ipairs(elements) do
        formattedArray = formattedArray .. "\t" .. element

        -- Add a comma
        formattedArray = formattedArray .. ","

        -- Add newline every 12 elements
        if math.fmod(i, 12) == 11 then
            formattedArray = formattedArray .. "\n"
        end
    end

    -- Replace the original keyboard array with the formatted one
    line = string.gsub(line, "LAYOUT_planck_grid", formattedArray)

    -- Update the current line in the buffer
    vim.api.nvim_set_current_line(line)
end

if is_qmk() then
    vim.api.nvim_set_keymap('n', '<leader>f', ':lua format_qmk()<CR>', { silent = true })
end
