function OnLounge()
	LuaApi:LogInfo("노캠페인 OnLounge 함수가 호출되었습니다.")
	LuaApi:AddDialog(700103, {
		Title = "<Key:LNone_Start> 시작하기",
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/None",
		FunctionName = "TalkToDisplay",
	})

	LuaApi:AddDialog(700104, {
		Title = "<Key:LNone_Start> 시작하기",
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/None",
		FunctionName = "TalkToDisplay",
	})
	LuaApi:AddDialog(700105, { 
		Title = "<Key:LNone_Start> 시작하기",
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/None",
		FunctionName = "TalkToDisplay2",
	})		
end

function OnEvent(eventType, value)
	local state = LuaApi:GetString(80100, "State")

	-- [수정] "완료가 아님"을 체크하는 게 아니라, "판매 중(Selling)" 상태인지 명확하게 체크해야 합니다.
	-- 80100.lua에서 대화가 끝나고 아이템을 줄 때 "Selling"으로 설정하기 때문입니다.
	if state == "Selling" then
		
		if eventType == 205 then
			-- 아이템(100233)이 인벤토리에 없는지 확인 (판매함)
			if LuaApi:HasEquipment(100233) == false then 
				
				LuaApi:SetString(80100, "State", "Return")
				LuaApi:DespawnPointerArrow(80100)
				LuaApi:SetNpcNavigationActive(700005, true)
				PingToOnwer()	

			end
		end
	end
end

function TalkToDisplay()
	LuaApi:ShowSystemToastText("<Key:LNone_0001>유물 전시판매대는 준비 중입니다. 추후 이용하실 수 있습니다.")
	LuaApi:PlaySfx("SkillDisable")
end

function TalkToDisplay2()
	LuaApi:ShowSystemToastText("<Key:LNone_0002>다이빙부스: 관계자 외 사용 금지.")
end
