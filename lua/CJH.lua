
local function process_build_script(argument)

    -- Supporting null-argument values, check for that.
    local argument_value = ""
    if argument then
        argument_value = argument
    else
        print("CJH: Warning: CLI command wasn't provided.")
        return
    end

    -- Print debug for the user.
    local print_string = "CJH: Executing build routine: " .. argument_value .. "..."
    print(print_string)

    -- Determine if the screen is currently split.
    local win_amount = #vim.api.nvim_tabpage_list_wins(0)
    if win_amount == 1 then
        vim.api.nvim_command("vsplit")
    end

    -- Create a buffer to print to.
    local current_buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(current_buffer)

    -- Set the line-endings for this buffer.
    vim.api.nvim_command("set ffs=dos")

    -- Start the job.
    local job_identifier = vim.fn.jobstart(argument, {
        on_stdout = function(_, data)
            vim.api.nvim_buf_set_lines(current_buffer, -2, -1, false, data)
            vim.cmd(":%s/\r/")
        end,
        on_exit = function(_, exit_code)
            print("CJH: Build job complete.")
        end
    })
    
end

local function is_string_empty(string)
    if current_line_content == nil or current_line_content == '' then
        return true
    end
    return false
end

function extractNumbers(inputString)
    local pattern = "%((%d+),(%d+)%)"
    local num1, num2 = inputString:match(pattern)
    
    if num1 and num2 then
        return tonumber(num1), tonumber(num2)
    else
        return nil, nil
    end
end

function switchToNextWindow()
    local currentWin = vim.api.nvim_get_current_win()
    local windows = vim.api.nvim_list_wins()

    for i, win in ipairs(windows) do
        if win == currentWin then
            local nextWinIndex = i % #windows + 1
            vim.api.nvim_set_current_win(windows[nextWinIndex])
            break
        end
    end
end

local function process_jump_to()

    -- Get the current line, we want to grep this.
    local current_line_content = vim.fn.getline('.')

    local pattern = "^[A-Za-z0-9:\\]*%.[A-Za-z]*%([0-9,]*%):.error"
    local contains_pattern,end_pattern = string.find(current_line_content, pattern)

    if contains_pattern then
        local sub_string = string.sub(current_line_content, contains_pattern, end_pattern)

        local path_s, path_e = string.find(sub_string, "[A-Za-z0-9\\:]*%.[A-Za-z]*%(")
        local line_loc_s, line_loc_e = string.find(sub_string, "%([0-9?,]*%)")

        local path = string.sub(sub_string, path_s, path_e-1)
        local line, col = extractNumbers(string.sub(sub_string, line_loc_s, line_loc_e))

        local current_working_directory = vim.fn.getcwd()
        local relative_path = string.sub(path, string.len(current_working_directory) + 1, string.len(path))
        print(relative_path)

        -- Switch to the next window.
        switchToNextWindow()

        -- Open the file.
        local open_command = "e ." .. relative_path .. "|call cursor(" .. line .. "," .. col .. ")"
        vim.cmd(open_command)
    else
        print("CJH: Unable to find jumpable position.")
    end

end

return {
    build_script = process_build_script,
    jump_to = process_jump_to
}

