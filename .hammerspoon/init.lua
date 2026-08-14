hs = hs
-- Launch or Focus applications
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "J", function()
	hs.application.launchOrFocus("Wezterm")
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "K", function()
	hs.application.launchOrFocus("Brave Browser")
end)
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "L", function()
	hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "H", function()
	hs.application.launchOrFocus("Finder")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
-- Move and resize the focused window to the left half with full height
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  if win then local f = win:screen():frame() f.w = f.w / 2  -- Halve the width
    win:setFrame(f)
  end
end)
hs.hotkey.bind({"alt"}, "M", function()
    local savedPos = hs.mouse.absolutePosition()
    local screen = hs.mouse.getCurrentScreen():fullFrame()
    local topPos = { x = savedPos.x, y = screen.y + 1 }

    -- simulate a real mouse-moved event at the top edge
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, topPos):post()

    -- move the cursor back shortly after, so it doesn't feel like a jump
    hs.timer.doAfter(0.05, function()
        hs.mouse.absolutePosition(savedPos)
    end)
end)

-- Reload config
hs.hotkey.bind({ "alt" }, "R", function()
	hs.reload()
end)
hs.alert.show("Config loaded")
