local QUEST_ID = 890000
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_890000_START_TITLE> 소개"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi.OpenDialogAsync())
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890000_0001>저는 발루샤의 운영을 보조하는 AI 비서, 엘라라예요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890000_0002>발루샤의 모든 업무를 보조하지만 가장 주된 업무는 의뢰 관리죠. 모든 의뢰는 저를 통해 확인하실 수 있어요.")
	await(LuaApi.CloseDialogAsync())
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