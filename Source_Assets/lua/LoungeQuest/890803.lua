local QUEST_ID = 890803
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_890803_START_TITLE> 손님들의 정체"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890803_1001>정체? 함부로 알려고 하지 마. 여기 오는 사람들은 '취미'로 오컬트를 파는 수준이 아니야. ")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890803_1002>어제 다녀간 노부인 봤어? 남미 쪽에서 온 부두술 대모야. 그 옆에 있던 남자는 동남아 쪽 주술사고. 다들 각자 구역에서 신이나 악마 좀 부린다는 '진짜배기'들이지.")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890803_1003>여기 물건이 아니면 그들의 '영적인 갈증'을 채울 수 없으니까 위험을 무릅쓰고 오는 거야.")
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