local QUEST_ID = 890501
local START_NPC = "오너"
local START_TITLE = "<Key:LLoungeQ_890501_START_TITLE> 10년 전의 그 날에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너",	"<Key:LLoungeQ_890501_1001>많은 이들에게 그날은 종말과도 같았어요. 도시는 반으로 쪼개졌고, 수많은 인연이 심연 속으로 사라졌으니까요. 하지만요, 모든 끝은 새로운 시작을 의미하기도 한답니다.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너",	"<Key:LLoungeQ_890501_1002>던전이 열리지 않았다면 발루샤도 없었을 테고, 우리가 이렇게 마주 보고 이야기를 나눌 일도 없었겠죠.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너",	"<Key:LLoungeQ_890501_1003>그러니 너무 슬퍼하지 말아요. 그날의 비극이 우리를 이곳으로 이끌었으니… 어쩌면 그건 필연이었을지도 몰라요.")
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