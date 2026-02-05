local QUEST_ID = 110201

function OnLounge()
	OnLoungeCommon()
end

function OnStage()
	LuaApi:SetString(QUEST_ID, "Key", "false")	
	OnStageCommon()

	local spawnPos = LuaApi:GetZoneSpawnPosition(1102011)
	LuaApi:SpawnMiniMapMarker(1102011, "QuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:SetTriggerable(ETriggerableObjectType.WaveExecutor, 1102011, false)
end

function OnEvent(eventType, value)
	local step = LuaApi:GetStep();
	
	if (step == 3) then
		if (eventType == E_MonsterKill and value == 220002) then -- 퀘몹 킬
			CallMonsterKilled_A()
		end
		if (eventType == E_Trigger and value == 1102011) then
			LuaApi:TriggerEventToAll(1102011)
		end
		if (eventType == E_Custom and value == 1102011) then
			CallToAll_1()
		end
		if (eventType == E_MonsterKill and value == 300016) then -- 보스몹 킬
			CallMonsterKilled_B()
		end
		if (eventType == E_TaskAchieved) then
			CallTaskAchieved_A()
		end
	end
end

function Step_00001()	-- 캠페인 시작 세팅
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110201",
		FunctionName = "TalkToNPC",
		Purpose = "Start"
	})	
	await(LuaApi:WaitDelayAsync(3000))	
	PingToElara()	
	
end

function TalkToNPC() -- 캠페인 시작 시 (라운지, 엘라라)
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작	

	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1001>익명의 의뢰입니다. 위험할 수 있지만 그만큼 보수가 좋고요. 때문에 특수 의뢰로 설정했어요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1002>좋아, 설명해 줘.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1003>교외 변두리 지역에서 위험한 주술이 걸려있는 물건을 회수해 오면 돼요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1004>의뢰인이 전달한 정보에 따르면 광신도 집단인 <color=#b91d1d>해방의 목소리</color>가 그 근방에 출몰하고 있으니 주의해 달라고 하네요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1005>해방의 목소리?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1006>해방의 목소리는 구성원의 대부분이 기관 아콘의 연구자들이었다고 해요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1007>아…")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1008>10년 전에는 공허를 연구하던 이들이지만 지금은 던전에 잠식되어 외우주의 신을 추종하는 광신도 집단이 되었죠.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1009>그자들이라면 나도 대충은 알고 있어. 말도 안 되는 짓을 벌여서 던전 사태를 벌인 장본인들이지. 그런데 아직까지도 던전에 남아있었군.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1010>의뢰품은 정확히 뭐지?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1011>동자 형태의 <color=#b91d1d>저주받은 석상</color>이에요. 원래는 삼각형 형태로 특정 지역을 봉인하는 물건으로 세 개가 있었는데 두 개는 현재 파괴되고 하나만 남아있다고 하네요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1012>지역을 봉인하는 물건, 도시 변두리에, 동자 석상이라면… 뭐가 봉인 되어있을지 대충은 감이 오네.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1013>그나저나, 그 마지막 석상까지 건드려버리면 결국 봉인이 풀리는 거 아니야?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1014>글쎄요, 정확히 어떻게 될지는 전달받은 바 없어서요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1015>음… 어쩔 수 없군. 대비를 철저히 하고 나서는 수밖에.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1016>해방의 목소리는 어떻게 대응할까요?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110201_1017>그냥 몬스터 취급하면 돼.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110201_1018>네, 그렇게 전달하겠습니다.")
	
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110201", "TalkToNPC")	
	LuaApi:SetStep(2)
end

function Step_00002() -- 캠페인 시작 세팅2
	SetQuestState("InProgress")
	await(LuaApi:WaitDelayAsync(700))
	ReadyAndStartToast()	
end

function Step_00003()	-- 던전 입장 시
	await(LuaApi:WaitDelayAsync(1500))
	RadioSay("엘라", "Default", "<Key:LQuest_110201_2001>목표는 하나예요. '저주받은 석상'")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110201_2002>해방의 목소리를 만나게 되거든 정신 공격을 주의하시고요.")	

end

function CallMonsterKilled_A() -- 퀘몹 다 죽이면
	if LuaApi:GetMonsterCount(220002) == 0 then
		LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 1102011, true)
		RadioSay("엘라", "Default", "<Key:LQuest_110201_3001>석상을 감싸고 있던 봉인이 풀렸어요!")
	end
end

function CallToAll_1()

	LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 1102011, false)
	local spawnPos = LuaApi:GetZoneSpawnPosition(1102011)
	RadioSay("엘라", "Default", "<Key:LQuest_110201_3002>팔척 귀신이 나타납니다!")	
	if (LuaApi:IsHost() == true and LuaApi:GetMonsterCount(300014) == 0 and LuaApi:GetString(QUEST_ID, "Key")~="true") then

		LuaApi:SpawnMonster(300014, { x = spawnPos.x+2, y = spawnPos.y, z = spawnPos.z })
		LuaApi:SetString(QUEST_ID, "Key", "true")			
	end
end

function CallMonsterKilled_B()
	await(LuaApi:WaitDelayAsync(500))
	RadioSay("엘라", "Default", "<Key:LQuest_110201_3003>쓰러뜨렸군요!")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110201_3004>팔척 귀신에게서 의뢰품을 습득하면 되겠어요!")
end

function CallTaskAchieved_A()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110201_3005>물건을 확보했군요!")
	await(LuaApi:WaitDelayAsync(1500))
	RadioSay("엘라", "Default", "<Key:LQuest_110201_3006>다이빙 부스를 내려드릴게요.")
	local spawnPos = LuaApi:GetZoneSpawnPosition(1102011)
	LuaApi:SpawnMiniMapMarker(111, "QuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })

	if LuaApi:IsHost() == true then
		LuaApi:SpawnExit(1007, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })			
	end
end

function Step_00010()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110201",
		FunctionName = "QuestComplete",
		Purpose = "Complete"
	})
end

function QuestComplete()
	await(LuaApi.OpenDialogAsync())-- 다이얼로그 시작

	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LQuest_110201_4001>좋아요, 임무 완수!")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 	"<Key:LQuest_110201_4002><color=#b91d1d>해방의 목소리</color> 말이야, 거기서 대체 뭘 하고 있었던 거지?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",		"<Key:LQuest_110201_4003>해방의 목소리는 항상 영혼을 수집하는 데 목말라 있다고 해요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",		"<Key:LQuest_110201_4004>그러니 팔척 귀신에게 당한 아이들의 원혼을 노리고 모여들었을 걸로 추정됩니다.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",		"<Key:LQuest_110201_4005>흐음…")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	

	SetNpcStateByName("엘라", ENpcState.None)
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110201", "QuestComplete")	
	SetQuestState("Completed")
end