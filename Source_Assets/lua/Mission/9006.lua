function OnLounge()

end

function OnStage()
	SetNpcStateByName("악마", ENpcState.QuestTalkable)
end

function OnEvent(eventType, value)
	if (eventType == E_Npc and value == CharacterIDs["악마"]) then
		SayNPC()
	end
end

function SayNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	CenterDialogSay("악마", "Default", "<Key:LMission_9006_1001>자, 배우. 오늘의 무대를 위한 배역을 고를 시간입니다.")

	local Choices = { "<Key:LMission_9006_1002>('웃는 가면'을 쓴다)", "<Key:LMission_9006_1003>('우는 가면'을 쓴다)" }
	local SIndex = CenterDialogSay("악마", "Default","<Key:LMission_9006_1004>당신의 역할은 '희극'입니까, 아니면 '비극'입니까?\n당신이 고른 가면이 이번 연극의 결말을 결정할 겁니다.",
		Choices)

	if (SIndex == 0) then
		CenterDialogSay("악마", "Default", "<Key:LMission_9006_1005>경쾌한 발걸음의 희극 배우로군요. 무대를 즐겨보시죠.")
	elseif (SIndex == 1) then
		CenterDialogSay("악마", "Default", "<Key:LMission_9006_1006>묵직한 고뇌의 비극 배우로군요. 관객들의 심금을 울려보시죠.")
	else
		CenterDialogSay("악마", "Default", "<Key:LMission_9006_1007>배역을 정하지 못하다니, 아마추어로군요.")
	end

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	LuaApi:SetMissionState(9006, EMissionState.InProgress)
	LuaApi:SetProgress(9006, 1)
	SetNpcStateByName("악마", ENpcState.None)
	LuaApi:SetMissionState(9006, EMissionState.Completed)

	if (SIndex == 0) then
		LuaApi:AddCharacterBuff(80003)
		LuaApi:AddCharacterBuff(80004)
		AcquirePositiveParadox()	
		LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9006_1008>하하하, 왠지 웃음이 안멈춰.")
	elseif (SIndex == 1) then
		LuaApi:AddCharacterBuff(80004)
		LuaApi:AddCharacterBuff(80005)
	    RemoveNegativeParadox()		
		LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LMission_9006_1009>흑흑흑, 왜이렇게 슬프지?")
	end
	LuaApi:PlaySfx("QuestSuccess")
end
