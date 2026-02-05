function OnLounge()

end

function OnStage()
    SetNpcStateByName("사도", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["사도"]) then
		if (LuaApi:GetMissionState(9010) < 2) then
			QuestStartSay()
		elseif (LuaApi:GetMissionState(9010) == 3 ) then
			QuestCompleteSay()
		else
			LuaApi:ShowBubbleText(ESpeaker.Npc, CharacterIDs["사도"], "<Key:LMission_9011_2009>…")		
		end	
	end

	if (eventType == E_Trigger and value == 901002) then
		if (LuaApi:GetMissionState(9010) == 2) then
			ItemGet()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9010_1001>아무 반응이 없어. 이와 관련된 단서가 어딘가에 있을 거야.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 901002, true)
		end
	end
end

function QuestStartSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "<Key:LMission_9010_2001>이런, 곤란하게 됐군. 이교도 놈들의 노래를 기록해서 분석하려고 녹음기를 켜뒀는데…")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9010_2002>놈들이 갑자기 몰려드는 바람에 회수할 수가 없게 됐어. 네가 가서 저 '녹음된 테이프' 좀 가져다주지 않겠니?")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("사도", ENpcState.None)
	LuaApi:SetMissionState(9010, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(901002)
	LuaApi:SpawnMiniMapMarker(901002, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9010_2006>사교 수녀", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemGet()
	SetNpcStateByName("사도", ENpcState.QuestTalkable)
	LuaApi:DespawnMiniMapMarker(901002)
	LuaApi:SetProgress(9010, 1)	
	LuaApi:SetMissionState(9010, EMissionState.NotCompleted)
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9010_2003>녹음된 테이프를 습득했다. 돌아가서 물건을 건네줘야겠다.")
	LuaApi:PlaySfx("ItemRelease")
end

function QuestCompleteSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "<Key:LMission_9010_2004>오, 가져왔군. 고맙다. 과연… 흥미로운 소리가 녹음됐어.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9010_2005>자, 이건 수고비다.")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("사도", ENpcState.None)
	LuaApi:SetMissionState(9010, EMissionState.Completed)
	GrantRandomItemReward() -- 유물보상 지급	
	LuaApi:PlaySfx("QuestSuccess")
end
