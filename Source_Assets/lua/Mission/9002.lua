function OnLounge()

end

function OnStage()
	SetNpcStateByName("루카2", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["루카2"]) then
		SayNPC()
	end

	if (eventType == E_Trigger and value == 900202) then
		if (LuaApi:GetMissionState(9002) == 2) then
			ItemDrop()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9002_1001>아무 반응이 없어. 이와 관련된 단서가 어딘가에 있을 거야.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 900202, true)
		end
	end
end

function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	CenterDialogSay("루카2", "Default", "<Key:LMission_9002_2001>발루샤 팀이군요. 수확은 좀 있나요?")
	CenterDialogSay("루카2", "Default", "<Key:LMission_9002_2002>그러고 보니 여러분이 흥미로워할 정보가 하나 있는데.")
	CenterDialogSay("루카2", "Default", "<Key:LMission_9002_2003>울프스덴 말입니다, 꽤 오래 전에 분대 하나가 이 근처에서 작전하다가 MIA되었거든요.")
	CenterDialogSay("루카2", "Default", "<Key:LMission_9002_2004>뭔가 호송 작전 중이었던 것 같은데 그쪽 본부에서 회수 작전은 진작에 포기한 모양입니다.")
	CenterDialogSay("루카2", "Default", "<Key:LMission_9002_2005>즉, 먼저 찾는 사람이 임자라는 것이지요.")
	CenterDialogSay("루카2", "Default", "<Key:LMission_9002_2006>응? 이런 정보를 왜 알려드리냐고요?")
	CenterDialogSay("루카2", "Default", "<Key:LMission_9002_2007>별 뜻 없는 호의입니다.")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("루카2", ENpcState.None)
	LuaApi:SetMissionState(9002, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(900202)
	LuaApi:SpawnMiniMapMarker(900202, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9002_01>루카스", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemDrop()
	LuaApi:DespawnMiniMapMarker(900202)
	LuaApi:SetProgress(9002, 1)	
	LuaApi:SetMissionState(9002, EMissionState.NotCompleted)	
	LuaApi:SetMissionState(9002, EMissionState.Completed)
	GrantRandomItemReward() -- 유물보상 지급
	LuaApi:PlaySfx("QuestSuccess")
end
