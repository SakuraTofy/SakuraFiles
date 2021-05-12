local function AutoFile(msg)
local text = msg.content_.text_
if Sudo(msg) then
if text == 'تفعيل النسخه التلقائيه' or text == 'تفعيل جلب نسخه الكروبات' or text == 'تفعيل عمل نسخه للمجموعات' then   
Dev_Abs(msg.chat_id_,msg.id_, 1, "⌔︙تم تفعيل جلب نسخة الكروبات التلقائيه\n⌔︙سيتم ارسال نسخه تلقائيه للكروبات كل يوم الى خاص المطور الاساسي", 1, 'md')
DevSakura:del(SAKURA.."Sakura:Lock:AutoFile")
end
if text == 'تعطيل النسخه التلقائيه' or text == 'تعطيل جلب نسخه الكروبات' or text == 'تعطيل عمل نسخه للمجموعات' then  
Dev_Abs(msg.chat_id_,msg.id_, 1, "⌔︙تم تعطيل جلب نسخة الكروبات التلقائيه", 1, 'md')
DevSakura:set(SAKURA.."Sakura:Lock:AutoFile",true) 
end 
end

if (text and not DevSakura:get(SAKURA.."Sakura:Lock:AutoFile")) then
Time = DevSakura:get(SAKURA.."Sakura:AutoFile:Time")
if Time then 
if Time ~= os.date("%x") then 
local list = DevSakura:smembers(SAKURA..'Sakura:Groups') 
local BotName = (DevSakura:get(SAKURA.."Sakura:NameBot") or 'بروكس')
local GetJson = '{"BotId": '..SAKURA..',"BotName": "'..BotName..'","GroupsList":{'  
for k,v in pairs(list) do 
LinkGroups = DevSakura:get(SAKURA.."Sakura:Groups:Links"..v)
Welcomes = DevSakura:get(SAKURA..'Sakura:Groups:Welcomes'..v) or ''
AbsConstructors = DevSakura:smembers(SAKURA..'Sakura:AbsConstructor:'..v)
BasicConstructors = DevSakura:smembers(SAKURA..'Sakura:BasicConstructor:'..v)
Constructors = DevSakura:smembers(SAKURA..'Sakura:Constructor:'..v)
Managers = DevSakura:smembers(SAKURA..'Sakura:Managers:'..v)
Admis = DevSakura:smembers(SAKURA..'Sakura:Admins:'..v)
Vips = DevSakura:smembers(SAKURA..'Sakura:VipMem:'..v)
if k == 1 then
GetJson = GetJson..'"'..v..'":{'
else
GetJson = GetJson..',"'..v..'":{'
end
if #Vips ~= 0 then 
GetJson = GetJson..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Admis ~= 0 then
GetJson = GetJson..'"Admis":['
for k,v in pairs(Admis) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Managers ~= 0 then
GetJson = GetJson..'"Managers":['
for k,v in pairs(Managers) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Constructors ~= 0 then
GetJson = GetJson..'"Constructors":['
for k,v in pairs(Constructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #BasicConstructors ~= 0 then
GetJson = GetJson..'"BasicConstructors":['
for k,v in pairs(BasicConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #AbsConstructors ~= 0 then
GetJson = GetJson..'"AbsConstructors":['
for k,v in pairs(AbsConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if LinkGroups then
GetJson = GetJson..'"LinkGroups":"'..LinkGroups..'",'
end
GetJson = GetJson..'"Welcomes":"'..Welcomes..'"}'
end
GetJson = GetJson..'}}'
local File = io.open('./'..SAKURA..'.json', "w")
File:write(GetJson)
File:close()
local abbas = 'https://api.telegram.org/bot' .. TokenBot .. '/sendDocument'
local curl = 'curl "' .. abbas .. '" -F "chat_id='..DevId..'" -F "document=@'..SAKURA..'.json' .. '" -F "caption=⌔︙يحتوي الملف على ↫ '..#list..' مجموعه"'
io.popen(curl)
io.popen('fm -fr '..SAKURA..'.json')
DevSakura:set(SAKURA.."Sakura:AutoFile:Time",os.date("%x"))
end
else 
DevSakura:set(SAKURA.."Sakura:AutoFile:Time",os.date("%x"))
end
end

end
return {
SAKURA = AutoFile
}