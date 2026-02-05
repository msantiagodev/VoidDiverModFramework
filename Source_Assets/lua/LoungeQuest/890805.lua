local QUEST_ID = 890805
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_890805_START_TITLE> 단속이 나오면?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890805_1001>그건 위에서 다 알아서 할 테니 너무 걱정하지 마. 어차피 우리쯤 되면 경찰이 들이닥칠 일은 없고 온다면 던전관리실인데…")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890805_1002>의뢰를 해오면 해왔지 영업에 딴지를 걸지는 않을걸. 물론 음… 만만한 일을 맡길 리는 없으니 곤란하긴 마찬가지일 수 있겠다.")
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