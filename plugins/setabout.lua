local function run(msg, matches,success)

local about = matches[2]
local chat = 'channel#id'..msg.to.id
        if msg.to.type == 'channel' and matches[1] == 'setabout' then
        local about = matches[2]
        channel_set_about(chat, about, ok_cb, false)
        return 'Done!\nTop Chat To See About ✏'
    end
end

  return {
    patterns = {
      "^[!/#](setabout) (.+)$",
    }, 
    run = run 
  }
