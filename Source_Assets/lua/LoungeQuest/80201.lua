-- 80201.lua

local QUEST_ID = 80201

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "집무"
local START_TITLE = "<Key:LLoungeQ_80201_START_TITLE> 시작"
local START_PRIORITY = 1
local COMPLETE_NPC = "집무"
local COMPLETE_TITLE = "<Key:LLoungeQ_80201_COMPLETE_TITLE> 끝"
local COMPLETE_PRIORITY = 1

-- 대화 함수
function InProgressDialog()
	await(LuaApi.OpenDialogAsync(1)) -- 다이얼로그 시작		

	await(LuaApi:DelayDialogAsync(300))		
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:DelayDialogAsync(700))		
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:DelayDialogAsync(500))	
	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))

	await(LuaApi:DelayDialogAsync(300))
	LuaApi:PlaySfx("ElaraWalk")
	await(LuaApi:DelayDialogAsync(300))		
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80201_1001>부르셨나요, 점장님?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1002>아, 응.")
	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1003>첫 번째 의뢰도 잘 마무리되었으니 이제 가영의 정식 고용 문제를 고민해봐야 할 것 같아서.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1004>내버려 두면 어차피 혼자 던전에 드나들 테니… 그러느니 발루샤에서 정식으로 고용하는 게 가영에게나 가게 측에나 서로 더 좋겠지 싶은데.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80201_1005>잘 알고 계시네요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1006>그보다는 애초에 던전에 관계되지 않는 게 가장 좋은데 말이야.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80201_1007>그건 이미 무리인걸요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1008>그렇겠지….")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1009>던전에 찾을 것이 있다고 했어. 아마도 가까운 사람과 관련된 걸 거야.")	

	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1010>나도 그 마음을 모르겠는 건 아니지만…")
	await(LuaApi:SetDialogCustomImageAsync("Bg_hand_CloseClock", true, 1))
	await(LuaApi:DelayDialogAsync(1500))	
		
	LuaApi:PlaySfx("WatchOpen")
	await(LuaApi:SetDialogCustomImageAsync("Bg_hand_OpenClock", true, 1))	
	await(LuaApi:DelayDialogAsync(700))	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_1011>….")
	await(LuaApi:DelayDialogAsync(1200))	
		
	LuaApi:ClearDialogCustomImageAsync(true, 1)	
	await(LuaApi:DelayDialogAsync(700))			
	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_2004>어쩔 수 없지. 사람을 써서 가영의 조사를 부탁해, 가능한 은밀하게.")		
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80201_2005>네, 알겠습니다. ")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80201_2006>은밀하게라면… 이번 일에는 다이버 중에 <color=#3d840e>미오</color>가 적당하겠네요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_2007>정령을 부리는 그 아이 말이구나.")		
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_2008>조금 못 미더운 구석이 있긴 하지만… 임무 중 들킬 일은 없을 테니 그러는 게 좋겠다.")		
	await(LuaApi:DelayDialogAsync(300))
	LuaApi.FadeOutDialog()		
	await(LuaApi:DelayDialogAsync(500))		
	LuaApi.PlaySfx("OwnerHandBell")	
	await(LuaApi:DelayDialogAsync(2500))	
	
	LuaApi.FadeInDialog()
	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_2001>응? 이건 무슨 소리지?")		

	await(LuaApi:DelayDialogAsync(700))	
		
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80201_2002>오너님의 호출이에요. 아마 가게의 <color=#3d840e>평판 레벨</color> 때문일 거예요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80201_2003>그래, 바로 가 볼게.")	

	await(LuaApi:DelayDialogAsync(700))						
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