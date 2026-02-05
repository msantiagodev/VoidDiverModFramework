local QUEST_ID = 890301
local START_NPC = "에블"
local START_TITLE = "<Key:LLoungeQ_890301_START_TITLE> 10년 전 사태에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890301_1001>10년 전이요? 음… 전 그때 아주 어렸지만, 기억나요. 하늘이 찢어지던 날이었죠. 사람들은 무서워서 도망쳤지만, 전 창문 밖을 계속 보고 있었어요. ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890301_1002>붉은색, 검은색, 보라색… 세상의 색깔이 뒤섞이는 게 마치 거대한 물감 통을 엎지른 것처럼 보였거든요. ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890301_1003>그때부터였나 봐요. 제가 뒤틀린 것들에게서 아름다움을 찾게 된 게. 이상한가요? ")
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