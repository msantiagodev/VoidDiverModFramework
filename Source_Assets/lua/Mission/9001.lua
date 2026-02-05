function OnLounge()

end

function OnStage()
    	LuaApi:AddDialog(CharacterIDs["아주"], {
            Title = "<Key:LNone_Start> 시작하기",
    		Type = "Mission",
    		Priority = 1,
    		LuaKey = "Mission/9001",
    		FunctionName = "SayNPC",
    	})
end

function OnEvent(eventType, value)

	if (eventType == E_Trigger and value == 900102) then
		if (LuaApi:GetMissionState(9001) == 2) then
			ItemDrop()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9001_1001>아무 반응이 없어. 이와 관련된 단서가 어딘가에 있을 거야.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 900102, true)
		end
	end
end

function SayNothing()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	CenterDialogSay("엑스", "Default", "와 이게 된다고?")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	
	LuaApi:RemoveDialog(CharacterIDs["아주"], "Mission/9001", "SayNothing")
	
    end

function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	CenterDialogSay("엑스", "Default", "<Key:LMission_9001_2001>어머, 웬일이야 바깥에서 들어온 젊은이네?")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9001_2002>내 꼴? 아유, 말도 마. '그날' 이후로 동네가 통째로 이 꼴이 됐잖아. ")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9001_2003>원래도 뭐 그리 대단히 살기 좋은 동네는 아니었던 것 같지만 이제는 말 그대로 괴물 소굴이지. 나도 포함이지만 호호호.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9001_2004>그래도 뭐 별수 있어? 30년 장기대출로 마련한 내 집이니 아득바득 붙어 살아야지.")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9001_2005>그나저나 간만에 만난 말 통하는 젊은이들인데 그냥 보내기는 아쉽고…")
	CenterDialogSay("엑스", "Default", "<Key:LMission_9001_2006>근처에 숙성시켜둔 요구르트가 있는데 잡솨볼래? 지도에 표시해 줄게.")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	
	LuaApi:RemoveDialog(CharacterIDs["아주"], "Mission/9001", "SayNPC")
	
	local spawnPos = LuaApi:GetZoneSpawnPosition(900102)
	LuaApi:SpawnMiniMapMarker(900102, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9001_01>아주머니", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:SetMissionState(9001, EMissionState.InProgress)	
end

function ItemDrop()

	LuaApi:DespawnMiniMapMarker(900102)
	LuaApi:SetProgress(9001, 1)	
	LuaApi:SetMissionState(9001, EMissionState.NotCompleted)	
	LuaApi:SetMissionState(9001, EMissionState.Completed)

	AcquirePositiveParadox()
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9001_2007>음… 미묘한 맛이야.")
	LuaApi:PlaySfx("ConsumeItem_Drink_Short")
	LuaApi:PlaySfx("QuestSuccess")

end
