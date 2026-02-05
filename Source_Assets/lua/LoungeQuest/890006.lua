local QUEST_ID = 890006
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_890006_START_TITLE> 손님들은 위험한 사람 같아."
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890006_1001>데이터베이스 조회 결과, 방문객의 87%가 인터폴 적색수배자 혹은 각국 정보기관의 요주의 인물입니다.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890006_1002>하지만 역설적으로 그렇기 때문에 발루샤는 안전합니다. 이곳은 그들에게 일종의 중립 지대거든요. 서로 죽이고 싶어도 여기선 참아야 하죠. 물건이 필요하니까요. 우리는 그 중립을 지키는 중개자 역할만 하시면 됩니다.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890006_1003>어느 한쪽 편을 들지 마세요. 균형이 무너지는 순간, 이곳은 전쟁터가 될 테니까요.")
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