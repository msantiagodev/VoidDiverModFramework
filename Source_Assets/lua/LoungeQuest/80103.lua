local QUEST_ID = 80103

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "핌핌"
local START_TITLE = "<Key:LLoungeQ_80103_START_TITLE> 시작"
local START_PRIORITY = 1


-- 대화 함수
function OnInProgressDialog()
	await(LuaApi:OpenDialogAsync(0)) -- 다이얼로그 창 열기

	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1001>축하하네. 발루샤의 명성이 널리 퍼지고 있군. ")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1002>이 늙은이 귀에까지 들어올정도면 흠... 이 바닥에서는 이제 나름대로 인정받기 시작했다고 할 수 있겠지.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1003>요즘 가게가 성장하는 걸 본 사람들이 꽤 놀란 모양이더라고.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1004>하지만 방심해서 일을 그르치지는 않았으면 좋겠군. 평판이 좋아진 만큼 앞으로는 더 위험한 일들이 들어올 테니까.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1005>특히나 가장 위험한 건... 이 바닥에선 언제나 고객이지.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1006>음? 그럼 어떻게 하면 좋으냐고?")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1007>해줄 말은 뭐 뻔하네. 상대의 눈을 유심히 들여다봐. 작은 몸짓 하나 기침 소리, 습관, 냄새까지 관찰할 수 있는 건 모조리 꿰뚫어 봐야 해.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1008>의뢰자의 말, 그 이면에 담긴 진짜 의도를 파악하지 못하면... 발루샤의 명성도 잠깐 반짝하고 끝나버리고 말겠지.")		
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_80103_1009>솔직히 말하면 난 이곳이 꽤 마음에 들어. 그러니... 잘 해내길 바라지.")		

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
	LuaApi:SetNpcNavigationActive(700015, true)	
	AddLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog", "Start", START_TITLE, START_PRIORITY)	

end

function OnCompleted() -- 완료된 상태
	LuaApi:SetNpcNavigationActive(700015, false)	
	RemoveLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog")
end