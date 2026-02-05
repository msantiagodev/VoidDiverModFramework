local QUEST_ID = 890200
local START_NPC = "안티"
local START_TITLE = "<Key:LLoungeQ_890200_START_TITLE> 살펴 본다."
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이",	"<Key:LLoungeQ_890200_1001>(녹슨 청동 톱니바퀴들이 맞물려 돌아가는 소리가 들린다. 끼릭, 끼릭… 규칙적인 듯하지만 가만히 듣고 있으면 묘하게 박자가 어긋나 있어 속이 울렁거린다.)")
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이",	"<Key:LLoungeQ_890200_1002>(이 기계는 어쩌면 어긋난 인과율을 계산하고 있을지도 모른다. 톱니 사이에 손가락을 넣었다간 과거의 어느 시점으로 빨려 들어갈 것만 같다.)")
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