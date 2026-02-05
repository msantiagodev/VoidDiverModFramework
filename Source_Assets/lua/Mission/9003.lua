local QUEST_ID = 9003

function OnLounge()

end

function OnStage()
	SetNpcStateByName("에블2", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["에블2"]) then
		SayNPC()
	end

	if (eventType == E_Trigger and value == 900302) then
		if (LuaApi:GetMissionState(9003) == 2) then
			ItemDrop()
		else
			LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9003_1001>아무 반응이 없어. 이와 관련된 단서가 어딘가에 있을 거야.")
			LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 900302, true)
		end
	end
end

function SayNPC()

	if LuaApi:GetString(QUEST_ID, "Mission_9003") ~= "true" then
	
		await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2001>안녕하세요, 발루샤 분들이죠? 저는 에블린이라고 해요.")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2002>네? 던전 안에서 뭘 하고 있냐고요?")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2003>전 던전의 식재료에 관심이 많거든요.")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2004>여러분께도 '던전 미식'의 세계를 알려드리고 싶은데… 아, 근처에 괜찮은 던전 음식을 구할 데가 있을 거예요.")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2005>위치를 알려드릴 테니, 꼭 한 번 시식해 보세요. 꼭이요!")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2006>어떤 맛이었는지 발루샤로 여쭤보러 갈게요!")
		await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
		LuaApi:SetString(QUEST_ID, "Mission_9003", "true")
	else 	
		await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작	
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2007>안녕하세요, 던전에서 뵈니까 왠지 더 반갑네요.")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2008>네? 던전 안에서 뭘 하고 있냐고요?")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2009>뻔하죠. 식재료를 구하고 있어요.")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2010>아직 '던전 미식'의 즐거움을 모르시겠다면... 근처에 괜찮은 던전 음식을 구할 데가 있을 거예요.")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2011>위치를 알려드릴 테니, 꼭 한 번 시식해 보세요.")
		CenterDialogSay("에블2", "Default", "<Key:LMission_9003_2012>이번에는 전하고 다를 거예요. 정말로요!")	
		await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	
	end

	LuaApi:SetMissionState(9003, EMissionState.InProgress)

	local spawnPos = LuaApi:GetZoneSpawnPosition(900302)
	LuaApi:SpawnMiniMapMarker(900302, "SubQuestMarker", { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
	LuaApi:PlayPing("<Key:LMission_9003_01>에블린", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
end

function ItemDrop()
	LuaApi:DespawnMiniMapMarker(900302)
	LuaApi:SetProgress(9003, 1)	
	LuaApi:SetMissionState(9003, EMissionState.NotCompleted)
	LuaApi:SetMissionState(9003, EMissionState.Completed)
	AcquirePositiveParadox()
	
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9003_2013>오! 오오… 혀가 불탄다!!")
	LuaApi:PlaySfx("Eat")
	LuaApi:PlaySfx("QuestSuccess")
end