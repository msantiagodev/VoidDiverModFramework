local QUEST_ID = 890003
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_890003_START_TITLE> 오너님은 어떤 분이지?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890003_1001>오너님은… 이 도시의 그림자 같은 분이세요. 10년 전 사태 이전부터 이곳에 계셨고, 모든 것이 무너진 후에도 변함없이 자리를 지키고 계시죠. ")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890003_1002>발루샤를 통해 이루고자 하는 거대한 목표가 있으신 것 같지만, 저에게도 모든 걸 알려주시진 않아요. ")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890003_1003>이곳의 다른분들도 모두 선택된 데에 분명 특별한 뜻이 있을 거예요. 그러니 의심보다는 신뢰를 가지시는 게 정신 건강에 좋답니다.")
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