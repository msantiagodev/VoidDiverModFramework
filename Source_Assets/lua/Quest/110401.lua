-- 110401.lua

function OnLounge()
	OnLoungeCommon()
end

function OnStage()
	OnStageCommon()
end

function OnEvent(eventType, value)
	local step = LuaApi:GetStep();

	if (step == 3 ) then
		if (eventType == E_TaskAchieved and value == 1104011) then
			CallTaskAchieved_A()
		end
		if (eventType == E_TaskAchieved and value == 1104012) then
			CallTaskAchieved_B()
		end
		if (eventType == E_Trigger and value == 1104011) then
			LuaApi:TriggerEventToAll(1104011)
		end
		if (eventType == E_Custom and value == 1104011) then
			CallToAll_1()
		end		
		if ((eventType == E_MonsterKill and value == 311010) or (eventType == E_MonsterKill and value == 311011)) then -- 보스몹 킬
			CallMonsterKilled()
		end		
		
	end
	
end

function Step_00001()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110401",
		FunctionName = "TalkToNPC",
		Purpose = "Start"
	})	
	await(LuaApi:WaitDelayAsync(3000))	
	PingToElara()
end

function TalkToNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110401_1001>이번 의뢰는…")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110401_1002>보나마나 또 해방의 목소리 관련이겠지.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110401_1003>잘 아시네요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110401_1004>언제나처럼 의뢰자는 익명일 테고?")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110401_1005>땡, 틀렸습니다.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110401_1006>응?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110401_1007>의뢰자가 직접 와 계세요, 점장실에서 기다리고 계십니다.")
	await(LuaApi:DelayDialogAsync(500))
	
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	await(LuaApi.OpenDialogAsync(1)) -- 다이얼로그 시작	
	LuaApi:SetDialogCustomImageAsync("bg_Lounge", false, 0)		-- 배경
	await(LuaApi:SetDialogCustomImageAsync("bg_LoungeDesk", true, 0))	
	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:DelayDialogAsync(700))
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:DelayDialogAsync(1500))
	
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2001>아서 앨런이라고 합니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2002>반갑습니다. 전에 손님으로 오셨던 분이군요. 묵주를 하나 사가셨고요.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2003>맞습니다. 그리고 짐작하시겠지만 앞선 의뢰 둘 다 제가 의뢰했습니다. 해방의 목소리를 막아야했거든요.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2004>그들과는 어떤 관계이십니까?")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2005>그들은… 예전 제 동료들입니다. 네, 저도 <color=#b91d1d>기관 아콘</color> 소속이었습니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2006>10년 전 '그 날' 도시 한가운데에 생긴 던전이 연구소를 집어삼켰을 때, 마침 저는 휴가 중이었고 덕분에 혼자만 이렇게 인간으로 남아있죠.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2007>제 동료들은 누구보다 앞장서서 외우주의 신을 추종하는 괴물이 되어버렸고요.")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()		

	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2008>일말의 책임감 때문일까요? 그 날 이후로 저는 그들이 어떻게 움직이는지 계속 여러 방법으로 살펴보고 있었습니다. ")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2009>제 동료들… 아니, 해방의 목소리는 '그 날' 이후 지난 10년간 끊임없이 영혼을 모아왔습니다. 그리고 제가 알아낸 바에 따르면, 그들은 이제 목표한 바에 거의 다다라 있습니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2010>목표하는 바라면 추종하는 신의 강림으로 알고 있습니다만… 그게 정말로 성공한다면 어떻게 됩니까?")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2011>그간 아슬아슬하게 유지되던 균형이 무너질 겁니다. 던전 내에 다른 여러 세력을 밀어 내고 해방의 목소리가 던전을 모두 장악할 겁니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2012>그 후엔?")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2013>지상으로 올라올 방법을 연구할 테고… 결국 알아내고 말겠지요.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2014>음…")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2015>팔척 귀신 때도, 경찰서장 도노반 때도, 그래서 우리에게 해방의 목소리를 계속 방해하게 만들었던 거군요.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2016>굳이 빙빙 돌려서 목적을 숨겼던 것은 죄송합니다. 발루샤 측이 제게 아군이 될지 적이 될지 알 수 없었습니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2017>저희는 둘 중 어느쪽도 아닙니다. 그저 보수를 받고 의뢰를 해낼 뿐이죠.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2018>그렇군요… 제게는 천만다행인 일입니다.")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2019>직접 찾아오셨다는 건, 더 이상은 의도를 숨길 이유는 없어졌다는 것이겠지요?")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2020>네, 그렇습니다. 이번이 제 마지막 의뢰입니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2021>해방의 목소리가 성역으로 삼고 있는 이공간이 있습니다. 그 공간으로 들어가기 위한 <color=#b91d1d>교전과 열쇠</color>를 가져다주시면 됩니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2022>둘 다 <color=#b91d1d>도시 중심가</color>에 있을 겁니다. 아시겠지만 위험한 곳입니다. 본 적 없는 괴물을 마주칠 것이고요.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2023>의뢰품을 전달받으시면 그걸로 어쩔 생각이신지 물어도 되겠습니까?")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2024>성역에 들어가서 그들이 모아둔 영혼을 해방시키려고 합니다. 해방의 목소리는 세력이 급속도로 약해질 거고, 던전 내 다른 세력에 밀려 살아남지 못할 겁니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2025>그 후에는요? 성역에서 돌아올 방법은 있습니까? 구조용 다이빙 부스를 지원해드릴까요?")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2026>그럴 필요 없습니다. 제겐 어차피 아무것도 남지 않았습니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2027>가족도 동료도… 10년 전 그날 모두 잃었으니까요.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2028>굳이 남은 것이라곤 혼자 살아남고 말았다는 일말의 죄책감 정도뿐이겠네요.")		
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2029>….")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()
	
	MDSay("비움", "De", "아서", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2030>의뢰를 받아들이겠습니다. 다이버들은 바로 준비할 겁니다.")
	MDSay("비움", "De", "아서", "De", "비움", "De", "아서",	"<Key:LQuest_110401_2031>감사합니다.")
	MDSay("비움", "De", "비움", "De", "비움", "De", "제이", "<Key:LQuest_110401_2032>….")	

	LuaApi:PlaySfx("DoorKey")
	await(LuaApi:DelayDialogAsync(1000))	
	LuaApi:PlaySfx("DoorOpen")
	await(LuaApi:DelayDialogAsync(1500))	

	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110401_2033>의뢰를 수락하셨군요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2034>응.")	
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110401_2035>달리 수상한 점은 없었나 보네요.")	
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2036>그렇더라.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110401_2037>의뢰인에게 던전 냄새가 지독하게 난다는 점만 빼면 말이야.")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110401", "TalkToNPC")	
	LuaApi:SetStep(2)	
end


function Step_00002() -- 캠페인 시작 세팅2
	SetQuestState("InProgress")
	await(LuaApi:WaitDelayAsync(700))
	ReadyAndStartToast()		
end

function Step_00003()
	await(LuaApi:WaitDelayAsync(1500))
	RadioSay("엘라", "Default", "<Key:LQuest_110401_4001>심연으로 들어가는 방법은 교전에 있다고 해요.")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110401_4002>교전과 그 열쇠 위치를 표시해드릴게요.")
end

function CallToAll_1()
	LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 1104011, false)
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LQuest_110401_4003>아, 교전이다.")

	if (LuaApi:IsHost() == true) then
		local spawnPos = LuaApi:GetZoneSpawnPosition(1104011)
		LuaApi:SpawnDropItem(300012, 1, { x = spawnPos.x - 0.35, y = spawnPos.y, z = spawnPos.z - 0.6 })
		LuaApi:PlaySfx("ItemDrop")
	end
end

function CallMonsterKilled()
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LQuest_110401_4004>아, 교전 열쇠다.")

	if (LuaApi:IsHost() == true) then
		local spawnPos = LuaApi:GetZoneSpawnPosition(1104012)
		LuaApi:SpawnDropItem(300013, 1, { x = spawnPos.x - 0.55, y = spawnPos.y, z = spawnPos.z - 0.6 })
		LuaApi:PlaySfx("ItemDrop")
	end
end

function CallTaskAchieved_A()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110401_4005>좋아요. 교전을 확보했네요.")
	await(LuaApi:WaitDelayAsync(3000))	
	if (LuaApi:IsAllTaskAchieved() == true) then
		RadioSay("엘라", "Default", "<Key:LQuest_110401_4006>이제 안전히 돌아오기만 하면 돼요!")
	else
		RadioSay("엘라", "Default", "<Key:LQuest_110401_4007>이제 열쇠만 입수하면 되겠어요!")
	end
end

function CallTaskAchieved_B()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110401_4008>좋아요. 열쇠를 확보했네요.")
	
	await(LuaApi:WaitDelayAsync(3000))		
	if (LuaApi:IsAllTaskAchieved() == true) then
		RadioSay("엘라", "Default", "<Key:LQuest_110401_4009>이제 안전히 돌아오기만 하면 돼요!")
	else
		RadioSay("엘라", "Default", "<Key:LQuest_110401_4010>이제 교전만 입수하면 되겠어요!")
	end
end

function Step_00010()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110401",
		FunctionName = "QuestComplete",
		Purpose = "Complete"
	})
end

function QuestComplete()

	await(LuaApi.OpenDialogAsync())        -- 다이얼로그 시작
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110401_3001>좋아요, 임무 완료네요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110401_3002>이젠 어쩌실 생각인가요?")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110401_3003>어쩌긴, 의뢰품을 의뢰인에게 넘겨줘야지.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110401_3004>물론, 그 전에 복사부터 해놓고.")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	

	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110401", "QuestComplete")	
	SetQuestState("Completed")	
end