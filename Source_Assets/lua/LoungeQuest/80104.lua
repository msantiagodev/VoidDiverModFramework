local QUEST_ID = 80104

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "오너"
local START_TITLE = "<Key:LLoungeQ_80104_START_TITLE> 시작"
local START_PRIORITY = 1

function OnInProgressDialog()
	await(LuaApi:OpenDialogAsync(0)) -- 다이얼로그 창 열기

	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80104_1001>이야기는 들었어요. 의뢰인이 직접 찾아왔었다고요?")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80104_1002>네, 그게… 관련해서 상의드릴 일이 있습니다.")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80104_1003>받으세요, 의뢰인 아서 앨런에 대한 자료, 그리고 해방의 목소리에 대한 추가 자료에요.")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80104_1004>이건… 알고 계셨군요?")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80104_1005>고민이 많겠죠. 가게의 발전과 다이버의 생명이라는 리스크. 둘을 저울질하는 게 쉽지 않을 거예요.")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80104_1006>하지만 저는 단지 오너일 뿐. 점장은 어디까지나 당신이에요. 그러니 선택은 온전히 당신에게 맡기겠어요.")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80104_1007>…알겠습니다.")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80104_1008>너무 걱정하지 말아요. 당신은 잘 해낼 테니까.")	
		
	await(LuaApi:CloseDialogAsync()) -- 다이얼로그 창 닫기
	SetLoungeQuestState(QUEST_ID, "Completed")
end

-- 상태 콜백
function OnNotStarted() -- 조건을 만족해서 시작가능한 상태
	SetLoungeQuestState(QUEST_ID, "InProgress")
end

function OnInProgress() -- 진행중인 상태
end

function OnNotCompleted() -- 완료조건을 만족했지만 완료처리 안된 상태
	LuaApi:SetNpcNavigationActive(700005, true)	
	AddLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog", "Start", START_TITLE, START_PRIORITY)	

end

function OnCompleted() -- 완료된 상태
	LuaApi:SetNpcNavigationActive(700005, false)	
	RemoveLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog")
end