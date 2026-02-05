local QUEST_ID = 890600
local START_NPC = "에드"
local START_TITLE = "<Key:LLoungeQ_890600_START_TITLE> 소개"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "에드2", "De", "비움", "De", "에드2",	"<Key:LLoungeQ_890600_1001>물건을… 여기에… 두… 세요… 제가… 겹쳐진… 공간… 너머로… 안전하게… 보관해… 드릴게요…")
	MDSay("비움", "De", "에드2", "De", "비움", "De", "에드2",	"<Key:LLoungeQ_890600_1002>제… 가방은… 안이… 없어서… 아무리… 많이… 넣어도… 괜찮… 거든요… ")
	MDSay("비움", "De", "에드2", "De", "비움", "De", "에드2",	"<Key:LLoungeQ_890600_1003>아이템이… 넘치… 면… 언제든… 저를… 찾아… 주세요… 흐히히…")
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