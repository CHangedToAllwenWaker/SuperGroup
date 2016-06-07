do

function run(msg, matches)
local reply_id = msg['174770816']
local text = 'Hi My Dad ❤'
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
