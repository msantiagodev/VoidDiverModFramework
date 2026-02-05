local QUEST_ID = 890004
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_890004_START_TITLE> 단속 나오면 어쩌지?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890004_1001>걱정 마세요. 저희는 표면적으로 아주 성실한 납세자니까요. 던전 관리실 측에서도 저희 활동을 굳이 막으려 들지 않고요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890004_1002>오히려 그들이 직접 하기 껄끄러운 일들을 종종 의뢰해 올 거예요. 일종의 공생 관계죠. 만약 정말로 성가신 일이 생긴다면… 오너님께서 미리 준비해두신 '긴급 대처 프로토콜 C'를 가동하면 돼요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890004_1003>그게 뭐냐고요? 음… 가게 문닫고 장기 여행이나 다녀오는 거죠, 뭐.")
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