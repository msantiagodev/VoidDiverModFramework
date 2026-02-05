-------------------- 이벤트 함수들 ---------------------

-- 1 ~ 99999 (LuaApi:SetStep 으로 값 변경 시 호출)
function Step_00001() end

-- 라운지 진입 시 호출
function OnLounge() end

-- 스테이지 진입 시 호출
function OnStage() end

-- 이벤트 발생시 호출 (ELuaEvent 참고)
-- (ELuaEvent, Value) Value LuaEvent 타입에 따라 다름
function OnEvent(eventType, value) end

--------------------- API 함수들 -----------------------
function CommonApis()
    LuaApi:IsHost()
    LuaApi:IsTutorial()
    LuaApi:SetIsTutorial(false)
    LuaApi:SendTutorialEvent("TutorialEvent")

    -- 행동력 가져오기
    LuaApi:GetActionPoint()

    -- 모든 테스크가 달성 된 상태인지
    LuaApi:IsAllTaskAchieved()

    -- 내 플레이어 캐릭터 ID
    LuaApi:GetCharacterId()

    -- 내 캐릭터 위치/방향 Vector3 리턴
    LuaApi:GetCharacterPosition()
    LuaApi:GetCharacterForward()

    -- 내 캐릭터에 1001 버프 부여
    LuaApi:AddCharacterBuff(1001)

    -- 1001 ZoneSpawnId 위치로 가져오기 (Vector3 리턴)
    LuaApi:GetZoneSpawnPosition(1001)

    -- (오브젝트 타입, TriggerId, CanTriggered)
    LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 1, true)

    -- (오브젝트 타입, WaveId, CanTriggered)
    LuaApi:SetTriggerable(ETriggerableObjectType.WaveExecutor, 1001, true)

    -- 3000ms 대기
    await(LuaApi:WaitDelayAsync(3000))

    -- Lua 전용 Event (value:Lua 에서 쓰고 싶은 값)
    LuaApi:TriggerEventToAll(100)

    -- SFX 사운드
    LuaApi:PlaySfx("TempSfx");
    LuaApi:StopSfx("TempSfx");

    -- Ping (Alert, Notice 만 가능)
    LuaApi:PlayPing("알라라", EPingType.Alert, { x = 1.0, y = 0.0, z = 2.0 })

    -- 인벤토리 아이템 함수 (아이템 ID, 개수)
    LuaApi:GiveItem(10001, 1)
    LuaApi:RemoveItem(10001, 1)
    LuaApi:HasItem(10001)    -- 아이템이 1개 이상 있는지 여부
    LuaApi:HasItem(10001, 4) -- 아이템이 4개 이상 있는지 여부
    LuaApi:GetItemCount(10001)
    LuaApi:GiveItemToStorage(10001, 1)

    -- 인벤토리 장비 함수 (장비 ID, 개수)
    LuaApi:GiveEquipment(10001, 1)
    LuaApi:RemoveEquipment(10001, 1)
    LuaApi:HasEquipment(10001)    -- 장비 1개 이상 있는지 여부
    LuaApi:HasEquipment(10001, 4) -- 장비 4개 이상 있는지 여부
    LuaApi:GetEquipmentCount(10001)
    LuaApi:GiveEquipmentToStorage(10001, 1)

    -- 로그 함수
    LuaApi:LogDebug("디버깅 로그")
    LuaApi:LogInfo("디버깅 로그")
    LuaApi:LogWarning("디버깅 로그")
    LuaApi:LogError("디버깅 로그")

    -- 값 가져오기 관련
    LuaApi:GetString(10001, "Key")
    LuaApi:GetInt(10001, "Key")
    LuaApi:GetFloat(10001, "Key")
    LuaApi:GetBool(10001, "Key")

    -- 값 저장 관련
    LuaApi:SetString(10001, "Key", "Value")
    LuaApi:SetInt(10001, "Key", 1001)
    LuaApi:SetFloat(10001, "Key", 10.01)
    LuaApi:SetBool(10001, "Key", true)

    -- 값 저장 관련 (일시적인 값)
    LuaApi:SetTempString(10001, "Key", true)
    LuaApi:SetTempInt(10001, "Key", 1001)
    LuaApi:SetTempFloat(10001, "Key", 10.01)
    LuaApi:SetTempBool(10001, "Key", true)

    -- 값 삭제 관련
    LuaApi:RemoveKey(10001)
    LuaApi:RemoveValue(10001, "Key")

    -- 퀘스트/미션 LuaProgress 조건 일경우 진행도 설정 (Key, Progress)
    LuaApi:SetProgress(10001, 1)

    -- 노트 팝업 표시 (새 노트 시스템)
    -- Letter, Document, Note, Envelope
    await(LuaApi:OpenNoteSystemPopup({ "TextKey", "TextKey2" }, ENoteType.Letter))

    -- 캠패인 완료 여부
    LuaApi:IsClearedCampaign(10001);

    -- BGM 재생
    LuaApi:PlayBgm("bgmName")

    -- HP / Stress/ LightFuel
    LuaApi:SetCharacterHp(200)
    LuaApi:SetCharacterStress(50)
    LuaApi:SetCharacterLightFuel(0)

    -- 인게임 허드 제어
    LuaApi:SetInGameHudActive(true)

    -- 패러독스 추가
    LuaApi:AcquireParadox(10001, false, false) -- 10001 번 패러독스 추가
    LuaApi:AcquireParadox(0, true, false) -- 긍정 패러독스 추가
    LuaApi:AcquireParadox(0, false, true) -- 부정 패러독스 추가
    LuaApi:AcquireParadox(0, true, true) -- (긍정 or 부정) 패러독스 추가

    -- 패러독스 삭제
    LuaApi:RemoveParadox(10001, false, false) -- 패러독스 10001 번 삭제
    LuaApi:RemoveParadox(0, true, false) -- 긍정 패러독스 삭제
    LuaApi:RemoveParadox(0, false, true) -- 부정 패러독스 삭제
    LuaApi:RemoveParadox(0, true, true) -- (긍정 or 부정) 패러독스 삭제
end

function QuestApis()
    LuaApi:GetStep()
    LuaApi:SetStep(1)
    LuaApi:GetQuestState()
    LuaApi:SetQuestState(ECampaignQuestState.InProgress)

    -- 퀘스트 강제 시작, 탈출 및 타이틀 복귀
    LuaApi:ForceStartStage()
    LuaApi:ForceEscapeStage()
    LuaApi:ForceReturnToTitle()
end

function MissionApis()
    -- ex> MissionId: 10001
    LuaApi:GetMissionStep(10001)
    LuaApi:SetMissionStep(10001, 1)
    LuaApi:GetMissionState(10001)
    LuaApi:SetMissionState(10001, EMissionState.InProgress)
end

function ShowTextApis()
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "블라블라블라!")
	LuaApi:ShowMonologueText(ESpeaker.Player, -1, "블라블라블라!")
	LuaApi:ShowRadioText(ESpeaker.Player, -1, "Default", "블라블라블라!")

	LuaApi:ShowSystemToastText("블라블라블라!")
end

function DialogApis()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	await(LuaApi.OpenDialogAsync(1)) -- 다이얼로그 시작 (배경 알파값 0~1 사용)

	-- 질문한 결과 값을 가지고 싶은 경우
	local speakers = {
		DialogSpeakerEntry(ESpeaker.Character, 100001, "100001"),
		DialogSpeakerEntry(ESpeaker.Npc, 700009, "700009"),
		DialogSpeakerEntry(ESpeaker.Character, 100001, "100001"),
	}

	local speakerIndex = 1
	local message = "1. 무엇을 도와드릴까요?"
	local selectableMessages = { "나가기", "떠나기" }

	local selectedIndex = await(LuaApi:AppendDialogAsync(speakers, speakerIndex, message, selectableMessages))
	LuaApi:LogInfo("선택된 다이얼로그 메시지 인덱스: " .. tostring(selectedIndex))

	local speakers2 = {
		DialogSpeakerEntry(ESpeaker.Character, 100001, "100001"),
		DialogSpeakerEntry(ESpeaker.None, 0, nil),
		DialogSpeakerEntry(ESpeaker.None, 0, nil),
	}

	-- 다이얼로그 딜레이
	await(LuaApi:DelayDialogAsync(1000)) -- 1000ms 딜레이

	-- 질문이 없는 경우
	LuaApi:AppendDialogAsync(speakers2, 0, "2. 무엇을 도와드릴까요?", nil)

	-- 배경 이미지 세팅 (이미지명, front인지 여부, 인덱스 0~5)
	LuaApi:SetDialogCustomImageAsync("de_title", false, 0)
	-- 배경 이미지 전부 삭제
	LuaApi.ClearAllDialogCustomImagesAsync()
    -- 배경 이미지 삭제(front인지 여부, 인덱스 0~5)
    LuaApi:ClearDialogCustomImageAsync(true, 1)
	-- 다이얼로그 fade in/out
	LuaApi.FadeInDialog()
	LuaApi.FadeOutDialog()

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	
end

function ObjectApis()
	-- Npc 함수들 
	LuaApi:SetNpcState(10001, ENpcState.QuestTalkable)
	LuaApi:SpawnNpc(10001, { x = 1.0, y = 0.0, z = 2.0 }) --호스트 전용
	LuaApi:DespawnNpc(10001) --호스트 전용
	LuaApi:GetNpcPosition(10001)
    LuaApi:SetNpcNavigationActive(10001, true)

	--게스트 함수
	LuaApi:SpawnGuest(10001, { x = 1.0, y = 0.0, z = 2.0 }) --호스트 전용

	-- (MonsterId, 좌표)
	LuaApi:SpawnMonster(10001, { x = 1.0, y = 0.0, z = 2.0 })

	-- (ExitId, 좌표)
	LuaApi:SpawnExit(2001, { x = 1.0, y = 0.0, z = 2.0 })

	-- (Item Id, Count,  좌표)
	LuaApi:SpawnDropItem(10001, 100, { x = 1.0, y = 0.0, z = 2.0 })

	-- (RewardBoxId, 좌표)
	LuaApi:SpawnRewardBox(10001, { x = 1.0, y = 0.0, z = 2.0 })

	-- (Id:Lua 에서 발급, 좌표)
	LuaApi:SpawnPointerArrow(10001, { x = 1.0, y = 0.0, z = 2.0 })

	-- (Id:Lua 에서 발급, Marker prefab 이름, 좌표)
	LuaApi:SpawnMiniMapMarker(10001, "QuestMarker", { x = 1.0, y = 0.0, z = 2.0 })

	-- (MonsterId)
	LuaApi:GetMonsterCount(1001)

	-- (발급 된 TriggerableObjectId)
	LuaApi:GetTriggerableObjectPosition(1001)
end

--LuaApi:SpawnMiniMapMarker(10001, "QuestMarker", { x = 1.0, y = 0.0, z = 2.0 })
--LuaApi:DespawnMiniMapMarker(10001)

--SpawnPointerArrow(id, position)
--DespawnPointerArrow(id)
