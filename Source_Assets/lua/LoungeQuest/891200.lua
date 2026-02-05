local QUEST_ID = 891200
local START_NPC = "게이"
local START_TITLE = "<Key:LLoungeQ_891200_START_TITLE> 살펴 본다"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이",	"<Key:LLoungeQ_891200_1001>(목재와 유리, 지저분한 전선, 진공관으로 만들어진 아주 오래되어 보이는 기계. 들썩들썩거리는 움직임을 보면 기계라기보다는 살아있는 무언가를 보고 있는 것 같은 기분이 든다. 레버를 당기면 대체 무슨 일이 벌어지는 걸까? 호기심이 동하지만 역시 섣불리 건드리지 않는 것이 좋겠다.)")

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