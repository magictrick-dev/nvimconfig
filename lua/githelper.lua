
local function process_git_commit(message)

    if not message or message == "" then
        message = "Not commit message provided."
    end

    local command_git_add = ":!git add ."
    local command_git_commit = ":!git commit -m " .. message
    local command_git_push = ":!git push"

    vim.cmd(command_git_add)
    vim.cmd(command_git_commit)
    vim.cmd(command_git_push)

    print("Git push complete.")

end

return {
    git_committer = process_git_commit
}
