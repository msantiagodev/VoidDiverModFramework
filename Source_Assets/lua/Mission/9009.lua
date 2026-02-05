function OnLounge()

end

function OnStage()
	SetNpcStateByName("펠릭2", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["펠릭2"]) then
		SayNPC()
	end
end

function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	CenterDialogSay("펠릭2", "Default", "<Key:LMission_9009_1001>도를 믿으십니까…는 농담이고.")

	local Choices = { "<Key:LMission_9009_1002>(점을 본다)", "<Key:LMission_9009_1003>(관심 없다)" }
	local SIndex = CenterDialogSay("펠릭2", "Default", "<Key:LMission_9009_1004>오늘의 던전 운수 한 번 볼래?", Choices)

	-- 점을 보겠다고 선택한 경우
	if (SIndex == 0) then
		-- 0부터 3까지의 숫자 중 하나를 랜덤으로 뽑습니다. (0:길, 1:흉, 2:화, 3:복)
		local randomResult = math.random(0, 3)

		if (randomResult == 0) then
			CenterDialogSay("펠릭2", "Default", "<Key:LMission_9009_1005>이럴수가! 하늘이 돕는 '길운'이야! 오늘은 뭘 해도 잘 풀리겠네.")
		elseif (randomResult == 1) then
			CenterDialogSay("펠릭2", "Default", "<Key:LMission_9009_1006>음… '흉운'이 들었군. 오늘은 몸을 사리는 게 좋겠어.")
		elseif (randomResult == 2) then
			CenterDialogSay("펠릭2", "Default", "<Key:LMission_9009_1007>크게 휘몰아치는 '화'의 기운이다! 재앙이 몰려올 테니 각오하는 게 좋을 거야!")
		elseif (randomResult == 3) then
			CenterDialogSay("펠릭2", "Default", "<Key:LMission_9009_1008>이보다 더 좋을 순 없지! 만복이 깃드는 '복운'이 가득하네!")
		end

		await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

		-- 랜덤 결과에 따라 다른 버프를 적용합니다.
		if (randomResult == 0) then
			LuaApi:AddCharacterBuff(80010)                        -- 길(吉) 버프
			AcquirePositiveParadox()
		elseif (randomResult == 1) then
			LuaApi:AddCharacterBuff(80011)                        -- 흉(凶) 버프
			AcquireNegativeParadox()	
		elseif (randomResult == 2) then
			LuaApi:AddCharacterBuff(80012)                        -- 화(禍) 버프
			RemovePositiveParadox()		
		elseif (randomResult == 3) then
			LuaApi:AddCharacterBuff(80013)                        -- 복(福) 버프
			RemoveNegativeParadox()	
		end

		-- 점을 보지 않겠다고 선택한 경우
	else
		CenterDialogSay("펠릭2", "Default", "<Key:LMission_9009_1009>운명을 거부하는 자에게 미래는 없지.")
		await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	end
	LuaApi:SetMissionState(9009, EMissionState.InProgress)
	LuaApi:SetProgress(9009, 1)
	SetNpcStateByName("펠릭2", ENpcState.None)
	LuaApi:SetMissionState(9009, EMissionState.Completed)
	LuaApi:PlaySfx("QuestSuccess")
end
