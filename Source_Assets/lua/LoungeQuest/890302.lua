local QUEST_ID = 890302
local START_NPC = "에블"
local START_TITLE = "<Key:LLoungeQ_890302_START_TITLE> 인생 음식이 뭐야?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890302_1001>제 인생 음식은… 음, 고르기 어렵지만… '갓 잡은 미믹의 혓바닥 젤리'였어요! ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890302_1002>겉은 쫄깃한데 씹으면 톡 하고 차가운 점액이 터져 나오거든요. 레몬즙을 살짝 뿌리면 보라색으로 변하는데 그게 얼마나 예쁜지 몰라요.  ")
	MDSay("비움", "De", "에블2", "De", "비움", "De", "에블2",	"<Key:LLoungeQ_890302_1003>아, 표정이 왜 그러세요? 던전 식재료는 패러독스만 잘 제거하면 훌륭한 영양 공급원이라고요. 나중에 한번 만들어 드릴까요? ")
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