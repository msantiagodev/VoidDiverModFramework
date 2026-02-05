local QUEST_ID = 891501
local START_NPC = "핌핌"
local START_TITLE = "<Key:LLoungeQ_891501_START_TITLE> 10년 전 사태에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891501_1001>…그날 이야기라면 묻지 마. 기억하고 싶지 않으니까. 그 지옥도에서 내가 뭘 잃어버렸는지 자네가 알아봤자 무슨 소용이겠나. ")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891501_1002>누구나 멈춰버린 시간 하나쯤은 품고 사는 법이야. 늙은이의 수다를 들을 시간 있으면 가서 돈 되는 물건이나 하나 더 주워와. 그게 서로에게 이득일 테니까.")
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