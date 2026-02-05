function OnLounge()

end

function OnStage()
	SetNpcStateByName("좀간", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["좀간"]) then
		SayNPC()
	end
end

function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	CenterDialogSay("엑스", "Default", "<Key:LMission_9008_1001>환자세요? 마침 잘 됐네요. 신약의 효능을… 테스트해 볼 참이었는데.")

	local Choices = { "<Key:LMission_9008_1002>(신약을 투여받는다)", "<Key:LMission_9008_1003>(거절한다)" }
	local SIndex = CenterDialogSay("엑스", "Default", "<Key:LMission_9008_1004>부작용은… 아직 모르지. 하지만 효과는… 끝내줄 거예요. 자, 팔을 걷어요.", Choices)

	if (SIndex == 0) then
		CenterDialogSay("엑스", "Default", "<Key:LMission_9008_1005>훌륭한 환자네요! 자, 따끔할 거예요… 히히…")
	elseif (SIndex == 1) then
		CenterDialogSay("엑스", "Default", "<Key:LMission_9008_1006>쯧… 의학의 발전을 거부하시는군요.")
	else
		CenterDialogSay("엑스", "Default", "<Key:LMission_9008_1007>결정장애도… 치료해야 할 질병인데…")
	end

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	LuaApi:SetMissionState(9008, EMissionState.InProgress)
	LuaApi:SetProgress(9008, 1)
	SetNpcStateByName("좀간", ENpcState.None)
	LuaApi:SetMissionState(9008, EMissionState.Completed)

	if (SIndex == 0) then
		LuaApi:AddCharacterBuff(80008)
		LuaApi:AddCharacterBuff(80009)
		AcquireRandomParadox()
	end
	LuaApi:PlaySfx("QuestSuccess")
end
