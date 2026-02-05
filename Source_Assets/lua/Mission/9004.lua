function OnLounge()

end

function OnStage()
	SetNpcStateByName("좀공", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["좀공"]) then
		SayNPC()
	end

	if (eventType == E_Trigger and value == 900402) then
		if (LuaApi:GetMissionState(9004) == 2) then
			ItemDrop()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9004_1001>아무 반응이 없어. 이와 관련된 단서가 어딘가에 있을 거야.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 900402, true)
		end
	end
end

function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "<Key:LMission_9004_2001>으… 어서 공사를… 어디있… 오, 거기 당신. 혹시 내 드릴 못 봤나?")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9004_2002>아주 급한 공사가… 있었는데. 그래, 볼트를 조여야…")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9004_2003>아니, 아니지. 일단… 하는데. 스패너가… 없지. 으르륵…")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9004_2004>그전에 용접기가… 공구 상자에 있을 거야.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9004_2005>공구 상자 위치를 알려줄 테니까… 어? 넌 누구지?")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("좀공", ENpcState.None)
	LuaApi:SetMissionState(9004, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(900402)
	LuaApi:SpawnMiniMapMarker(900402, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9004_01>좀비", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemDrop()
	LuaApi:DespawnMiniMapMarker(900402)
	LuaApi:SetProgress(9004, 1)	
	LuaApi:SetMissionState(9004, EMissionState.NotCompleted)
	LuaApi:SetMissionState(9004, EMissionState.Completed)
	GrantRandomItemReward() -- 유물보상 지급	
	LuaApi:PlaySfx("QuestSuccess")
end


