-- 80204.lua

local QUEST_ID = 80204

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "집무"
local START_TITLE = "<Key:LLoungeQ_80204_START_TITLE> 시작"
local START_PRIORITY = 1
local COMPLETE_NPC = "집무"
local COMPLETE_TITLE = "<Key:LLoungeQ_80204_COMPLETE_TITLE> 끝"
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
		
	-- 노크 소리
	-- 이력서 노트 띄우기
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1001>이력서 가져왔어요.")	
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1002>어디 보자, 가족관계는 음… 아버지는 세계 이능 연구 총 연맹 지부장이시고… 음….")	
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1003>좋아하는 음식은 떡볶이… 특기는 검술, 취미는 다꾸… 다꾸가 뭐야?")	
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1004>다이어리 꾸미기요.")	
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1005>….")	
	
	MDSay("비움", "De", "가영", "An", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1006>…그걸 꼭 그렇게 다 봐야돼요? 되게 합법적인 사업체인 것처럼 구네, 치.")
	MDSay("비움", "De", "가영", "An", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1007>사업체는 합법이야. 미묘하게 비합법적인 일도 있을 뿐이지.")		
	MDSay("비움", "De", "가영", "An", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1008>미묘는 무슨. 어기는 법이 한두 개가 아닌 거 다 아는데.")		
	MDSay("비움", "De", "가영", "An", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1009>아, 됐고됐고, 그보다 너… 제2외국어가 일본어네? 점수도 좋고.")		
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1010>네? 네. 그게 왜요?")
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1011>필사된 광신도의 문서를 얻었는데 이게 고대 일본어로 써 있어서 말이야.")
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1012>너 빚 갚고 나면 용돈 부족하지 않아? 번역해 주면 추가 알바비 줄게. 많이.")
	MDSay("비움", "De", "가영", "Sm", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1013>오? 정말요?")
	MDSay("비움", "De", "가영", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1014>당연하지만 문서 내용은 절대 반출 및 발설 금지야. 어때?")
	MDSay("비움", "De", "가영", "Sm", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1015>조, 좋아요!")
	MDSay("비움", "De", "가영", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1016>그럼 자세한 건 엘라라 통해서 전달할게. 이력서 검토가 끝나는 대로 정식 고용될 테니 그렇게 알고.")
	MDSay("비움", "De", "가영", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1017>볼 일은 이제 끝이니 나가봐.")	
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1018>….")

	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()		

	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1019>왜? 무슨 할 말 있어?")
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1020>근데 저한테 왜 그렇게 잘해 주세요? ")	
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1021>저번에 던전에서도 구해주고, 비싼 알바도 시켜주고.")
	
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1022>응? 딱히 못되게 대할 이유도 없잖아.")
	MDSay("비움", "De", "가영", "An", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1023>예에?")
	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	
	MDSay("비움", "De", "가영", "An", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1024>뭐… 아마도… 음, 동질감 같은 건가봐.")
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1025>동질감이라뇨?")
	
	await(LuaApi:SetDialogCustomImageAsync("Bg_hand_CloseClock", true, 1))		
	await(LuaApi:DelayDialogAsync(700))		
	
	
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1026>던전에게 중요한 것을 빼앗긴 사람 간의 동질감.")
	MDSay("비움", "De", "가영", "Sa", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1027>….")	
	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1000))	
	LuaApi:ClearDialogCustomImageAsync(true, 1)	
	await(LuaApi:DelayDialogAsync(1000))		
	LuaApi.FadeInDialog()	
	
	MDSay("비움", "De", "가영", "Sa", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1028>그러니까 그냥 그러려니 생각해. 잘해주는 사람이 있으면 이유야 어찌 됐든 잘 된 거지 뭐. 안 그래?")	
	MDSay("비움", "De", "가영", "Sa", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1029>네….")	
	MDSay("비움", "De", "가영", "Sa", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1030>근데 있잖아….")		
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1031>…?")	
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_80204_1032>너 수학 점수 27점은 좀 심하지 않니?")		
	MDSay("비움", "De", "가영", "An", "비움", "De", "가영", 	"<Key:LLoungeQ_80204_1033>아 쫌!!!")


	
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