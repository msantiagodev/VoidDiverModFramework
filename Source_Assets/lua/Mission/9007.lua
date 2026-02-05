function OnLounge()

end

function OnStage()
	SetNpcStateByName("평사", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["평사"]) then
		SayNPC()
	end
end

function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	CenterDialogSay("엑스", "Default", "<Key:LMission_9007_1001>신께서는 공포를 이겨낸 자에게만 길을 여신다.")

	local Choices = { "<Key:LMission_9007_1002>(인장을 받는다)", "<Key:LMission_9007_1003>(거절한다)" }
	local SIndex = CenterDialogSay("엑스", "Default", "<Key:LMission_9007_1004>너의 믿음을 증명하고 싶다면, 이 '공포의 인장'을 받아라.\n하지만 겁쟁이는 받을 자격이 없지.", Choices)

	if (SIndex == 0) then
		CenterDialogSay("엑스", "Default", "<Key:LMission_9007_1005>그래, 그 용기야말로 진정한 믿음의 증거다.")
	else
		CenterDialogSay("엑스", "Default", "<Key:LMission_9007_1006>선택의 무게를 감당할 수 없는 자로군.")
	end

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	LuaApi:SetMissionState(9007, EMissionState.InProgress)
	LuaApi:SetProgress(9007, 1)
	SetNpcStateByName("평사", ENpcState.None)
	LuaApi:SetMissionState(9007, EMissionState.Completed)

	if (SIndex == 0) then
		LuaApi:AddCharacterBuff(80007)
	   AcquirePositiveParadox()	
		LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9007_1007>갑자기 겁을 상실해버린 느낌이야.")
	end
	LuaApi:PlaySfx("QuestSuccess")
end
