local QUEST_ID = 891400
local START_NPC = "더스"
local START_TITLE = "<Key:LLoungeQ_891400_START_TITLE> 살펴 본다"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이",	"<Key:LLoungeQ_891400_1001>(진득한 액체가 흘러나오는 기괴한 느낌의 우편함이다. 우편물을 꺼내려면 내부로 손을 넣어야할 텐데 왠지 모르게 꺼림칙하다. 콱! 하고 물어버리는 것은 아니겠지?)")

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