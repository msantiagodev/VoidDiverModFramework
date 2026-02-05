local QUEST_ID = 890400
local START_NPC = "쇼파"
local START_TITLE = "<Key:LLoungeQ_890400_START_TITLE> 살펴 본다"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이",	"<Key:LLoungeQ_890400_1001>(고양이의 발톱에 당했는지 이곳저곳 튿어지고 해진 소파이다. 검은 쿠션은 상당히 안락해보이지만 그렇다고 너무 방심할 것은 아닌 것 같다. 넋 놓고 쉬었다가는 쥐도 새도 모르게 삼켜질지도 모른다. 모든 걸 내려놓고 영원히 잠들고 싶다면 이 이상의 선택지는 없을지도…)")
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