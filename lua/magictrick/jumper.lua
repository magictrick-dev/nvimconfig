
local configuration = {
    default_script
}

local function find_buffer_by_name(bufferName)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local bufName = vim.fn.bufname(buf)
        if bufName == bufferName then
            return buf
        end
    end
    return nil
end

function is_buffer_active(buffer_number)
    local active_window = vim.fn.win_getid()
    local buffer_in_active_window = vim.fn.winbufnr(active_window)

    return buffer_number == buffer_in_active_window
end


local function process_build_script(opts)

    -- If we did not provide a build script through the command
    -- invocation, use the default one from our config.
    local argument
    if opts.fargs == nil or opts.fargs[1] == nil then
        argument = configuration.default_script
    else 
        argument = opts.fargs[1]
    end

    -- Check if the argument is actually there.
    if argument == nil or argument == '' then
        print("A build command was not provided and default was not set.")
    end

    -- Determine if the screen is currently split.
    local win_amount = #vim.api.nvim_tabpage_list_wins(0)
    if win_amount == 1 then
        vim.api.nvim_command("vsplit")
    end

    -- Find the current scratch buffer or make one.
    local current_buffer = find_buffer_by_name("Scratch")
    if not current_buffer then
        current_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(current_buffer, "Scratch")
    end

    -- Switch to the other window if the current buffer is not our
    -- scratch buffer.
    if not is_buffer_active(current_buffer) then
        switch_to_next_window()
    end

    -- Clear the scratch buffer.
    vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, {})

    -- Set the current buffer.
    vim.api.nvim_set_current_buf(current_buffer)

    -- Callbacks.
    local on_output = function()
        vim.api.nvim_buf_set_lines(current_buffer, -2, -1, false, data)
    end

    local on_exit = function()
        print("Build complete.")
    end

    -- Start the job.
    local job_identifier = vim.fn.jobstart(argument, {
        on_stdout = function(_, data)
            vim.api.nvim_buf_set_lines(current_buffer, -2, -1, false, data)
        end,
        on_exit = function(_, exit_code)
            print("Build job complete.")
        end
    })


end

local function is_string_empty(string)
    if current_line_content == nil or current_line_content == '' then
        return true
    end
    return false
end

function extract_line_numbers(input)
    local numbers = {}
    local pattern = "%(([%d,]*)%)"

    local matches = {input:match(pattern)}

    if #matches > 0 then
        local numbersString = matches[1]
        for number in numbersString:gmatch("(%d+)") do
            table.insert(numbers, tonumber(number))
        end
    end

    return numbers
end

function switch_to_next_window()
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

    -- Establish our line search pattern.
    local pattern = "^[A-Za-z0-9:\\/_-]*%.[A-Za-z]*%([0-9,]*%):"
    local contains_pattern,end_pattern = string.find(current_line_content, pattern)

    -- If we found our pattern, then we can attempt to see if it is jumpable.
    if contains_pattern then

        -- Get the string that we care about from the output.
        local sub_string = string.sub(current_line_content, contains_pattern, end_pattern)

        -- Pull the useable path from the output.
        local path_s, path_e = string.find(sub_string, "[A-Za-z0-9:\\/_-]*%.[A-Za-z]*%(")
        local path = string.sub(sub_string, path_s, path_e-1)

        -- Determine the line positions. This may just be a line, or line + col.
        local line_loc_s, line_loc_e = string.find(sub_string, "%([0-9?,]*%)")
        local cursor_positions = extract_line_numbers(string.sub(sub_string, line_loc_s, line_loc_e))
        
        -- Construct the cursor call command.
        local cursor_command = cursor_positions[1]
        if cursor_positions[2] then
            cursor_command = cursor_command .. "," .. cursor_positions[2]
        else
            cursor_command = cursor_command .. "," .. 1
        end

        -- Switch to the next window.
        switch_to_next_window()

        -- Open the file.
        local open_command = "e " .. path .. "|call cursor(" .. cursor_command .. ")"
        vim.cmd(open_command)
        
    else

        -- Inform the user that the line wasn't a jumpable line.
        print("Unable to find jumpable position.")

    end

end

-- Create userspace commands.
vim.api.nvim_create_user_command('MagicBuild', process_build_script, { nargs='?' })
vim.api.nvim_create_user_command('MagicJump', process_jump_to, {})

-- Return our configuration.
return configuration

