local QUEST_ID = 890100
local START_NPC = "루카"
local START_TITLE = "<Key:LLoungeQ_890100_START_TITLE> 소개"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890100_1001>반갑습니다, 루카스라고 합니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890100_1002>저는 현장에서 필요한 각종 소모품을 보급합니다. 약품, 재료, 그 외에 목숨을 부지해 줄 도구들이 필요하다면 제게 오십시오. ")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890100_1003>물론 공짜는 아닙니다. 예? 상품의 출처는… 모르시는 게 좋을 것 같군요. ")
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