local QUEST_ID = 110501

function OnLounge()
	OnLoungeCommon()
end

function OnStage()
	LuaApi:SetString(QUEST_ID, "Key", "false")	
	OnStageCommon()
	SetNpcStateByName("아서2", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	local step = LuaApi:GetStep();

	if (step == 3 and eventType == E_TaskAchieved) then
		CallTaskAchieved_A()
	end

	if (eventType == E_Trigger and value == 800006) then
		LuaApi:TriggerEventToAll(800006)
	end

	if (eventType == E_Npc and value == CharacterIDs["아서2"]) then
		CallToAll_1()
	end

	if (eventType == E_MonsterKill and value == 300005) then -- 보스몹 킬
		CallMonsterKilled()
	end
	
	if (eventType == E_Npc and value == CharacterIDs["도어"]) then
		OnEventDoorInCampaign()
	end	
end

function Step_00001()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110501",
		FunctionName = "TalkToNPC",
		Purpose = "Start"
	})	
	await(LuaApi:WaitDelayAsync(1500))		
	PingToElara()		
end

function TalkToNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110501_1001>준비되셨으면 시작할까요?")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110501_1002>응, 점장실로 모두 모아줘.")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	await(LuaApi.OpenDialogAsync(1)) -- 다이얼로그 시작	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))	
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:WaitDelayAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:WaitDelayAsync(1000))

	MDSay("미오", "De", "가영", "De", "헤드", "De", "가영", 	"<Key:LQuest_110501_1003>무슨 일이에요? 갑자기 전원 호출이라니.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이",		"<Key:LQuest_110501_1004>그만큼 중요한 임무거든. 엘라라가 설명할 거야.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", 	"<Key:LQuest_110501_1005>이번 의뢰는 발루샤에서 자체 발주하는 특수 의뢰입니다.")
	
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", 	"<Key:LQuest_110501_1006>장소는 <color=#b91d1d>해방의 목소리</color>의 성역. 보통은 진입할 수 없는 곳이지만 최근에 접근할 방법을 확보했어요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라", 	"<Key:LQuest_110501_1007>의뢰품은 돈이 될만한 것 모두. 그 중 특히 <color=#b91d1d>소울 콜렉터</color>라 불리는 괴이의 낫은 상당히 고가의 물건이에요.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "미오",		"<Key:LQuest_110501_1008>소울 콜렉터? 그게 뭐야?")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이",		"<Key:LQuest_110501_1009>해방의 목소리가 추종하는 괴이야. 죽은 이들의 원혼이 일정량 이상 뭉쳐지면 외우주의 신이 되어 버린다고 하지.")
	
	MDSay("미오", "De", "가영", "De", "헤드", "De", "가영",		"<Key:LQuest_110501_1010>오… 듣기론 무지무지 쎌 것 같은데요?")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이",		"<Key:LQuest_110501_1011>그렇겠지. 게다가 정보에 의하면 강림까지 얼마 남지 않은 모양이야.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이",		"<Key:LQuest_110501_1012>하지만 동시에 지금이 해방의 목소리가 가장 약해지는 시점이기도 해. ")

	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이",		"<Key:LQuest_110501_1013>그러니 이 때를 놓치지 않고 싶어.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "헤드",		"<Key:LQuest_110501_1014>흠… 찬물 끼얹기는 싫지만 말이야, 점장. 솔직히 우려되는 부분이 없다고는 못하겠군.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이",		"<Key:LQuest_110501_1015>무슨 생각하는지 알아, 노아. 그러니 분명히 말해두지.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이",		"<Key:LQuest_110501_1016>이건 비즈니스야. 아주 철저하게 말이야.")
	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()		
	
	MDSay("미오", "De", "가영", "De", "헤드", "De", "헤드",		"<Key:LQuest_110501_1017>훗, 그렇담 됐어. 기우였던 걸로 해두지.")
	MDSay("미오", "De", "가영", "Sm", "헤드", "De", "가영", 	"<Key:LQuest_110501_1018>뭔진 잘 모르겠지만 걱정할 거 없단 소리죠?")
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "미오",		"<Key:LQuest_110501_1019>좋아좋아. 비즈니스! 응? 샤비, 비즈니스란 게 뭐냐면 말이야…")
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "제이", 	"<Key:LQuest_110501_1020>자자, 다들 명심해줘. 이번 일은 놓칠 수 없는 절호의 기회야.")
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "제이", 	"<Key:LQuest_110501_1021>성공 여부에 따라 가게 위상이 크게 달라질 테고…")	
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "제이", 	"<Key:LQuest_110501_1022>해방의 목소리와의 지긋지긋한 싸움도 이걸로 일단락되겠지.")
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "제이", 	"<Key:LQuest_110501_1023>그러니, 다들 단단히 준비하도록 해.")
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "가영",		"<Key:LQuest_110501_1024>네, 점장님.")
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "미오",		"<Key:LQuest_110501_1025>샤비도 엄청 기대된대!")
	MDSay("미오", "Sm", "가영", "Sm", "헤드", "De", "헤드",		"<Key:LQuest_110501_1026>화끈하게 벌어보자고, 하핫.")


	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110501", "TalkToNPC")	
	LuaApi:SetStep(2)
end

function Step_00002() -- 캠페인 시작 세팅2
	SetQuestState("InProgress")
	await(LuaApi:WaitDelayAsync(700))
	ReadyAndStartToast()	
end

function Step_00003()
	await(LuaApi:WaitDelayAsync(1500))
	RadioSay("엘라", "Default", "<Key:LQuest_110501_2001>점장님 예상대로네요.")	
	await(LuaApi:WaitDelayAsync(3500))
	RadioSay("엘라", "Default", "<Key:LQuest_110501_2002>저번 의뢰의 의뢰인이에요.")
	
end

function CallToAll_1()

	LuaApi:ShowBubbleText(ESpeaker.Npc, CharacterIDs["아서2"], "<Key:LQuest_110501_2003>방해할 생각이라면 이미 늦었다.")
	await(LuaApi:WaitDelayAsync(2500))

	local spawnPos = LuaApi:GetZoneSpawnPosition(800006)

	if (LuaApi:IsHost() == true and LuaApi:GetMonsterCount(300005) == 0 and LuaApi:GetString(QUEST_ID, "Key")~="true") then
		LuaApi:SpawnMonster(300005, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
		LuaApi:DespawnNpc(CharacterIDs["아서2"]) --호스트 전용	
		LuaApi:SetString(QUEST_ID, "Key", "true")			
	end
end

function CallMonsterKilled()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110501_2004>성공적으로 쓰러뜨렸네요!!")
end

function CallTaskAchieved_A()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110501_2005>다이빙 부스를 내려드릴게요.")
	local spawnPos = LuaApi:GetZoneSpawnPosition(800006)
	if LuaApi:IsHost() == true then
		LuaApi:SpawnExit(1007, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })			
	end
end

function Step_00010()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110501",
		FunctionName = "QuestComplete",
		Purpose = "Complete"
	})
end

function QuestComplete()

	await(LuaApi.OpenDialogAsync(1)) -- 다이얼로그 시작
	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))	
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:DelayDialogAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:DelayDialogAsync(1000))


	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3001>수고했어. 임무는 화려하게 성공이야.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "헤드", 	"<Key:LQuest_110501_3002>그보다 대체 어떻게 된 거야? 그 아서 앨런이라는 자, 지난 의뢰의 의뢰인이었지?")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3003>정보에 따르면 그간 해방의 목소리에 내분이 있었어. 강림시킬 신의 그릇이 누가 될 것이냐를 두고 의견 대립이 있었다고 하네.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3004>그 내분을 이끈 자가 바로 아서 앨런이고.")
	
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3005>그리고 이건 해방의 목소리 입단 서약서. 해석한 바에 따르면… 어쩌고저쩌고 대부분 헛소리지만 입단 조건쪽에 눈여겨 볼만한 부분이 있는데…")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "미오", 	"<Key:LQuest_110501_3006>사망 시 자신의 영혼을 신에게 바친다… 이거 말이야?")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3007>맞아. 최근에 아서 앨런이 일으킨 내분에 의해서 많은 신도들이 죽었잖아? 그래서 신을 강림시키기 위한 영혼이 급속도로 모이게 된 거야.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "가영", 	"<Key:LQuest_110501_3008>그렇담 우리가 해방의 목소리를 처치했던 것도 크게 일조했겠네요.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3009>그게 아서 앨런이 노리는 바였지.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "가영", 	"<Key:LQuest_110501_3010>이번에 우리가 막지 않았다면… 아서 앨런을 그릇으로 정말 신이 강림할 뻔 했다는 건가요?")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3011>정말로 의식이 성공했을 가능성은 거의 없다는 의견도 있더라. 뭐, 일어나지 않은 일인데 실제로 어찌 되었을지 누가 알겠어?")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3012>만약 정말로 성공했다고 해도 어차피 던전 내 일인데 우리가 신경 쓸 바는 아니고. 우리는 그저 이번 임무의 성공을 자축하면 돼.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "헤드", 	"<Key:LQuest_110501_3013>하핫, 좋은 생각이야, 일단은 축배를 들어야지.")

	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3014>설명은 이쯤하면 된 것 같네. 다들 수고했어. 오늘은 푹 쉬고 수확의 기쁨을 만끽하자고.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3015>참, 소울 콜렉터에게서 풀려난 망령들이 덕지덕지 붙어있을 테니 다들 자기 전에 소금 충분히 뿌려두는 것 잊지 말고.")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "가영", 	"<Key:LQuest_110501_3016>윽…")
	MDSay("미오", "De", "가영", "De", "헤드", "De", "제이", 	"<Key:LQuest_110501_3017>다들 나가봐. 나도 이제 쉬어야겠다.")
	
	LuaApi.FadeOutDialog()		
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:DelayDialogAsync(1000))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:DelayDialogAsync(2200))	
	LuaApi.FadeInDialog()	
	
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", 	"<Key:LQuest_110501_3018>그건 그렇고…")
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", 	"<Key:LQuest_110501_3019>혹시나 놈들에게 갇혀있었다면 진의 영혼이 풀려나지는 않을까 기대했는데…")
	
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", 	"<Key:LQuest_110501_3020>누구야, 넌?")
	MDSay("비움", "De", "혼령", "De", "비움", "De", "혼령", 	"<Key:LQuest_110501_3021>…")	
	MDSay("비움", "De", "혼령", "De", "비움", "De", "혼령", 	"<Key:LQuest_110501_3022>진? 진…")
	MDSay("비움", "De", "혼령", "De", "비움", "De", "혼령", 	"<Key:LQuest_110501_3023>진은… 살아있어.")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	MDSay("비움", "De", "혼령", "De", "비움", "De", "제이", 	"<Key:LQuest_110501_3024>뭐?")
	LuaApi:PlaySfx("GaramScream")		
	MDSay("비움", "De", "혼령", "De", "비움", "De", "혼령", 	"<Key:LQuest_110501_3025>진은… 살아… 끼에엑!!!")

	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LQuest_110501_3026>망령 컷!")
	MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2", 	"<Key:LQuest_110501_3027>그 이상한 낫 때문에 가게가 아주 망령 천지야, 젠장.")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2", 	"<Key:LQuest_110501_3028>그래도 이제 거의 정리된 것 같네, 하하. 점장, 나 잘했지?")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "제이", 	"<Key:LQuest_110501_3029>무…")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "제이", 	"<Key:LQuest_110501_3030>무슨 짓이야!!! 이 자식아!!")
		
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110501", "QuestComplete")	
	SetQuestState("Completed") 	
end