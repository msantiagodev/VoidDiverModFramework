local QUEST_ID = 890801
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_890801_START_TITLE> 10년 전 사태에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890801_1001>10년 전이라… 아직도 생생해. 관측기 바늘이 미친 듯이 돌아가다가 터져버리는 걸 내 눈으로 봤지.")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890801_1002>영적인 감이 없는 사람이라도 누구라도 느낄 수 있었을 거야. 세상이 무너진다는 게 어떤 느낌인지 말이야.")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890801_1003>그날 이후로 세상의 규칙이 뒤틀려버렸지. 지금도 그 뒤틀림은 현재진행형이야. 우리가 할 일은 그 혼돈 속에서 길을 찾는 거고.")
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