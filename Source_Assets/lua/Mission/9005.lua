
function OnLounge()

end

function OnStage()
	SetNpcStateByName("에드2", ENpcState.QuestTalkable)	
end

function 	OnEvent(eventType, value) 

	if (eventType == E_Npc and value == CharacterIDs["에드2"]) then
		SayNPC()
	end
		
	if (eventType == E_Trigger and value == 900502) then 
	
		if (LuaApi:GetMissionState(9005) == 2) then		
			ItemDrop()
		else 
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9005_1001>아무 반응이 없어. 이와 관련된 단서가 어딘가에 있을 거야.")	
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 900502, true)		
		end	
	end
end


function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	CenterDialogSay("에드2", "Default", "<Key:LMission_9005_2001>여기서… 만나니… 반가워…요. 실은… 뭘 하나 찾아야…되어서 내려왔는데…")		
	CenterDialogSay("에드2", "Default", "<Key:LMission_9005_2002>고객이… 금고를 잃어버렸다던데 히히… 안와요…")	
	CenterDialogSay("에드2", "Default", "<Key:LMission_9005_2003>그건 뭐… 사실상 주인 없는 물건… 되었단 뜻이죠.")	
	CenterDialogSay("에드2", "Default", "<Key:LMission_9005_2004>어디…있을지 알 것도… 같지만 직접 가려니… 역시 귀찮아요….")	
	CenterDialogSay("에드2", "Default", "<Key:LMission_9005_2005>찾으면… 맘대로 쓰세요….")	

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

	SetNpcStateByName("에드2", ENpcState.None)
	LuaApi:SetMissionState(9005, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(900502)
	LuaApi:SpawnMiniMapMarker(900502, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	
	LuaApi:PlayPing("<Key:LMission_9005_01>에드먼", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })		
end

function ItemDrop()
	LuaApi:DespawnMiniMapMarker(900502)
	LuaApi:SetProgress(9005, 1)	
	LuaApi:SetMissionState(9005, EMissionState.NotCompleted)	
	LuaApi:SetMissionState(9005, EMissionState.Completed)
	GrantRandomItemReward() -- 유물보상 지급	
	LuaApi:PlaySfx("ItemRelease")		
	LuaApi:PlaySfx("QuestSuccess")	
end
