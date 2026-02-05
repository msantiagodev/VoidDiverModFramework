local QUEST_ID = 890303
local START_NPC = "에블"
local START_TITLE = "<Key:LLoungeQ_890303_START_TITLE> 손님에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890303_1001>몇몇 손님들에게는 아주 지독하고 끈적한 냄새가 나요. 여기 오시는 분들은 이미 '선'을 넘은 분들이 많거든요. ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890303_1002>귀신이 들려서 인격이 두세 개쯤 섞여 있는 분이나, 금기된 실험을 하다가 몸의 절반이 던전과 동화된 분들도 계세요. ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890303_1003>겉모습은 말끔한 정장을 입고 있어도, 그분들 그림자를 보면… 꿈틀거리고 있어요.")
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