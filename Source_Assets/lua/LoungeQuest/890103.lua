local QUEST_ID = 890103
local START_NPC = "루카"
local START_TITLE = "<Key:LLoungeQ_890103_START_TITLE> 공포 영화 좋아해?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890103_1001>공포 영화라… 혹시 스크린 속에서 가짜 피가 낭자하고, 뻔한 비명을 지르는 그런 장르를 말씀하시는 겁니까?")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890103_1002>후후, 글쎄요. 제겐 그건 '코미디'로 분류됩니다만. 진짜 공포는 연출되지 않습니다. ")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890103_1003>던전 속, 다이버의 끊어질 듯한 무전기 너머에서 들려오는 날것의 숨소리… 그게 진짜 명화죠. 원하신다면 제가 녹음해 둔 수집품을 좀 들려드릴까요?")
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