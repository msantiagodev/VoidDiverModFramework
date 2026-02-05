local QUEST_ID = 890802
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_890802_START_TITLE> 해방의 목소리에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890802_1001>그 광신도 녀석들? 하핫, 기분 나쁜 놈들이지. 그놈들이 쓰는 주술은… 뭐랄까, 억지로 끼워 맞춘 퍼즐 같아. 조잡하고 위험해.")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2",	"<Key:LLoungeQ_890802_1002>고루한 말은 좋아하지 않지만 그렇게까지 순리를 거스르다 보면 결국 끝이 비참해지기 마련이거든. 웬만하면 관심 갖지 않는 게 좋아. 엮여서 좋을 게 단 하나도 없는 부류니까.")
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