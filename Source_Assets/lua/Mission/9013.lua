function OnLounge()

end

function OnStage()
    SetNpcStateByName("조이", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["조이"]) then
		if (LuaApi:GetMissionState(9013) < 2) then
			QuestStartSay()
		elseif (LuaApi:GetMissionState(9013) == 3) then
			QuestCompleteSay()
		else
			LuaApi:ShowBubbleText(ESpeaker.Npc, CharacterIDs["조이"], "<Key:LMission_9013_2009>동료들은 다 어디갔지?")		
		end
	end

	if (eventType == E_Trigger and value == 901302) then
		if (LuaApi:GetMissionState(9013) == 2) then
			ItemGet()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9013_1001>단단히 잠겨있는 상자다. 주인이 근처에 있으려나.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 901302, true)
		end
	end
end

function QuestStartSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("조이", "Default", "<Key:LMission_9013_2001>이런, 제기랄… 하필 여기서 신호가 끊기다니.")
	CenterDialogSay("조이", "Default", "<Key:LMission_9013_2002>이봐, 다이버. 내 정찰 드론 하나가 근처에 추락했는데 신호가 끊겨버렸지 뭐야.")
	CenterDialogSay("조이", "Default", "<Key:LMission_9013_2003>예비 드론이 근처에 있을 텐데 직접 가지러갈 상황은 아니란 말이지.")
	CenterDialogSay("조이", "Default", "<Key:LMission_9013_2004>드론을 가져다주지 않겠어? 물론 공짜는 아니야. 보상할게.")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("조이", ENpcState.None)
	LuaApi:SetMissionState(9013, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(901302)
	LuaApi:SpawnMiniMapMarker(901302, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9013_2010>조이스", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemGet()
    SetNpcStateByName("조이", ENpcState.QuestTalkable)
    LuaApi:DespawnMiniMapMarker(901302)
	LuaApi:SetProgress(9013, 1)	
    LuaApi:SetMissionState(9013, EMissionState.NotCompleted)
    LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9013_2005>조이스의 드론을 습득했다. 돌아가서 물건을 건네줘야겠다.")
    LuaApi:PlaySfx("ItemRelease")
end

function QuestCompleteSay()
    await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
    CenterDialogSay("조이", "Default", "<Key:LMission_9013_2006>오, 찾아왔네! 역시 발루샤 소속은 실력이 다르다니까.")
    CenterDialogSay("조이", "Default", "<Key:LMission_9013_2007>덕분에 작전 시간을 아꼈어. 자, 이건 약속했던 보상. 유용하게 써.")
    await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

    SetNpcStateByName("조이", ENpcState.None)
    LuaApi:SetMissionState(9013, EMissionState.Completed)
    GrantRandomItemReward() -- 유물보상 지급	
    LuaApi:PlaySfx("QuestSuccess")
end
