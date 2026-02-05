local QUEST_ID = 81103
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_81103_START_TITLE> Title"
local START_PRIORITY = 1
local COMPLETE_NPC = "엘라"
local COMPLETE_TITLE = "<Key:LLoungeQ_81103_COMPLETE_TITLE> Title"
local COMPLETE_PRIORITY = 1

-- 대화 함수
function StartDialog()
	await(LuaApi.OpenDialogAsync())
	MDSay("비움", "De", START_NPC, "Sm", "비움", "De", START_NPC, "<Key:LLoungeQ_error>이 대화가 나타나면 오류입니다.")
	await(LuaApi.CloseDialogAsync())
end

function CompleteDialog()
	await(LuaApi.OpenDialogAsync())
	MDSay("비움", "De", START_NPC, "Sm", "비움", "De", START_NPC, "<Key:LLoungeQ_error>이 대화가 나타나면 오류입니다.")
	await(LuaApi.CloseDialogAsync())
end

-- lounge quest의 상태 콜백
function OnNotStarted()
	SetLoungeQuestState(QUEST_ID, "InProgress")	
end

function OnInProgress()
end

function OnNotCompleted()
	SetLoungeQuestState(QUEST_ID, "Completed")
	
end

function OnCompleted()
end