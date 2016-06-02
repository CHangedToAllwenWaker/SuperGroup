local function run(msg, matches)
 if matches[1]:lower() == "ip" then
  local data = http.request("http://ip-api.com/json/"..URL.escape(matches[2]).."?fields=262143")
  local jdat = JSON.decode(data)
  if jdat.status == "success" then
   local text = "ℹ️ مشخصات آیپی :\n"
   .."🗺 کشور : "..jdat.country.." - "..jdat.countryCode.."\n"
   .."🏡 استان : "..jdat.regionName.."\n"
   .."🏚 شهر : "..jdat.city.."\n"
   .."🔢 زیپ کد : "..(jdat.zip or "یافت نشد").."\n"
   .."⏰ منطقه زمانی : "..jdat.timezone.."\n"
   .."📡 مختصات : "..jdat.lat..","..jdat.lon.."\n"
   .."🌐 گوگل مپ :\nhttps://www.google.com/maps/place/"..jdat.lat..","..jdat.lon.."\n"
   .."📱 شماره موبایل : "..(jdat.mobile or "در دسترس نیست").."\n"
   .."🌀 پراکسی : "..(jdat.proxy or "در دسترس نیست").."\n"
   .."💻 آی پی : "..jdat.query.."\n"
   .."🛃 سازمان : "..jdat.org.."\n"
   send_location(get_receiver(msg), jdat.lat, jdat.lon, ok_cb, false)
   return text
  else
   return "مقدار وارد شد صحیح نیست"
  end
 elseif matches[1]:lower() == "ping" then
  if matches[2] == "." then
   return "64 bytes from 212.33.207.97: icmp_seq=1 ttl=48 time=107 ms"
  else
   local cmd = io.popen("ping -c1 "..matches[2]):read('*all')
   if cmd == nil or cmd == "" or not cmd then
    return "مقدار وارد شد صحیح نیست"
   else
    local char1 = cmd:find('data.')+5
    local char2 = cmd:find('\n\n')
    local text = cmd:sub(char1, char2)
    local text = text:gsub(": ", "\n")
    return text
   end
  end
 elseif matches[1]:lower() == "whois" then
  return io.popen("whois "..matches[2]):read('*all')
 elseif matches[1]:lower() == "ip" then
  return ""
 elseif matches[1]:lower() == "getip" then
  if not matches[2] then
   return ''
  else
   local getip = http.request("http://umbrella.shayan-soft.ir/get/umbrella"..matches[2]..".config")
   if getip == "not found" then
    return "توکن وارد شده صحیح نیست"
   else
    return "آی پی شخص مورد نظر:\n"..getip
   end
  end
 end
end

return {
 description = "IP and URL Information", 
 usagehtm = '<tr><td align="center">ip</td><td align="right">لینکی در اختیارتان قرار میدهد که با ورود به آن میتوانید آی پی خود را مشاهده کنید</td></tr>'
 ..'<tr><td align="center">getip</td><td align="right">لینک ارائه شده را به شخص مورد نظر بدهید و از آن توکنی که سایت به او میدهد را بخواهید. اگر آن توکن را با یک فاصله بعد از همین دستور وارد کنید، آی پی شخص مورد نظر نمایش داده میشد<br>http://umbrella.shayan-soft.ir/get</td></tr>'
 ..'<tr><td align="center">config آی پی یا لینک</td><td align="right">اطلاعاتی کلی راجع به آن لینک یا آی پی در اختیارتان قرار میدهد. دقت کنید لینک بدون اچ تی تی پی وارد شود</td></tr>'
 ..'<tr><td align="center">ping  آی پی یا لینک</td><td align="right">از سرور با پورت های مختلف پینگ میگیرد. دقت کنید لینک بدون اچ تی تی پی وارد شود</td></tr>'
 ..'<tr><td align="center">whois لینک</td><td align="right">یک دامین را بررسی میکند و در صورتی که قبلا به ثبت رسیده باشد، مشخصات ثبت کننده را به اطلاع شما میرسان. دقت کنید لینک بدون اچ تی تی پی وارد شود</td></tr>',
 usage = {
  "ip : آي پي شما",
 },
 patterns = {
  "^[!/#]([Ii][Pp]) (.*)$",
 }, 
 run = run
}
