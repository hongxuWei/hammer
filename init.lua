-- 尝试打开文件以检查它是否存在
local PRIVATE = "private.lua"
local file = io.open(PRIVATE, "r")

if file then
    -- 如果文件存在，使用 dofile 加载并执行它
    dofile(PRIVATE)
    -- 关闭文件
    file:close()
end

require('reload-config');
require("screen");
