function OnLounge()

end

function OnStage()
	SetNpcStateByName("좀요", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["좀요"]) then
		if (LuaApi:GetMissionState(9012) < 2) then
			QuestStartSay()
		elseif (LuaApi:GetMissionState(9012) == 3 ) then
			QuestCompleteSay()
		else
			LuaApi:ShowBubbleText(ESpeaker.Npc, CharacterIDs["좀요"], "<Key:LMission_9012_2009>으어어…")		
		end			
	end

	if (eventType == E_Trigger and value == 901202) then
		if (LuaApi:GetMissionState(9012) == 2) then
			ItemGet()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9012_1001>평범한 냉장고는 아닌 것 같다. 기분 나쁜 한기가 느껴져.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 901202, true)
		end
	end
end

function QuestStartSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "<Key:LMission_9012_2001>아, 완벽한 요리를 위한 마지막 한 조각이 부족하군.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9012_2002>이 근처 식당 냉장고에 아주 특별한 '숙성된 심장'을 보관해 뒀는데, 지금 가지러 가기엔 내 몸이 너무 무거워서 말이야.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9012_2003>자네가 대신 좀 가져다주지 않겠나? 물론 보수는 두둑이 챙겨주지.")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("좀요", ENpcState.None)
	LuaApi:SetMissionState(9012, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(901202)
	LuaApi:SpawnMiniMapMarker(901202, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9012_2007>요리사", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemGet()
	SetNpcStateByName("좀요", ENpcState.QuestTalkable)
	LuaApi:DespawnMiniMapMarker(901202)
	LuaApi:SetProgress(9012, 1)		
	LuaApi:SetMissionState(9012, EMissionState.NotCompleted)
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9012_2004>숙성된 심장을 습득했다. 돌아가서 물건을 건네줘야겠다.")
	LuaApi:PlaySfx("ItemRelease")
end

function QuestCompleteSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "<Key:LMission_9012_2005>오오, 이거야! 이 신선한 빛깔과 탄력! 정말 훌륭한 재료야!")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9012_2006>덕분에 최고의 요리를 완성할 수 있겠군. 자, 이건 약속한 보수다.")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("좀요", ENpcState.None)
	LuaApi:SetMissionState(9012, EMissionState.Completed)
	GrantRandomItemReward() -- 유물보상 지급	
	LuaApi:PlaySfx("QuestSuccess")
end
