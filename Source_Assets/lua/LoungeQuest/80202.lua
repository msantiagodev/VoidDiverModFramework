-- 80202.lua

local QUEST_ID = 80202

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "집무"
local START_TITLE = "<Key:LLoungeQ_80202_START_TITLE> 시작"
local START_PRIORITY = 1
local COMPLETE_NPC = "집무"
local COMPLETE_TITLE = "<Key:LLoungeQ_80202_COMPLETE_TITLE> 끝"
local COMPLETE_PRIORITY = 1

-- 대화 함수
function InProgressDialog()
	await(LuaApi.OpenDialogAsync(1)) -- 다이얼로그 시작	
	await(LuaApi:DelayDialogAsync(300))
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:DelayDialogAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:DelayDialogAsync(500))	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))	
	await(LuaApi:DelayDialogAsync(500))
	
	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80202_1001>음…")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80202_1002>이번엔 또 무슨 고민이신가요?")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80202_1003>이번 의뢰 말이야. 정말 석상이 목적이긴 했을까? 애초에 팔척 귀신의 봉인이 풀려 버리고 나면 동자 석상이란 건 그냥 돌덩이에 불과한 거 아냐?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80202_1004>그런데도 별 말없이 보수는 다 지급되었고…. 흠.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80202_1005>네, 여러모로 수상한 건 분명해요.")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80202_1006>수상한 만큼 위험했고 말이야.")		
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80202_1007>앞으로는 정보의 출처를 좀 더 파악하고 안전한 의뢰 위주로 진행하는 게 낫지 않을까 싶은데…")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80202_1008>아무래도 그건 어렵겠지?")		
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80202_1009>네. 일을 가려 받기 시작하면 아무도 의뢰해오지 않을 걸요.")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80202_1010>우리 업무는 위험을 대행하는 것이니까요. 애초에 던전에 관해서 수상하지 않은 일이란 없고요.")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80202_1011>그래… 칫, 어쩔 수 없네. 각오하는 게 좋겠어.")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LLoungeQ_80202_1012>철저히 이용당하고, 그리고 그에 상응하는 청구서로 응대하자.")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80202_1013>좋은 자세네요.")	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()

	LuaApi:PlaySfx("NPC_Knock")
	await(LuaApi:DelayDialogAsync(700))	
	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80202_1014>아, 미오님이 오셨어요. 전 이만 나가보죠.")	
	

	await(LuaApi:DelayDialogAsync(300))
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:DelayDialogAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:DelayDialogAsync(1000))	
	
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "미오", "<Key:LLoungeQ_80202_2001>점장! 나, 불렀어?")	
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "제이", "<Key:LLoungeQ_80202_2002>……미오야, 이 보고서 말인데.")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "미오", "<Key:LLoungeQ_80202_2003>어때? 완벽하지? 샤비랑 내가 조용히 뒤를 밟았어. 누나는 전혀 눈치도 못챘다구!")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "제이", "<Key:LLoungeQ_80202_2004>그래, 안 들킨 건 알겠는데… 보고서 제목이 왜 [가영 누나 관찰일기 - 날씨 매우 맑음]인 거야?")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "미오", "<Key:LLoungeQ_80202_2005>날씨가 좋았으니까?")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "제이", "<Key:LLoungeQ_80202_2006>오후 2시: 편의점에서 소시지 사 먹음. 케첩을 많이 뿌렸다. 맛있겠다. …이걸 미행 보고서라고 할 수 있니?")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "미오", "<Key:LLoungeQ_80202_2007>중요한 거야. 타깃의 영양 섭취 상태를 파악하는 건 기본이라구. 그리고 샤비가 그러는데, 소시지 냄새가 엄청 진해서 추적하기 쉬웠대.")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "제이", "<Key:LLoungeQ_80202_2008>좋아, 그건 그렇다치고… 오후 3시: 길가에 쪼그리고 앉아서 중얼거림. 미친 건가? 했는데 고양이랑 대화 중이었음. ")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "제이", "<Key:LLoungeQ_80202_2009>…그 밑에 그려진 그림은 뭐지?")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "미오", "<Key:LLoungeQ_80202_2010>가영 누나 등 뒤에 고양이 유령이 붙어 있더라고. 샤비가 가서 떼어내려다가 냥냥펀치 맞고 도망쳤는데 재미있어서 한 번 그려봤어.")
	MDSay("비움", "De", "미오", "Ha", "비움", "De", "제이", "<Key:LLoungeQ_80202_2011>…정령이 고양이한테 맞고 다닌다고?")
	MDSay("비움", "De", "미오", "De", "비움", "De", "미오", "<Key:LLoungeQ_80202_2012>던전 밖이잖아. 샤비도 그렇고 미오도 그렇고 밖에서는 별 힘 없단 말이야.")
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2013>하하, 그래, 뭐… 음…")
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2014>됐다. 잘했어. 걱정했던 것만큼 위험한 짓은 안하고 있는 것 같네. 수고했어, 미오.")
	MDSay("비움", "De", "미오", "De", "비움", "De", "미오", "<Key:LLoungeQ_80202_2015>근데 점장. 이거 실은 나쁜 짓이 아니야? 스토킹으로 체포되면 점장이 나 대신 감옥 가야돼?")
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2016>스, 스토킹이라니. 어디서 그런 말은 배워가지고… 그냥 일이야. 점장으로서 직원이 믿을 만한 사람인지는 알아둬야지.")
	MDSay("비움", "De", "미오", "De", "비움", "De", "미오", "<Key:LLoungeQ_80202_2017>그런 것 치고는 너~무 신경 쓰는 것 같으니까 하는 말이지. 달리 이유라도 있나 싶을 정도로 말야.")
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2018>내가? 그런가…")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(2500))	
	LuaApi.FadeInDialog()		
	
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2019>그래… 그럴지도 모르지. 실은 나도 지금의 가영이처럼 찾고 싶은 게 있었거든. 옛날에는 말이야.")
	MDSay("비움", "De", "미오", "De", "비움", "De", "미오", "<Key:LLoungeQ_80202_2020>그게 뭔데?")
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2021>그건 음…")
	
	LuaApi.FadeOutDialog()		
	await(LuaApi:DelayDialogAsync(700))		
	await(LuaApi:SetDialogCustomImageAsync("Bg_hand_CloseClock", true, 1))	
	await(LuaApi:DelayDialogAsync(700))		
	LuaApi.FadeInDialog()	
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2022>…")	
	await(LuaApi:DelayDialogAsync(1500))		
	LuaApi:ClearDialogCustomImageAsync(true, 1)		
	await(LuaApi:DelayDialogAsync(300))		
	
	MDSay("비움", "De", "미오", "De", "비움", "De", "제이", "<Key:LLoungeQ_80202_2023>비밀이야. 그나저나 보수는 포도맛 사탕 꾸러미 정도면 되겠지?")
	MDSay("비움", "De", "미오", "De", "비움", "De", "미오", "<Key:LLoungeQ_80202_2024>어헛, 왜 이러십니까, 선생님? 요즘 물가 몰라?")	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1000))		
	
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