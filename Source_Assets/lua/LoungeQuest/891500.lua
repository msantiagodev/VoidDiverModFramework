local QUEST_ID = 891500
local START_NPC = "핌핌"
local START_TITLE = "<Key:LLoungeQ_891500_START_TITLE> 소개"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891500_1001>던전에서 주워온 유물이 있다면 전부 나한테 가져오게. 쓰레기 같은 고철이든, 반짝이는 보석이든 상관없어. 난 종류를 가리지 않고 유물이라면 전부 매입하니까. ")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891500_1002>감정가는 시장가보다 짜겠지만, 이 바닥에서 나만큼 확실하게 현금을 쥐여주는 사람도 없다는 걸 명심하게.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891500_1003>가져간 물건은 어떻게 처분하느냐고? 그게 중요한가?")
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