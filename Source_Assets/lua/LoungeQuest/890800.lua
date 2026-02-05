local QUEST_ID = 890800
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_890800_START_TITLE> 소개"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890800_1001>난 펠릭스. 발루샤에서는 다이버 코치로 일하고 있지.")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890800_1002>현장에서 몸 쓰는 것도 재밌지만 지금은 다이버들이 던전에서 제대로 힘을 쓸 수 있게 '길'을 닦아주는 일을 하고 있어. ")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890800_1003>다이버들이 가지고 있는 스킬을 세팅하거나 능력을 끌어올리는 특성을 활성화하고 싶다면 나를 찾아와. 있는 힘껏 도울 테니까.")
	await(LuaApi:CloseDialogAsync())
end

function OnNotStarted()
	AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)
end

function StartDialog()
	CommonDialog()
	SetLoungeQuestState(QUEST_ID, "InProgress")
end

function OnInProgress()
	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")
	AddLoungeDialog(START_NPC, QUEST_ID, "InProgressDialog", "InProgress", START_TITLE, START_PRIORITY)
end

function InProgressDialog()
	CommonDialog()
end