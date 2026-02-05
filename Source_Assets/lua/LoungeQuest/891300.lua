local QUEST_ID = 891300
local START_NPC = "거울"
local START_TITLE = "<Key:LLoungeQ_891300_START_TITLE> 살펴 본다"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이",	"<Key:LLoungeQ_891300_1001>(거울에 비치는 것은 바라보는 자의 외면이 아닌 것 같다. 쉴 새 없이 움직이는 눈동자와 촉수들은 이 거울이 살아있는 무언가임을 증명하고 있다. 너무 오래 바라보지 않는 것이 좋겠다. 내가 아니게 될지도 모르니까.)")

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