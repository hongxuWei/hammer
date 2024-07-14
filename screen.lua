-- 屏幕快捷键
local SCREEN_HOTKEY_BIND_MODS = { "cmd", "shift" };

-- 快捷键对应的屏幕布局信息
local SCREEN_KEY_MAP = {
  -- half-left
  LEFT = { x = 0, y = 0, w = 1/2, h = 1 },
  -- half-right
  RIGHT = { x = 1/2, y = 0, w = 1/2, h = 1 },
  -- half-top
  UP = { x = 0, y = 0, w = 1, h = 1/2 },
  -- half-bottom
  DOWN = { x = 0, y = 1/2, w = 1, h = 1/2 },
  -- top-left
  I = { x = 0, y = 0, w = 1/2, h = 1/2 },
  -- top-right
  O = { x = 1/2, y = 0, w = 1/2, h = 1/2 },
  -- bottom-left
  K = { x = 0, y = 1/2, w = 1/2, h = 1/2 },
  -- bottom-right
  L = { x = 1/2, y = 1/2, w = 1/2, h = 1/2 },
  -- 1/3-left
  [","] = { x = 0, y = 0, w = 1/3, h = 1 },
  -- 2/3-left
  [";"] = { x = 0, y = 0, w = 2/3, h = 1 },
  -- 1/3-middle
  ["."] = { x = 1/3, y = 0, w = 1/3, h = 1 },
  -- 1/3-right
  ["/"] = { x = 2/3, y = 0, w = 1/3, h = 1 },
  -- 2/3-right
  ["'"] = { x = 1/3, y = 0, w = 2/3, h = 1 },
};

-- 快速布局 1/2, 1/3, 2/3, 1/4 屏幕
function resizeAppWindow()
  for screenKey in pairs(SCREEN_KEY_MAP) do
    local resizeInfo = SCREEN_KEY_MAP[screenKey];
    hs.hotkey.bind(SCREEN_HOTKEY_BIND_MODS, screenKey, function()
      local currentWindow = hs.window.focusedWindow();
      -- 如果当前屏幕是全屏则退出全屏
      if currentWindow:isFullScreen() then
        currentWindow:setFullScreen(false)
      end


      if currentWindow then
        -- 获取焦点窗口所在的屏幕
        local newFrame = currentWindow:frame();
        local currentScreenFrame = currentWindow:screen():frame()
        -- 处理屏幕信息，x,y 坐标以当面前屏幕 x,y 为起点 否则多屏幕时无法处理
        newFrame.x = currentScreenFrame.x + (resizeInfo.x * currentScreenFrame.w);
        newFrame.y = currentScreenFrame.y + (resizeInfo.y * currentScreenFrame.h);
        -- 宽高以当前屏幕宽高分割
        newFrame.w = resizeInfo.w * currentScreenFrame.w;
        newFrame.h = resizeInfo.h * currentScreenFrame.h;
        currentWindow:setFrame(newFrame);
      end
    end);
  end
end

-- 切换全屏
function toggleAppFullScreen()
  hs.hotkey.bind(SCREEN_HOTKEY_BIND_MODS, "F", function()
    local window = hs.window.focusedWindow();
    if window then
    window:toggleFullScreen() -- 退出全屏
    end
  end)
end

resizeAppWindow();
toggleAppFullScreen();
