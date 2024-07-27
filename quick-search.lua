local QUICK_SEARCH_HOTKEY_MODE = { "control", "cmd" };
local QUICK_SEARCH_MAP = {
  G = "https://www.google.com.hk/search?q=%s",
};


for searchKey in pairs(QUICK_SEARCH_MAP) do
  local searchURL = QUICK_SEARCH_MAP[searchKey];
  hs.hotkey.bind(QUICK_SEARCH_HOTKEY_MODE, searchKey, function()
    local clipText = hs.pasteboard.getContents();
    local url = string.format(searchURL, clipText);
    local command = string.format("open %s", url);
    hs.execute(command);
  end);
end