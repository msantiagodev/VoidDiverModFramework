function OnLounge()
    OnLoungeCommon()
end

function OnStage()
    OnStageCommon()
end

function OnEvent(eventType, value)
    local step = LuaApi:GetStep();

    if (GetQuestState() == "NotCompleted") then
        if (eventType == E_Npc and value == EL) then
            LuaApi:SetStep(10)
        end
    end

    if (step == 1) then
        if (eventType == E_Npc and value == EL) then
            LuaApi:SetStep(2)
        end
    end

    if (eventType == E_Collision and value == 10111) then -- 충돌 트리거
        CallCollision()
    end

    if (eventType == E_Collision and value == 10112) then -- 충돌 트리거2
        CallCollision2()
    end

    if (eventType == E_TaskAchieved) then
        if (value == 11011) then
            CallTaskAchieved_A()
        end
        if (value == 11012) then
            CallTaskAchieved_B()
        end
        if (value == 11013) then
            CallTaskAchieved_C()
        end
    end
end

function Step_00001()
end

function Step_00002()            -- 캠페인 시작 시 (라운지, 엘라라)
    await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

    DialogSay("엘라라", "Default", "첫 번째 다이브에요. 음~ 기본적인 장비를 갖추고 시작하면 좋겠죠?")
    DialogSay("엘라라", "Default", "마침 경찰서 부근에 좀비들이 잔뜩 출몰했다고해요. 쓸만한 재료들을 많이 구할 수 있는 기회죠.")
    DialogSay("엘라라", "Default", "이것저것 모아오면 쓸만한 장비들을 만들 수 있을 거에요.")

    await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
    LuaApi:SetNpcState(EL, ENpcState.None)
    SetQuestState("InProgress")
    LuaApi:ShowSystemToastText("다이빙 부스로 탑승하세요.")
end

function Step_00003()
    await(LuaApi:WaitDelayAsync(1500))
    RadioSay("엘라라", "Default", "미니맵의 퀘스트 마커를 따라 차근차근 진행해보죠.")
end

function CallTaskAchieved_A()
    RadioSay("엘라라", "Default", "고철 더미를 모두 획득했어요. 전진하죠!")
end

function CallTaskAchieved_B()
    RadioSay("엘라라", "Default", "기판 더미를 모두 구했네요. 잘했어요.")
end

function CallTaskAchieved_C()
    RadioSay("엘라라", "Default", "이계의 주화를 모두 획득했어요.")
    await(LuaApi:WaitDelayAsync(3000))
    LuaApi:SpawnExit(2001, { x = 130.0, y = 0.0, z = 75.0 })
    RadioSay("엘라라", "Default", "다이빙 부스를 내려드릴 테니, 라운지로 돌아오세요.")
end

function CallCollision()
    RadioSay("엘라라", "Default", "성소에서는 체력과 정신력을 회복할 수 있어요.")
    await(LuaApi:WaitDelayAsync(3000))
    RadioSay("엘라라", "Default", "주변 동료들에게도 적용되니 같이 사용하면 좋아요.")
    await(LuaApi:WaitDelayAsync(3000))
    RadioSay("엘라라", "Default", "참, 컨트롤 + 마우스휠로 소모품 설정 슬롯을 변경할 수 있고 C를 누르면 사용돼요.")
end

function CallCollision2()
    RadioSay("엘라라", "Default", "기괴하게 생긴 함정 상자는 열 때 함정이 발동될 수 있다는 걸 기억하세요.")
    await(LuaApi:WaitDelayAsync(3000))
    RadioSay("엘라라", "Default", "이성이 일정치 아래로 낮아지면 다양한 디버프가 생기니 생존에 불리해져요.")
    await(LuaApi:WaitDelayAsync(3000))
    RadioSay("엘라라", "Default", "숫자 3을 눌러서 진정제 앰풀을 사용할 수 있어요. 1은 붕대, 2는 회복 드링크, 4는 에테르 배터리예요.")
end

function Step_00010()                           -- 엘라라		
    if (LuaApi:IsAllTaskAchieved() == false) then -- 퀘스트 완료 불가 상태일 때
        await(LuaApi.OpenDialogAsync())         -- 다이얼로그 시작
        DialogSay("엘라라", "Default", "저런, 의뢰 기한이 다 되었네요.")
        DialogSay("엘라라", "Default", "이번 작전은 아쉽지만 여기까지네요.")
        await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
        LuaApi:SetNpcState(EL, ENpcState.None)
        SetQuestState("Failed")
    end

    if (LuaApi:IsAllTaskAchieved() == true) then -- 퀘스트 완료 가능 상태일 때
        await(LuaApi.OpenDialogAsync())       -- 다이얼로그 시작
        DialogSay("엘라라", "Default", "잘해냈어요. 이제 안티키테라에서 장비를 제작해보세요.")
        DialogSay("엘라라", "Default", "앞으로 임무에서도 이것저것 모아보세요. 안티키테라가 굉장한 장비들을 만들어줄 거에요.")

        await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	
        LuaApi:SetNpcState(EL, ENpcState.None)
        SetQuestState("Completed")
    end
end
