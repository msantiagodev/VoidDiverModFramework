function OnLounge()

end

function OnStage()
	SetNpcStateByName("상인", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["상인"]) then
		if (LuaApi:GetMissionState(9014) < 2) then
			QuestStartSay()
		elseif (LuaApi:GetMissionState(9014) == 3 and LuaApi:HasItem(90141)) then
			QuestCompleteSay()
		end
	end

	if (eventType == E_MissionTaskAchieved) then
		ItemGet()
	end

	if (eventType == E_Trigger and value == 901402) then
		if (LuaApi:GetMissionState(9014) == 2) then
			ItemDrop()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "근방에 이것에 대해 알 방법이 있을 텐데.")
		end
	end
end

function QuestStartSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "퀘스트 시작 대사 더미")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("상인", ENpcState.None)
	LuaApi:SetMissionState(9014, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(901402)
	LuaApi:SpawnMiniMapMarker(901402, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemDrop()
	local spawnPos = LuaApi:GetZoneSpawnPosition(901402)
	LuaApi:SpawnDropItem(90141, 1, { x = spawnPos.x - 0.35, y = spawnPos.y, z = spawnPos.z - 0.6 })
	LuaApi:PlaySfx("ItemDrop")
end

function ItemGet()
	SetNpcStateByName("상인", ENpcState.QuestTalkable)
	LuaApi:DespawnMiniMapMarker(901402)
	LuaApi:SetMissionState(9014, EMissionState.NotCompleted)
end

function QuestCompleteSay()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("엑스", "Default", "퀘스트 완료 대사 더미")
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	LuaApi:RemoveItem(90141, LuaApi:GetItemCount(90141))
	SetNpcStateByName("상인", ENpcState.None)
	LuaApi:SetMissionState(9014, EMissionState.Completed)
	GrantRandomItemReward() -- 유물보상 지급	
	LuaApi:PlaySfx("QuestSuccess")
end
