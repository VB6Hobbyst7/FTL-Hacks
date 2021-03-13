PROCESS_NAME = 'FTLGame.exe'
--------
-------- Auto Attach
--------
local autoAttachTimer = nil ---- variable to hold timer object
local autoAttachTimerInterval = 1000 ---- Timer intervals are in milliseconds
local autoAttachTimerTicks = 0 ---- variable to count number of times the timer has run
local autoAttachTimerTickMax = 5000 ---- Set to zero to disable ticks max
local function autoAttachTimer_tick(timer) ---- Timer tick call back
        ---- Destroy timer if max ticks is reached
	if autoAttachTimerTickMax > 0 and autoAttachTimerTicks >= autoAttachTimerTickMax then
		timer.destroy()
	end
        ---- Check if process is running
	if getProcessIDFromProcessName(PROCESS_NAME) ~= nil then
		timer.destroy() ---- Destroy timer
		openProcess(PROCESS_NAME) ---- Open the process
	end
	autoAttachTimerTicks = autoAttachTimerTicks + 1 ---- Increase ticks
end
autoAttachTimer = createTimer(getMainForm()) ---- Create timer with the main form as it's parent
autoAttachTimer.Interval = autoAttachTimerInterval ---- Set timer interval
autoAttachTimer.OnTimer = autoAttachTimer_tick ---- Set timer tick call back

if mainForm then mainForm.destroy() end

mainForm = createForm()
mainForm.Caption = "FTL Scrap Trainer"
mainForm.Position = "poScreenCenter"
mainForm.BorderStyle = "bsToolWindow"

cheat = createCheckBox(mainForm)
cheat.Left = 10
cheat.Top = 20
cheat.Caption = "Infinite Scrap"
cheat.OnChange = function()
local addressList = getAddressList()
local MaxScrap = addressList.getMemoryRecordByDescription('MaxScrap')

if cheat.Checked == true then
MaxScrap.Active = true
else
MaxScrap.Active = false
end

end

