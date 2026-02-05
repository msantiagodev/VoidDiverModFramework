local QUEST_ID = 890601
local START_NPC = "에드"
local START_TITLE = "<Key:LLoungeQ_890601_START_TITLE> 10년 전 사태에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "에드2", "De", "비움", "De", "에드2",	"<Key:LLoungeQ_890601_1001>그날은… 부서진… 게… 아니에요… 그냥… 종이가… 접힌… 거예요…")
	MDSay("비움", "De", "에드2", "De", "비움", "De", "에드2",	"<Key:LLoungeQ_890601_1002>이쪽… 세상과… 저쪽… 세상이… 너무… 세게… 부딪혀서… 잉크가… 번진… 것뿐이에요… 사람들은… 구멍이… 뚫렸다고… 무서워하지만… 저는… 문이… 생긴 거라고… 생각해요…")
	MDSay("비움", "De", "에드2", "De", "비움", "De", "에드2",	"<Key:LLoungeQ_890601_1003>다만… 문을… 열 때… 너무… 시끄러웠던… 건… 미안해요… 저쪽… 친구들이… 많이… 배가… 고팠거든요… 꼬르륵…")
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