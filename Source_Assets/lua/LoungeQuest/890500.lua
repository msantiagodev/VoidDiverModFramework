local QUEST_ID = 890500
local START_NPC = "오너"
local START_TITLE = "<Key:LLoungeQ_890500_START_TITLE> 소개"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너",	"<Key:LLoungeQ_890500_1001>발루샤는 누구에게나 열려있지만, 아무나 머물 수 있는 곳은 아니죠.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너",	"<Key:LLoungeQ_890500_1002>당신이 이곳에서 무엇을 보고, 무엇을 가져올 수 있을지… 기대하고 있겠습니다.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너",	"<Key:LLoungeQ_890500_1003>명심하세요. 모든 것은 결정되어 있어요. 그리고, 아무것도 결정되어 있지 않죠.")
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