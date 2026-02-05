-- 80205.lua

local QUEST_ID = 80205

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "집무"
local START_TITLE = "<Key:LLoungeQ_80205_START_TITLE> 시작"
local START_PRIORITY = 1
local COMPLETE_NPC = "집무"
local COMPLETE_TITLE = "<Key:LLoungeQ_80205_COMPLETE_TITLE> 끝"
local COMPLETE_PRIORITY = 1

-- 대화 함수
function InProgressDialog()
	await(LuaApi:OpenDialogAsync(1)) -- 다이얼로그 시작	
	

	await(LuaApi:WaitDelayAsync(300))
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:WaitDelayAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:WaitDelayAsync(500))	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))	
	await(LuaApi:WaitDelayAsync(500))
	
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_1001>휴우… 겨우 일단락이… 아, 오너님.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LLoungeQ_80205_1002>이야기 들었어요. 잘 해냈다고요?")
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_1003>네, 어려운 의뢰였지만 다행히 큰 문제없이 완수했습니다.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LLoungeQ_80205_1004>당신에게 이 가게를 맡긴 건 훌륭한 결정이었네요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_1005>감사합니다.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LLoungeQ_80205_1006>달리 특이한 사항은 없었나요?")
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_1007>예, 가게에 망령들이 꽤 돌아다니고 있긴 한데 펠릭스가 해결 중이에요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_1008>방금도 점장실에 들어온 녀석을 하나 제령해줬어요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LLoungeQ_80205_1009>그래요, 점장이 많이 놀랐겠네요. 후후.")

	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()		
	
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LLoungeQ_80205_1010>좋아요, 앞으로도 지금처럼만 해줘요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LLoungeQ_80205_1011>활약을 기대할게요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_1012>예.")
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:WaitDelayAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:WaitDelayAsync(1500))		
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_2001>…")

	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_2002>그 망령…분명히 이렇게 말했지.")
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_2003>진은 살아있다…")
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LLoungeQ_80205_2004>진… 10년 전 나를 구하고 대신 던전에 삼켜졌던 그 진이…")
	
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