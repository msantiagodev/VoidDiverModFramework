local QUEST_ID = 890102
local START_NPC = "루카"
local START_TITLE = "<Key:LLoungeQ_890102_START_TITLE> 옷차림에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890102_1001>제 복장이 신경 쓰이십니까? 이건 제 나름의… 방호복이자 예복입니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890102_1002>이 세상은 너무 평범하고 지루한 공기로 가득 차 있거든요. 저는 이 헬멧을 통해 저만의 필터로 세상을 호흡합니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890102_1003>외투는 언제든 튀는 피를 가려줄 수 있는 짙은 색, 그리고 수집품을 담을 넉넉한 주머니. 신사에게 이보다 완벽한 실용성은 없죠. ")
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