local QUEST_ID = 890005
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_890005_START_TITLE> 긴급 송환에 실패하면?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890005_1001>최악의 경우, 다이버는 영원히 던전의 일부가 되겠죠. 하지만 걱정 마세요. 발루샤의 다이빙 부스는 업계 최고 성능을 자랑하니까요. ")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890005_1002>다이버의 바이탈 사인이 위험 수치에 도달하면 저절로 강제 송환 시스템이 작동하거든요. 물론… 그에 따른 막대한 위약금과 장비 손실 비용은 고스란히 적자로 돌아온다는 걸 잘 알고 계시겠지만요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", "<Key:LLoungeQ_890005_1003>그러니 부디, 조심해주세요. 인력 보충도 쉽지 않은 업계라고요.")
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