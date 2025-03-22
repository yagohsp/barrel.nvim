local Y = {}

Y.barrel = function()
    require("mini.files")
    local path = (MiniFiles.get_fs_entry() or {}).path
    local dir = vim.fs.dirname(path)

    local filepath = dir .. "/index.ts"
    local file = io.open(filepath, "w+")

    local files = vim.system({ "ls", dir }):wait()
    if file then
        for i_file in files.stdout:gmatch("%S+%.ts") do
            if i_file ~= "index.ts" then
                file:write('export * from ' .. '"./' .. string.sub(i_file, 1, -4) .. '"\n')
            end
        end
        MiniFiles.synchronize()
    end


    io.close(file)
end

vim.api.nvim_create_user_command("Barrel", Y.barrel, {})

return Y
