do

function run(msg, matches)
local reply_id = msg['105831687']
local text = 'سلام بابایی جونم 😍'
if matches[1] == 'Slm' then
    if is_sudo(msg) then
reply_msg(reply_id, text, ok_cb, false)
end
end 
end
return {
patterns = {
    "^Slm$",
},
run = run
}

end
