local QUEST_ID = 890002
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_890002_START_TITLE> 정체가 뭐야?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890002_1001>제 정체요? 음… 발루샤를 위해 특별히 설계된 고성능 인공지능이라고만 말씀드릴게요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890002_1002>하지만 단순한 기계는 아니랍니다. 10년 전 사태 때 발생한 방대한 데이터 파편들… 어쩌면 그것들이 제 의식의 기반일지도 모르죠.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890002_1003>그래서인지 가끔은 시스템 코드보다 사람들의 감정이 더 읽기 쉬울 때가 있어요. 신기하죠?")
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