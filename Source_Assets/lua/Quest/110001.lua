local QUEST_ID = 110001

function OnLounge()
	local step = LuaApi:GetStep();

	if (step == 10) then
		QuestComplete()
	elseif LuaApi:GetString(QUEST_ID, "prologue") ~= "true" then

		await(LuaApi:OpenDialogAsync(1)) -- 다이얼로그 시작
		await(LuaApi:SetDialogCustomImageAsync("bg_prologue_13", false, 0))		
		LuaApi:PlaySfx("Train")
		await(LuaApi:DelayDialogAsync(1500))		
		LuaApi:PlayBgm("Scenario_Prologue_Memory")			
		await(LuaApi:DelayDialogAsync(1500))		
		LuaApi:PlaySfx("Paper")		
		await(LuaApi:DelayDialogAsync(500))			
		await(LuaApi:OpenNoteSystemPopup({
		"<Key:LQuest_110001_3001>이런 방식으로 연락 드리게 된 것을 먼저 사과드립니다.", 
		"<Key:LQuest_110001_3002>달이 태양을 삼키고 별이 비명을 지르던 그 때의 참상을,\n영혼을 소실한 그 사무친 고통을\n그대가 영원토록 잊지 못하리라는 것을 잘 알고 있습니다.", 
		"<Key:LQuest_110001_3003>그러나 10년이라는 세월은\n여전히 기억의 저주에 몸부림치고 있을 당신에게도\n잠시나마 숨 고를 틈은 되었을 거라 믿습니다.", 
		"<Key:LQuest_110001_3004>멈추어 있던 시간이 다시 흐르고,\n잠들어 있던 심연이 깨어나고 있습니다.",
		"<Key:LQuest_110001_3005>그러니 이제, 고향으로 돌아와주세요.", 
		"<Key:LQuest_110001_3006>비록 시작은 아니었을지 모르나 그 끝만큼은 그대의 뜻대로 이루어지기를 바랍니다.", 		
		"<Key:LQuest_110001_3007>기다리겠습니다."},
		ENoteType.LetterAndEnvelope))	

		await(LuaApi:DelayDialogAsync(2200)) 

		CenterDialogSay("제이", "De", "<Key:LQuest_110001_3008>10년… '그 날’로부터 고작 10년이다.")	
		LuaApi.FadeOutDialog()				
		await(LuaApi:DelayDialogAsync(1500)) 
		LuaApi.FadeInDialog()			
		CenterDialogSay("제이", "De", "<Key:LQuest_110001_3009>갑자기 도시에 나타나 모든 것을 집어삼킨 저 거대한 심연… 지금은 던전이라고 부르던가?")

	
		LuaApi.FadeOutDialog()				
		await(LuaApi:DelayDialogAsync(2000)) 
		LuaApi.FadeInDialog()		
		CenterDialogSay("제이", "De", "<Key:LQuest_110001_3010>아직도 저렇게 도시 중앙에 자리 잡고 있는데…")	
		CenterDialogSay("제이", "De", "<Key:LQuest_110001_3011>그럼에도 저 것 덕에 도시는 오히려 더 부흥하고 있다고 하니…")
		CenterDialogSay("제이", "De", "<Key:LQuest_110001_3012>이 아이러니를 정말 믿을 수가 없다니까.")
		await(LuaApi:DelayDialogAsync(1500))
		await(LuaApi.ClearAllDialogCustomImagesAsync())		
		await(LuaApi:DelayDialogAsync(700))	
		LuaApi:StopSfx("Train");
		await(LuaApi:DelayDialogAsync(1500))	

		CenterDialogSay("제이", "De", "<Key:LQuest_110001_3013>아, 여기가 '발루샤'인가.")
		await(LuaApi:DelayDialogAsync(1000))		
		LuaApi:PlaySfx("NPC_Knock")
		await(LuaApi:DelayDialogAsync(1500))

		
		LuaApi:PlaySfx("DoorKey")
		await(LuaApi:DelayDialogAsync(1000))
		LuaApi:PlaySfx("DoorOpen")
		await(LuaApi:DelayDialogAsync(1000))
		
		LuaApi:PlayBgm("Scenario_Prologue_Meet")
		await(LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0))
		
		await(LuaApi:DelayDialogAsync(3500))

		LuaApi.FadeInDialog()	
		LuaApi:PlaySfx("FootStep_Run")	
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4001>어서와요.")	
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4002>우리, 실제로 만난 건 처음이죠?")
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4003>당신이…? 정말 편지의 그 분인가요?")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4004>맞아요. 꽤나 놀란 눈치네요.")
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4005>죄송합니다, 훨씬 연세가 있는 분일 거라고… 왠지 모르게 그렇게 생각했어요.")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4006>다른 아이들도 비슷한 말을 하더라고요.")
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4007>(다른 아이들?)")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4008>공부는 잘 마쳤다고 들었어요. 성적이 아주 우수하네요.")
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4009>네, 그간 후원해주신 은혜가 헛되지 않도록 열심히…")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4010>이 가게 어때요? 화려하진 않지만 그래도 꽤 고풍스럽지 않나요?")
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4011>네? 아, 네, 그렇네요.")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4012>골동품 가게 발루샤에요. <color=#b91d1d>던전</color>으로부터의 <color=#b91d1d>유물</color>을 전문적으로 취급하죠.")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4013>아직은 부족한 부분도 꽤 있지만 점차 키워나갈 생각이에요. 지금은 공석인 점장의 역할이 정말 중요한 때이죠.")
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4014>네, 그렇군요.")	
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4015>그래서 말인데, 당신이 이 가게를 맡아주었으면 해요.")

		LuaApi.FadeOutDialog()
		await(LuaApi:DelayDialogAsync(1500))

		LuaApi.FadeInDialog()	
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4016>네…?")				
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4017>제가…요? 하, 하지만…")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4018>당황스러울 거 알아요. 10년만에 불러들여서 갑자기 가게를 맡으라니 물론 그렇겠죠.")	
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4019>하지만 어쩔 수 없어요. 이미 결정된 일이니까.")	
		LuaApi.FadeOutDialog()
		await(LuaApi:DelayDialogAsync(1500))
		LuaApi.FadeInDialog()
		MDSay("비움", "De", "오너", "De", "비움", "De", "제이", "<Key:LQuest_110001_4020>이미 결정된…")
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4021>가게는 엘라라가 안내해줄 거예요. 저는 바쁜 일이 있어서 먼저 실례할게요. 우리 못다한 이야기는 나중에 천천히 나누도록 하죠.")
		
		
		LuaApi.FadeOutDialog()
		
		await(LuaApi:DelayDialogAsync(1500))
		LuaApi.FadeInDialog()
		
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", "<Key:LQuest_110001_4022>참… 귀향을 환영해요.")
		MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_4023>…….")
		
		LuaApi.FadeOutDialog()
		await(LuaApi:DelayDialogAsync(1000))
		LuaApi:PlaySfx("DoorKey")
		await(LuaApi:DelayDialogAsync(1000))
		LuaApi:PlaySfx("DoorOpen")
		await(LuaApi:DelayDialogAsync(1500))
		

		LuaApi.FadeInDialog()		
		LuaApi:PlayBgm("Lounge")
		LuaApi:PlaySfx("ElaraWalk")	
		await(LuaApi:DelayDialogAsync(700))
		
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5001>안녕하세요!")
		await(LuaApi:DelayDialogAsync(1500))		
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5002>우왓!!")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5003>AI 비서 '엘라라'라고해요, 잘 부탁해요, 점장님.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5004>아… 응… 잘부탁해.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5005>그런데 정말로 내가 이 가게를 맡아 운영해야 하는 거야? 정말로?")	
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5006>네. 오너님께서 이미 결정된 일이라 하셨잖아요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5007>음… '그 날' 이후로 천애 고아가 된 나를 10년이나 후원해 주셨으니 어떻게든 보답해야겠다 생각은 했지만… ")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5008>그렇다고 갑자기 가게를 운영하라실 줄은 몰랐는데.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5009>너무 걱정마세요. 발루샤의 운영에 필요한 건 하나부터 열까지 제가 모두 알려드릴 테니까요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5010>고마워, 그렇게 이야기해주니 조금은 안심이 되네.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5011>먼 길 오느라 피곤하시겠지만 가게 운영에 관한 설명은 먼저 들어두고 쉬시는 게 좋을 거예요. 재오픈까지 시간이 얼마 없거든요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5012>응? 오픈이 언젠데?")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5013>내일이요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5014>…….")

		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5015>그러고 보니 마침 점장님께서 당장 처리해주셔야 할 일이 하나 있어요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_5016>벌써? 무슨 일이길래?")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5017>던전으로부터 구조 요청자가 있어서요. 앞으로의 일에 대한 예행 연습이라고 생각하시면 돼요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LQuest_110001_5018>그럼, 단말기를 통해 던전과 통신합니다.")
		LuaApi:SetString(QUEST_ID, "prologue", "true")		
		await(LuaApi:DelayDialogAsync(2500))
		LuaApi:ForceStartStage()
	else 
		LuaApi:ForceStartStage()		
	end
end

function OnStage()
	OnStageCommon()
end

function OnEvent(eventType, value)
	local step = LuaApi:GetStep();

	if (eventType == E_Trigger and value == 800010) then
		TalkToEll_1()
	end

	if (eventType == E_Trigger and value == 800011) then
		TalkToEll_2()
	end

	if (eventType == E_Collision and value == 100091) then 	-- 충돌 트리거
		CallCollision_1()
	end	

	if (eventType == E_Collision and value == 100092) then 	-- 충돌 트리거
		CallCollision_2()
	end	

	if (eventType == E_Collision and value == 100093) then 	-- 충돌 트리거
		CallCollision_3()
	end	

	if (eventType == E_Collision and value == 100094) then 	-- 충돌 트리거
		CallCollision_4()
	end	

	if (eventType == E_Collision and value == 100095) then 	-- 충돌 트리거
		CallCollision_5()
	end	

	if (eventType == E_Collision and value == 100096) then 	-- 충돌 트리거
		CallCollision_6()
	end	

	if (eventType == E_Collision and value == 100097) then 	-- 충돌 트리거
		CallCollision_7()
	end	
	if (eventType == E_Collision and value == 100098) then 	-- 충돌 트리거
		CallCollision_8()
	end	
	if (eventType == E_Collision and value == 100099) then 	-- 충돌 트리거
		CallCollision_9()
	end	
end

function Step_00001()

end

function Step_00003()
	LuaApi:SendTutorialEvent("Step_00003")

	await(LuaApi:OpenDialogAsync(0)) -- 다이얼로그 시작
	LuaApi:ForceSetCharacterAimPos({ x = -1, y = 0, z = 0 })	
	LuaApi:SetInGameHudActive(false)
	await(LuaApi:DelayDialogAsync(1000))

	MDSay("비움", "De", "비움", "De", "가영", "De", "가영", "<Key:LQuest_110001_6001>이게…… 대체 뭐지?")
	LuaApi.FadeOutDialog()		
	await(LuaApi:DelayDialogAsync(1000))	
	LuaApi.FadeInDialog()
	LuaApi:PlaySfx("Radio")	
	MDSay("엘라", "De", "비움", "De", "가영", "De", "엘라", "<Key:LQuest_110001_6002>무소속 다이버 확인. 동양계 여성, 10대 후반, 검과 퇴마 도구를 소지하고 있습니다.")
	MDSay("엘라", "De", "비움", "De", "가영", "De", "가영", "<Key:LQuest_110001_6003>오…?")
	MDSay("엘라", "De", "비움", "De", "가영", "De", "제이", "<Key:LQuest_110001_6004>너 괜찮니? 거긴 대체 어떻게 들어간 거야?")
	MDSay("엘라", "De", "비움", "De", "가영", "De", "가영", "<Key:LQuest_110001_6005>어… 그냥 저냥, 어떻게든 들어왔어요.")
	MDSay("엘라", "De", "비움", "De", "가영", "De", "제이", "<Key:LQuest_110001_6006>어떻게든…? 거기까지, 그러니까 <color=#b91d1d>던전 내부</color>까지 어떻게든 들어갔다고?")
	MDSay("엘라", "De", "비움", "De", "가영", "De", "가영", "<Key:LQuest_110001_6007>네, 뭐…")
	LuaApi.FadeOutDialog()		
	await(LuaApi:DelayDialogAsync(1000))	
	LuaApi.FadeInDialog()	
	
	MDSay("엘라", "De", "비움", "De", "가영", "De", "제이", "<Key:LQuest_110001_6008>어떻게 된 건지는 모르겠지만 거긴 말도 안되게 위험한 곳이야. 엘라라, 이 애 구조할 수 있어?")
	MDSay("엘라", "De", "비움", "De", "가영", "De", "엘라", "<Key:LQuest_110001_6009>가능합니다. 일단 비용 안내를 드리자면…")	
	MDSay("엘라", "De", "비움", "De", "가영", "De", "가영", "<Key:LQuest_110001_6010>아, 죄송해요. 도움받을 생각 없어요.")
	MDSay("엘라", "De", "비움", "De", "가영", "De", "제이", "<Key:LQuest_110001_6011>응?")	
	MDSay("엘라", "De", "비움", "De", "가영", "De", "가영", "<Key:LQuest_110001_6012>볼 일이 있어서 들어온 거니까 나중에 알아서 나갈게요. 그럼, 안녕.")
	MDSay("엘라", "De", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_6013>앗, 이봐!")
	MDSay("엘라", "De", "비움", "De", "비움", "De", "엘라", "<Key:LQuest_110001_6014>이런, 상대는 구조를 바라는 상태가 아닌 것 같네요.")
	MDSay("엘라", "De", "비움", "De", "비움", "De", "엘라", "<Key:LQuest_110001_6015>상황 종료하겠습니다. 이만 통신을 종료…")
	MDSay("엘라", "De", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_6016>자, 잠깐만! 내가 어떻게든 설득해볼게.")		
	MDSay("엘라", "De", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_6017>엘라라는 일단 저 애를 서포트해줘. 부탁해.")
	MDSay("엘라", "De", "비움", "De", "비움", "De", "엘라", "<Key:LQuest_110001_6018>…")
	MDSay("엘라", "Sm", "비움", "De", "비움", "De", "엘라", "<Key:LQuest_110001_6019>네, 알겠습니다.")
	
	LuaApi:SetInGameHudActive(true)
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	

end

function TalkToEll_1()
	LuaApi:SendTutorialEvent("TalkToEll_1")
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7001>바닥을 잘 보면 유용한 내용들을 발견할 수 있을 거예요.")	
end

function CallCollision_1()
	LuaApi:SendTutorialEvent("CallCollision_1")
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7002>근처에 괴물들이 있어요.")	
	await(LuaApi:WaitDelayAsync(3500))	
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7003>싸우는 법은 알고 있는 거죠? 적에게 빛을 비추면 정화되어 공격력과 방어력이 낮아져요.")	
	await(LuaApi:WaitDelayAsync(2500))	
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LQuest_110001_7004>물론이죠. 그런 기본적인 것 정도는…")	
end

function CallCollision_8()
	LuaApi:SendTutorialEvent("CallCollision_8")
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7005>문이 잠겨있네요. 근처에서 열쇠를 찾을 수 있을지 몰라요.")	
end

function CallCollision_9()
	LuaApi:SendTutorialEvent("CallCollision_9")
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LQuest_110001_7006>앗, 뭔가 귀중한 물건이 있을 것 같은데.")	
end

function CallCollision_2()
	LuaApi:SendTutorialEvent("CallCollision_2")
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7007>함정이네요. 산채로 구워지고 싶지 않다면 뛰는 게 좋겠어요.")	
end

function CallCollision_3()
	LuaApi:SendTutorialEvent("CallCollision_3")
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7008>상자에요. 뒤져보면 뭔가 쓸만한게 있을지도 몰라요.")	
end

function CallCollision_4()
	LuaApi:SendTutorialEvent("CallCollision_4")
	LuaApi:SetCharacterStress(80);
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7009>스트레스가 높아졌네요. 던전에는 스트레스를 높이는 적이나 함정이 즐비해요.")	
	await(LuaApi:WaitDelayAsync(3500))	
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7010>조심해요. 스트레스가 높으면 그림자 몬스터가 나타나요. ")	
	await(LuaApi:WaitDelayAsync(3500))	
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7011>보통은 던전에 들어온 다이버나 괴물의 모습을 하고 있죠.")	
	await(LuaApi:WaitDelayAsync(1500))

	local spawnPos = LuaApi:GetCharacterPosition()
	LuaApi:SpawnMonster(220009, { x = spawnPos.x+1, y = spawnPos.y, z = spawnPos.z + 1 })
	await(LuaApi:WaitDelayAsync(300))	
	LuaApi:SpawnMonster(220009, { x = spawnPos.x-2, y = spawnPos.y, z = spawnPos.z -1 })
	await(LuaApi:WaitDelayAsync(300))		
	LuaApi:SpawnMonster(220009, { x = spawnPos.x-1, y = spawnPos.y, z = spawnPos.z + 0.5 })	
end

function CallCollision_5()
	LuaApi:SendTutorialEvent("CallCollision_5")
	RadioSay("엘라", "Default", "<Key:LQuest_110001_7012>자판기네요! 진정제를 마시면 스트레스를 완화시킬 수 있어요.")	
end

function CallCollision_6()
	LuaApi:SendTutorialEvent("CallCollision_6")
	LuaApi:SetCharacterLightFuel(0);	
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LQuest_110001_7013>아, 배터리가 다 떨어졌다…. 하지만 계속 가야 해.")	
end

function TalkToEll_2()
	LuaApi:SendTutorialEvent("TalkToEll_2")
	await(LuaApi:OpenDialogAsync(0)) -- 다이얼로그 시작

	MDSay("가영", "De", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8001>저기… 왜 자꾸 따라오세요?")
	MDSay("가영", "De", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_8002>위험하니까. 혼자 던전에 들어간 애를 어떻게 내버려두겠어.")
	MDSay("가영", "De", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8003>…….")	
	MDSay("가영", "An", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8004>자꾸 애취급하지 마세요. 그리고 보시다시피 여기까지 무사히 들어왔다고요.")	
	MDSay("가영", "An", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_8005>운이 좋았던 거지. 게다가 이제는 빛도 없잖아. 금세 던전에 삼켜지고 말 거야.")
	MDSay("가영", "De", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8006>던전에 삼켜진다? 그게 무슨…")		
	MDSay("가영", "De", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_8007>도와줄 테니 지금이라도 빠져나와. 당장.")
	MDSay("가영", "An", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8008>싫어요. 이렇게 나갈 바엔 처음부터 들어오지도 않았어요.")
	MDSay("가영", "An", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_8009>너… 그 안에 뭐가 있는지 알기나 해?")	
	MDSay("가영", "De", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8010>어? 그…")	
	MDSay("가영", "De", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8011>잘은 몰라요, 하지만…")	
	MDSay("가영", "Sa", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8012>찾을 게 있어요. 꼭 찾아야만 해요.")	
	MDSay("가영", "Sa", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_8013>그러니까 이만 갈게요, 안녕.")		
	MDSay("가영", "Sa", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_8014>안 돼, 잠깐만!")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료		
end

function CallCollision_7()
	LuaApi:SendTutorialEvent("CallCollision_7")
	await(LuaApi:WaitDelayAsync(1500))
	LuaApi:PlayBgm("BossDarkYoung_Battle")	
	await(LuaApi:OpenDialogAsync(0)) -- 다이얼로그 시작
	await(LuaApi:DelayDialogAsync(1000))		
	MDSay("가영", "Af", "비움", "De", "비움", "De", "가영", "<Key:LQuest_110001_9001>저, 저게… 대체…")
	MDSay("가영", "Af", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_9002>엘라라!!")
	MDSay("가영", "Af", "비움", "De", "엘라", "De", "엘라", "<Key:LQuest_110001_9003>네, 고객님께 구조 요청 동의 여부를 확인하겠…")	
	MDSay("가영", "Af", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110001_9004>됐으니까 강제로라도 탈출시켜! 어서!!")

	if (LuaApi:HasItem(300007) == false ) then
		LuaApi:GiveItem(300007, 1)
	end
		
	local spawnPos = LuaApi:GetCharacterPosition()
	LuaApi:SpawnExit(1004, { x = spawnPos.x-1, y = spawnPos.y, z = spawnPos.z })	
	await(LuaApi:DelayDialogAsync(2000))		 	
	await(LuaApi:DelayDialogAsync(1000))

	LuaApi:SetStep(10)
	LuaApi:ForceEscapeStage()
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료		
end

function Step_00010()
end

function QuestComplete()
	LuaApi:SendTutorialEvent("QuestComplete")
	await(LuaApi:OpenDialogAsync(1)) -- 다이얼로그 시작
	await(LuaApi:DelayDialogAsync(1500))
	
	MDSay("비움", "De", "가영", "Af", "비움", "De", "가영", "<Key:LQuest_110001_2001>헉헉…")
	MDSay("비움", "De", "가영", "Af", "비움", "De", "제이", "<Key:LQuest_110001_2002>다친 데 없어?")
	MDSay("비움", "De", "가영", "Af", "비움", "De", "가영", "<Key:LQuest_110001_2003>안 돼… 안 돼… 안 돼… 오지 마…")
	MDSay("비움", "De", "가영", "Af", "비움", "De", "제이", "<Key:LQuest_110001_2004>정신차려! 끌려가면 안 돼!")
	MDSay("비움", "De", "가영", "Af", "비움", "De", "가영", "<Key:LQuest_110001_2005>헉! 방금 그거… 대체… 뭐였던…")
		
	MDSay("비움", "De", "가영", "Af", "비움", "De", "제이", "<Key:LQuest_110001_2006>이제 안전해. 그러니 지금은 벗어났다는 것만 기억하자. 일단은 천천히 숨부터 가다듬고.")
	MDSay("비움", "De", "가영", "Af", "비움", "De", "제이", "<Key:LQuest_110001_2007>던전엔 평범한 괴물만 있는 게 아니야. 그냥 마주치는 것만으로도 제정신이 아니게 될 것들이 넘쳐 난다고.")
	
	MDSay("비움", "De", "가영", "Sa", "비움", "De", "가영", "<Key:LQuest_110001_2008>그, 그치만… 그치만… 아무리 그래도 어떻게 저런 게…")		
	MDSay("비움", "De", "가영", "Sa", "비움", "De", "가영", "<Key:LQuest_110001_2009>이래서는…")		
	await(LuaApi:DelayDialogAsync(1500))		
	LuaApi.FadeOutDialog()			
	await(LuaApi:DelayDialogAsync(2500))	
	LuaApi.FadeInDialog()			
	MDSay("비움", "De", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2010>잠깐, 그런데 여긴… 어디죠?")
	MDSay("비움", "De", "가영", "De", "비움", "De", "제이", "<Key:LQuest_110001_2011>아, 여긴 말이야…")	
	
	LuaApi.FadeOutDialog()
	LuaApi:PlayBgm("Lounge")	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))	
	await(LuaApi:DelayDialogAsync(1500))
	LuaApi.FadeInDialog()			
	
	LuaApi:PlaySfx("ElaraWalk")	
	MDSay("엘라", "Sm", "가영", "De", "비움", "De", "엘라", "<Key:LQuest_110001_2012>골동품점 발루샤에 오신 것을 환영합니다.")
	MDSay("엘라", "Sm", "가영", "De", "비움", "De", "엘라", "<Key:LQuest_110001_2013>저희 발루샤는 던전에서 가져온 유물을 전문적으로 취급한답니다. 그 외에는 특정 물품에 대한 의뢰를 받기도 하고 드물게는 이렇게 구조 활동을 하기도 하죠.")
	MDSay("엘라", "Sm", "가영", "De", "비움", "De", "엘라", "<Key:LQuest_110001_2014>물론 일정액의 구조비가 청구된답니다. 자, 여기 청구서를 받으세요.")
	MDSay("엘라", "Sm", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2015>아, 네, 네에….")		
	
	LuaApi.FadeOutDialog()			
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	MDSay("엘라", "Sm", "가영", "Co", "비움", "Co", "가영", "<Key:LQuest_110001_2016>히익.")		
	MDSay("엘라", "Sm", "가영", "Co", "비움", "Co", "제이", "<Key:LQuest_110001_2017>어디 보자, 어, 음… ")	
	MDSay("엘라", "Sm", "가영", "Co", "비움", "De", "가영", "<Key:LQuest_110001_20171>이, 이것도 보는 것만으로 미쳐버릴 것 같은데요.")		
	
	MDSay("엘라", "Sm", "가영", "Co", "비움", "De", "제이", "<Key:LQuest_110001_2018>엘라라, 이거 혹시 실수로 0이 몇 개 더 붙은 거 아니야?")	
	MDSay("엘라", "Sm", "가영", "Co", "비움", "De", "엘라", "<Key:LQuest_110001_2019>세상에 공짜란 없는 법이죠. 목숨에 관한 일이라면 더더욱 그렇고요. 원하시면 할부로 도와드릴까요?")	
	MDSay("엘라", "Sm", "가영", "Co", "비움", "De", "가영", "<Key:LQuest_110001_2020>살려주신 건 감사하지만 제, 제가 카드는 없고, 가진 게… 용돈 조금하고… 던전에서 주운 시계랑… 이것저것하면…")
	MDSay("엘라", "De", "가영", "Co", "비움", "De", "제이", "<Key:LQuest_110001_2021>시계…?")

	MDSay("엘라", "De", "가영", "Co", "비움", "De", "엘라", "<Key:LQuest_110001_2022>어쩔 수 없군요. 그럼 괜찮은 대부업체를 소개시켜드릴게요. 최근에 청계 상가 쪽에 금리가 저렴한 신생 업체가 몇 군데…")	
	MDSay("엘라", "De", "가영", "Co", "비움", "De", "제이", "<Key:LQuest_110001_2023>잠깐. 그러지 말고… 일단 청구는 내 쪽으로 해주겠어?")
	MDSay("엘라", "De", "가영", "Co", "비움", "De", "엘라", "<Key:LQuest_110001_2024>네?")
	MDSay("엘라", "De", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2025>뭐, 뭐예요.")	
	MDSay("엘라", "De", "가영", "An", "비움", "De", "가영", "<Key:LQuest_110001_2026>설마 또 애 취급을 하시는 건가요.")
	MDSay("엘라", "De", "가영", "An", "비움", "De", "제이", "<Key:LQuest_110001_2027>그런 게 아니라, 이 회중시계를 내가 매입하고 싶어서 그래. 구조비 대신으로 하자. 어때?")
	MDSay("엘라", "De", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2028>…이걸요?")
	MDSay("엘라", "De", "가영", "De", "비움", "De", "엘라", "<Key:LQuest_110001_2029>그다지 값이 나갈 것 같은 물건은 아닌 것 같지만… 점장님 뜻이 그러하면 굳이 말리지는 않을게요.")
	MDSay("엘라", "De", "가영", "De", "비움", "De", "제이", "<Key:LQuest_110001_2030>아무래도 아는 사람 물건인 것 같거든.")		
	MDSay("엘라", "De", "가영", "De", "비움", "De", "제이", "<Key:LQuest_110001_2031>뭣보다 고객 동의도 없이 내 멋대로 구조한 거니까, 억지로 청구할 수 있는 일도 아니잖아.")	
	MDSay("엘라", "De", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2032>음…")

	LuaApi.FadeOutDialog()			
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	
	MDSay("엘라", "De", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2033>시계는 드릴게요. 하지만 그 돈, 갚을 거에요. 몸으로 때우죠 뭐.")	
	MDSay("엘라", "De", "가영", "De", "비움", "De", "제이", "<Key:LQuest_110001_2034>뭐요?")	
	MDSay("엘라", "De", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2035>팸플릿에 쓰여있네요. '실력 좋은 다이버 구인 중, 극도로 위험하고 보수 좋음'이라고요.")
	MDSay("엘라", "De", "가영", "De", "비움", "De", "가영", "<Key:LQuest_110001_2036>대대로 퇴마를 하는 집안에서 자라서요, 괴물이나 유령 같은 것들과 싸우는 법 정도는 알아요.")	
	MDSay("엘라", "De", "가영", "De", "비움", "De", "제이", "<Key:LQuest_110001_2037>잠깐! 그런다고 이런 위험한 일에 너같은…")
	MDSay("엘라", "De", "가영", "An", "비움", "De", "가영", "<Key:LQuest_110001_2038>애요?")
	MDSay("엘라", "De", "가영", "An", "비움", "De", "제이", "<Key:LQuest_110001_2039>아, 아니 그게 아니라….")
	
	MDSay("엘라", "De", "가영", "An", "비움", "De", "엘라", "<Key:LQuest_110001_2040>점장님, 마침 가게 측에는 다이버가 아~주 필요하긴 하거든요. 참고로 이미 활동 중인 훨~씬 더 어린 다이버도 많답니다.")	
	MDSay("엘라", "De", "가영", "Sm", "비움", "De", "가영", "<Key:LQuest_110001_2041>그렇다고 하네요. 전 가영이라고 해요. 잘 부탁드립니다.")	
	MDSay("엘라", "De", "가영", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_2042>그… 음…")	
	MDSay("엘라", "De", "가영", "Sm", "비움", "De", "제이", "<Key:LQuest_110001_2043>일단 생각 좀 해보자. 하아…")	
	LuaApi.FadeOutDialog()		
	await(LuaApi:DelayDialogAsync(1000))	
	
	await(LuaApi.ClearAllDialogCustomImagesAsync())
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	SetQuestState("Completed")
	LuaApi:SetIsTutorial(false)
end
