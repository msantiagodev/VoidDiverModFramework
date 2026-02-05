local QUEST_ID = 890300
local START_NPC = "에블"
local START_TITLE = "<Key:LLoungeQ_890300_START_TITLE> 소개"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890300_1001>안녕하세요, 에블린이라고 해요.")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890300_1002>던전에 다녀온 분들에게 남는 패러독스는 유용할 때도 있지만, 계속 쌓이면 매우 위험하죠. 저는 부정 패러독스를 정화하거나, 긍정 패러독스를 고정해 드려요 ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890300_1003>그러니 패러독스가 쌓였다면 주저 말고 제게 오세요 ")
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