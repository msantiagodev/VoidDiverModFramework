local QUEST_ID = 80102

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_80102_START_TITLE> 시작"
local START_PRIORITY = 1

-- 대화 함수
function OnInProgressDialog()
	await(LuaApi:OpenDialogAsync(0)) -- 다이얼로그 창 열기

	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1001>가게의 평판이 한층 높아졌구나. 축하할 일이야.")				
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1002>하지만 또 마냥 기뻐하기만 할 일도 아니지. 그만큼 상대해야할 적도 많아질 테니까. ")	
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1003>응? 그게 무슨 말이냐고?")		
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1004>던전 내에는 저마다의 목적으로 움직이는 패거리들이 여럿 있어. 이번에 상대한 해방의 목소리도 물론 그중 하나고.")				
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1005>주택가를 벗어나서 도시 중심가 쪽으로 가보면 뭐, 이런저런 녀석들이 더 많아.")	
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1006>기계 종양들부터 해서 변이된 토종 괴물들... 이제는 복수귀가 되어버린 인간들과 비린내 나는 어인들하며...")	
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1007>앞으로는 아마 무사히 돌아오는 게 지금처럼 쉽지만은 않을 테지.")	
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1008>아하핫, 내가 너무 분위기를 망쳤나? 그래, 뭐 일단은 크게 신경 쓰지 말자고. 당장 눈앞에 떨어진 유물부터 줍기 바쁜 마당에 말이야. 하하핫.")				
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1009>참, 던전에 대해서 궁금한 게 있으면 노아에게 물어보는 것도 좋을 거야. 우리 중에 가장 오래 던전을 겪은 녀석이니까 이것저것 조언해 줄 말이 많겠지.")				
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LLoungeQ_80102_1010>그만큼 정신 상태도 아슬아슬한 녀석이지만 말이야 하하하.")				

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
	LuaApi:SetNpcNavigationActive(700008, true)	
	AddLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog", "Start", START_TITLE, START_PRIORITY)	

end

function OnCompleted() -- 완료된 상태
	LuaApi:SetNpcNavigationActive(700008, false)	
	RemoveLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog")
end