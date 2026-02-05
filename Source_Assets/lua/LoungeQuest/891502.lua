local QUEST_ID = 891502
local START_NPC = "핌핌"
local START_TITLE = "<Key:LLoungeQ_891502_START_TITLE> 유물상이 된 이유"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891502_1001>사연은 무슨. 늙은이가 먹고살 길이 이것밖에 더 있나? 10년 전 그 사달이 나고 나서, 멀쩡하던 직장도 집도 다 먼지가 됐지.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891502_1002>그런데 웃긴 게 뭔지 알아? 사람들이 살던 집이 무너진 자리에서 주워온 쓰레기들이 '유물'이라며 비싸게 팔리더란 말이지. 누군가의 비극이 누군가에겐 돈벌이가 되는 세상이야.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891502_1003>그래서 난 감상 같은 건 버렸어. 오직 돈만 믿기로 했지. 돈은 배신하지 않으니까.")
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