local QUEST_ID = 80101

-- 로컬 변수
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_80101_START_TITLE> 시작"
local START_PRIORITY = 1

function StartDialog()
	LuaApi:SetNpcNavigationActive(700000, false)

	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80101_1001>발루샤의 오픈 소식이 이제 막 도시에 퍼지고 있는 모양이에요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80101_1002>손님들 사이에 입소문이 퍼지고 본격적으로 의뢰가 들어오고 있네요. 판매할 물건도 잔뜩 구해둬야겠어요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80101_1003>그 말은 즉, 이제 할 일이 마구마구 생기고 있다는 이야기죠. 수행할 수 있는 의뢰 목록도 굉장히 길어졌어요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80101_1004>일단 제게서 캠페인 목록을 확인해 보시면 두 종류의 캠페인이 있을 거예요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80101_1005>판매용 물품을 구하기 위한 비교적 통상적으로 진행되는 의뢰는 일반 캠페인 카테고리와...")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80101_1006>그 외의 특별한 의뢰들이 있죠.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80101_1007>자, 설명은 이쯤하고, 이제부터는 주어지는 캠페인들을 팍팍 해결해서 가게를 번창시켜보죠!")

	await(LuaApi:CloseDialogAsync())
	

	SetLoungeQuestState(QUEST_ID, "Completed")
	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")	
end

function OnNotStarted()
	SetLoungeQuestState(QUEST_ID, "InProgress")

end

function OnInProgress()
	LuaApi:SetNpcNavigationActive(700000, true)
	AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)	
end

function OnNotCompleted()
end

function OnCompleted()
end