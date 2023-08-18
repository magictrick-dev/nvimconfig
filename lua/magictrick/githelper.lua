
-- A simple git committer.
local function process_git_commit(opts)

    if opts.fargs == nil or opts.fargs[1] == nil then
        print("Commit message is required.")
    end

    local command_git_add = ":!git add ."
    local command_git_commit = ":!git commit -m " .. opts.fargs[1]
    local command_git_push = ":!git push"

    vim.cmd(command_git_add)
    vim.cmd(command_git_commit)
    vim.cmd(command_git_push)

    print("Git push complete.")

end

-- Explose the commands for the users.
vim.api.nvim_create_user_command('MagicGitCommit', process_git_commit, { nargs = 1 })

