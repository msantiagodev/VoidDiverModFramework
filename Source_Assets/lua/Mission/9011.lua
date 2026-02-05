function OnLounge()

end

function OnStage()
	SetNpcStateByName("고사", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["고사"]) then
		if (LuaApi:GetMissionState(9011) < 2) then
			QuestStartSay()
		elseif (LuaApi:GetMissionState(9011) == 3 ) then
			QuestCompleteSay()
		else
			LuaApi:ShowBubbleText(ESpeaker.Npc, CharacterIDs["고사"], "<Key:LMission_9011_2009>…")		
		end			
	end

	if (eventType == E_Trigger and value == 901102) then
		if (LuaApi:GetMissionState(9011) == 2) then
			ItemGet()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9011_1001>불길한 기운이 느껴진다.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 901102, true)
		end
	end
end

function QuestStartSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "<Key:LMission_9011_0001>그대, 신의 목소리를 들을 자격이 있는가?")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9011_0002>이 근처에… 우리와는 다른, 저급한 신을 섬기는 이교도들의 성소가 있다.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9011_0003>그들의 거짓된 권능의 상징을 훼손하고, 그 '오염된 성물 조각'을 가져와 너의 믿음을 증명해라.")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("고사", ENpcState.None)
	LuaApi:SetMissionState(9011, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(901102)
	LuaApi:SpawnMiniMapMarker(901102, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9011_2004>사교 수녀", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemGet()
	SetNpcStateByName("고사", ENpcState.QuestTalkable)
	LuaApi:DespawnMiniMapMarker(901102)
	LuaApi:SetProgress(9011, 1)	
	LuaApi:SetMissionState(9011, EMissionState.NotCompleted)
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9011_2001>오염된 성물 조각을 습득했다. 돌아가서 물건을 건네줘야겠다.")
	LuaApi:PlaySfx("ItemRelease")
end

function QuestCompleteSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "<Key:LMission_9011_2002>음, 이 불결한 기운… 가져왔군. 이걸로 충분하다.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9011_2003>너의 믿음은 증명되었다. 약속된 보상이다.")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("고사", ENpcState.None)
	LuaApi:SetMissionState(9011, EMissionState.Completed)
	GrantRandomItemReward() -- 유물보상 지급	
	LuaApi:PlaySfx("QuestSuccess")
end
