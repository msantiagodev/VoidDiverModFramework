local QUEST_ID = 890104
local START_NPC = "루카"
local START_TITLE = "<Key:LLoungeQ_890104_START_TITLE> 도시 분위기는 좀 어때? "
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890104_1001>언제나처럼 부산스럽고도 활기차지요. 도시 한가운데 뚫린 그 거대한 싱크홀이 이제는 이 도시의 랜드마크가 됐으니까요.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890104_1002>지상의 사람들은 매일같이 들여다보이는 저 거대한 구덩이 안쪽에 식인 괴물이 사는데도, 싱크홀 뷰가 보이는 테라스 카페에서 커피를 마시며 '오늘의 던전 뉴스'를 예능처럼 소비합니다. ")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890104_1003>장벽이요? 그건 그냥 장식이죠. 사람들은 장벽 너머의 심연보다, 당장 내일의 주가 폭락을 더 무서워하거든요. 미친 건 던전 안일까요, 아니면 밖일까요? ")
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