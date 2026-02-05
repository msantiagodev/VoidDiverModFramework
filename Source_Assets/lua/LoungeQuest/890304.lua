local QUEST_ID = 890304
local START_NPC = "에블"
local START_TITLE = "<Key:LLoungeQ_890304_START_TITLE> 손님 상대 시 주의점"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890304_1001>가끔은 말을 걸고 싶어하는 분들이 있어요. 그럴 땐 절대 그분들의 이야기에 귀 기울이지 마세요. 어떤 분들은 자신의 불행이나 저주를 남에게 옮기고 싶어 하거든요.")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890304_1002>내 얘기 좀 들어볼래? 하면서 다가올 때, 호기심에 고개를 끄덕였다간 당신 마음에도 곰팡이가 피기 시작할 거예요. ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890304_1003>그냥 미소 지으면서 '죄송합니다'하고 딱 잘라 말하세요. 안 그러면 제가 빗자루를 휘둘러 강제로 쫓아내게 될지 몰라요.")
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