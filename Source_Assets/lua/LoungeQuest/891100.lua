local QUEST_ID = 891100
local START_NPC = "부엉"
local START_TITLE = "<Key:LLoungeQ_891100_START_TITLE> 살펴 본다"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이",	"<Key:LLoungeQ_891100_1001>(뭔가 지루해 보이는 부엉이다. 아니면 졸린 건가? 푸르릉, 푸르릉하는 작은 숨소리가 들려온다. 목에는 자줏빛 고급스러운 목걸이를 걸고 있는데, 자세히는 들여다보지 않는 게 좋겠다. 영롱한 빛깔에 홀려버릴 것 같은 이상한 기분이 든다.)")

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