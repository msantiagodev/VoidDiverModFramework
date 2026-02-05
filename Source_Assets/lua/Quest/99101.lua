function OnLounge()
    OnLoungeCommon()
end

function OnStage()
    OnStageCommon()
end

function OnEvent(eventType, value)
    local step = LuaApi:GetStep();

    if (GetQuestState() == "NotCompleted") then
        if (eventType == E_Npc and value == CharacterIDs["엘라"]) then
            LuaApi:SetStep(10)
        end
    end

    if (step == 1) then
        if (eventType == E_Npc and value == CharacterIDs["루카"]) then
            LuaApi:SetStep(2)
        end
    end

    if (step == 2) then
        if (eventType == E_Npc and value == CharacterIDs["루카"]) then
            TalkToNPC()
        end
    end

    if (step == 3 and eventType == E_TaskAchieved) then
        CallTaskAchieved_A()
    end
end

function Step_00001()
    SetNpcStateByName("루카", ENpcState.QuestTalkable)
end

function Step_00002()             -- 캠페인 시작 시 (라운지, 엘라라)
    await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작	
    CenterDialogSay("루카", "Default", "미션 설명.")
    await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	

    SetNpcStateByName("루카", ENpcState.None)
    SetQuestState("InProgress")
    LuaApi:ShowSystemToastText("준비를 마친 후 다이빙 부스에 탑승하세요.")
end

function Step_00003()
    await(LuaApi:WaitDelayAsync(1500))
    RadioSay("엘라", "Default", "지시1")
    await(LuaApi:WaitDelayAsync(3000))
    RadioSay("엘라", "Default", "지시2")
end

function CallTaskAchieved_A()
    await(LuaApi:WaitDelayAsync(1000))
    RadioSay("엘라", "Default", "물건을 모두 확보했네요, 이제 탈출하면 되겠어요.")
end

function Step_00010()
    if (LuaApi:IsAllTaskAchieved() == false) then -- 퀘스트 완료 불가 상태일 때
        await(LuaApi.OpenDialogAsync())         -- 다이얼로그 시작
        CenterDialogSay("엘라", "Default", "저런, 의뢰 기한이 다 되었네요.")
        CenterDialogSay("엘라", "Default", "이번 작전은 아쉽지만 여기까지네요.")
        await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료

        SetNpcStateByName("엘라", ENpcState.None)
        SetQuestState("Failed")
    end

    if (LuaApi:IsAllTaskAchieved() == true) then -- 퀘스트 완료 가능 상태일 때
        await(LuaApi.OpenDialogAsync())       -- 다이얼로그 시작
        CenterDialogSay("엘라", "Default", "좋아요, 임무 완수!")
        await(LuaApi.CloseDialogAsync())      -- 다이얼로그 종료	

        SetNpcStateByName("엘라", ENpcState.None)
        SetQuestState("Completed")
    end
end
