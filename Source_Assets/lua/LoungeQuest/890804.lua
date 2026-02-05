local QUEST_ID = 890804
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_890804_START_TITLE> 손님 응대 시 주의점"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890804_1001>거래 외에는 아무것도 하지 마. 호의로 건네는 물건을 받는다거나, 개인 연락처를 알려준다거나, 특히 가게 밖에서 만나거나 하는 건 큰 문제가 될 수 있어. ")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890804_1002>무해한 자들도 물론 있지. 하지만 어떤 이들의 경우는 숨 쉬는 것조차 주술의 일환이거든. 아무 생각 없이 받은 동전 하나가 영혼을 저당 잡는 계약서가 될 수도 있어. ")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890804_1003> 명심해. 여기선 거래 외에는 그 어떤 인연도 만들지 않는 거야.")
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