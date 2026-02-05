-- 80203.lua

local QUEST_ID = 80203

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "집무"
local START_TITLE = "<Key:LLoungeQ_80203_START_TITLE> 시작"
local START_PRIORITY = 1
local COMPLETE_NPC = "집무"
local COMPLETE_TITLE = "<Key:LLoungeQ_80203_COMPLETE_TITLE> 끝"
local COMPLETE_PRIORITY = 1

-- 대화 함수
function InProgressDialog()
	await(LuaApi.OpenDialogAsync(1)) -- 다이얼로그 시작	
	
	await(LuaApi:WaitDelayAsync(300))
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:WaitDelayAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:WaitDelayAsync(500))	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))	
	await(LuaApi:WaitDelayAsync(500))
	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_1001>이리 오너라~!")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_1002>점장, 나 불렀다며?")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_1003>응, 네가 우리 다이버들 중에 경력이 가장 길다고 들어서 말이야. 던전에 대해 좀 물어볼까 해.")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_1004>그래그래, 좋지. 뭐가 궁금한데?")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_1005><color=#b91d1d>해방의 목소리</color>에 대해서 아는 대로 이야기해줘. 요즘에 자꾸 우리랑 얽히고 있는데 정보가 부족하네.")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_1006>해방의 목소리라면… 원래 연구기관 아콘 소속이란 건 이미 알고 있지? 던전 사태를 초래한 게 놈들이라는 것도 물론 잘 알 테고?")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_1007>응.")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드",	"<Key:LLoungeQ_80203_1008>이후는 뭐, 뻔한 이야기인데… 애초부터 공허를 연구하던 연구자들이었으니 던전에 삼켜진 놈들이 인간성을 잃어버리는 건 순식간이었지.")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드",	"<Key:LLoungeQ_80203_1009>그 후로는 자기들이 추종하는 신을 강림시키려고 안간힘을 쓰고 있다더라. 뭐 그게 그리 쉽게 될 일은 아니겠지.")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_1010>혹시 <color=#b91d1d>서장 도노반</color>도 해방의 목소리 신도인가?")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드",	"<Key:LLoungeQ_80203_1011>맞아, 연구원 출신은 아니지만 그도 외우주 신봉자니까. 해방의 목소리에서 <color=#b91d1d>영혼을 수집</color>하는 데 조력하고 있다고 들었어.")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_1012>흠…")
	
	-- 회중시계를 살펴본다.
	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_2001>(그러고 보면 이 시계도…)")
	await(LuaApi:SetDialogCustomImageAsync("Bg_hand_CloseClock", true, 1))		
	await(LuaApi:DelayDialogAsync(700))		
	LuaApi:PlaySfx("WatchOpen")
	await(LuaApi:SetDialogCustomImageAsync("Bg_hand_OpenClock", true, 1))			
	await(LuaApi:DelayDialogAsync(1500))		
	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_2002>그 시계도 해방의 목소리 놈에게서 발견되었다지?")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_2003>맞아, 친구의 유품이야.")
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_2004>굳이 말하면 <color=#b91d1d>해방의 목소리</color> 때문에 죽은 친구로군?")
	LuaApi:PlaySfx("WatchClose")	
	await(LuaApi:SetDialogCustomImageAsync("Bg_hand_CloseClock", true, 1))		
	await(LuaApi:DelayDialogAsync(700))			
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_2005>…그런 셈이지.")	
	
	LuaApi:ClearDialogCustomImageAsync(true, 1)		
	await(LuaApi:DelayDialogAsync(1500))		
	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_2006>이봐, 점장. 주제넘게 한 마디 해주자면 말이지… 던전 내의 일에 감상적이 되면 곤란해.")	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_2007>지휘관이 감상적이면 부하가 죽어.")	
	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(2200))	
	LuaApi.FadeInDialog()	
	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_2008>걱정 마. 단지 업무의 일환일 뿐이니까.")	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_2009>그렇담 다행이고. ")	
	MDSay("비움", "De", "헤드", "De", "비움", "De", "헤드", "<Key:LLoungeQ_80203_2010>아, 퇴근시간이다! 더 볼 일 없으면 이만 돌아가겠어. 또 궁금한 게 있으면 언제든 불러. 다음부턴 유료지만, 하하핫.")	
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_3001>….")
	
	LuaApi.FadeOutDialog()		
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:WaitDelayAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:WaitDelayAsync(1500))	
	LuaApi.FadeInDialog()
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_3002>지휘관이 감상적이면… 부하가 죽는다.")	
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LLoungeQ_80203_3003>명심하지.")	

	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	
	
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료			
	SetLoungeQuestState(QUEST_ID, "Completed")
end

function CompleteDialog()
end

-- 상태 콜백
function OnNotStarted() -- 조건을 만족해서 시작가능한 상태
	LuaApi:SetNpcNavigationActive(700102, true)	
	SetLoungeQuestState(QUEST_ID, "InProgress")		
end

function OnInProgress() -- 진행중인 상태
	AddLoungeDialog(START_NPC, QUEST_ID, "InProgressDialog", "Start", START_TITLE, START_PRIORITY)

end

function OnNotCompleted() -- 완료조건을 만족했지만 완료처리 안된 상태
end

function OnCompleted() -- 완료된 상태
	LuaApi:SetNpcNavigationActive(700102, false)	
	RemoveLoungeDialog(START_NPC, QUEST_ID, "InProgressDialog")
end