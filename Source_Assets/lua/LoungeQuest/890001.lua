local QUEST_ID = 890001
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_890001_START_TITLE> 10년 전 그날에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890001_1001>10년 전이요? 첫 기동일을 생일로 치자면 전 세 살인데요? 데이터를 기반으로 의견을 말씀드려볼까요?")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890001_1002>수치상으로는 물론 대재앙이었죠. 인명 피해 집계 불가, 재산 피해액 천문학적… 하지만 긍정적으로 생각해보세요! 그 덕분에 희귀한 유물들이 쏟아져 나왔고 거대한 시장이 열렸잖아요?")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890001_1003>저희 발루샤도 그 혼란을 틈타… 아니, 그 기회를 발판 삼아 설립되었고요. 비극은 안타깝지만, 경제적 관점에서는 초대형 호재였다고 볼 수 있겠네요.")
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