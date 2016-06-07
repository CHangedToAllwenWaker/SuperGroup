do

function run(msg, matches)
   send_document(get_receiver(msg), "./data/sticker/animation.gif.mp4", ok_cb, false)
end

return {
patterns = {
"^![Ff]ocus$",

},
run = run
}

end
