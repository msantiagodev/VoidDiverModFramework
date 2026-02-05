-- Common.lua (Formatted)

function await(task)
	while not task.IsCompleted do
		coroutine.yield()
	end
	return task.Result
end

-- 기본 Enum 테이블 정의
ESpeaker = {
	None = 0,
	Player = 1,
	Character = 2,
	Npc = 3,
	Monster = 4
}

ENpcState = {
	None = 0,
	QuestTalkable = 1,
	QuestCompletable = 2
}

ECampaignQuestState = {
	None = 0,
	NotStarted = 1,
	InProgress = 2,
	NotCompleted = 3,
	Completed = 4,
	Failed = 5
}

EMissionState = {
	None = 0,
	NotStarted = 1,
	InProgress = 2,
	NotCompleted = 3,
	Completed = 4,
	Failed = 5
}

ELoungeQuestState = {
	None = 0,
	NotStarted = 1,
	InProgress = 2,
	NotCompleted = 3,
	Completed = 4
}

ETriggerableObjectType = {
	None = 0,
	Triggerable = 1,
	WaveExecutor = 2,
}

ELuaEvent = {
	None = 0,

	-- 상호 작용 오브젝트
	NpcInteraction = 1,      -- Value: NpcId
	TriggerInteraction = 2,  -- Value: TriggerId

	-- 충돌 오브젝트
	CollisionTriggerEnter = 101, -- Value: TriggerId

	-- 기타
	MonsterKill = 201,         -- Value: MonsterId
	WaveStarted = 202,         -- Value: WaveId
	WaveFailed = 203,          -- Value: WaveId
	WaveCleared = 204,         -- Value: WaveId
	ArtifactDeal = 205,        -- Value: GuestId

	QuestStateChanged = 221,   -- Value: ECampaignQuestState
	QuestTaskAchieved = 222,   -- Value: QuestTaskId

	MissionStateChanged = 231, -- Value: EMissionState
	MissionTaskAchieved = 232, -- Value: (x)

	LoungeQuestStateChanged = 241, -- Value: LoungeQuestId

	Custom = 999,              -- Value: Custom Value
}

EPingType = {
	Notice = 21,
	Alert = 31
}

ENoteType = {
	None = 0,
	Letter = 1,
	Document = 2,
	Note = 3,
	Envelope = 4,
	LetterAndEnvelope = 5,
	A4 = 6,
	Memo = 7,
	Parchment = 8,
	SpringNote = 9,
	VoiceRecord = 10,
}

------------------------------------------------------------------
-- [수정된 부분] 이벤트 타입 전역 변수 선언
-- 이제 다른 스크립트에서 'ELuaEvent.' 없이 바로 이벤트 이름을 사용할 수 있습니다.
------------------------------------------------------------------

	E_Npc = ELuaEvent.NpcInteraction
	E_Trigger = ELuaEvent.TriggerInteraction
	E_Collision = ELuaEvent.CollisionTriggerEnter
	E_MonsterKill = ELuaEvent.MonsterKill
	E_WaveStarted = ELuaEvent.WaveStarted
	E_WaveFailed = ELuaEvent.WaveFailed
	E_WaveCleared = ELuaEvent.WaveCleared
	E_QuestStateChanged = ELuaEvent.QuestStateChanged
	E_TaskAchieved = ELuaEvent.QuestTaskAchieved
	E_Custom = ELuaEvent.Custom
	E_MissionTaskAchieved = ELuaEvent.MissionTaskAchieved
	E_ArtifactDeal = ELuaEvent.ArtifactDeal
	E_LoungeQuestStateChanged = ELuaEvent.LoungeQuestStateChanged

------------------------------------------------------------------

function SetQuestState(stateName)
	-- ECampaignQuestState 테이블에서 문자열 이름에 해당하는 숫자 값을 찾습니다.
	local stateValue = ECampaignQuestState[stateName]

	if stateValue ~= nil then
		-- 유효한 상태 이름이라면, 찾아낸 숫자 값을 사용하여 원래 API 함수를 호출합니다.
		LuaApi:SetQuestState(stateValue)
	else
		-- 만약 ECampaignQuestState 테이블에 없는 잘못된 상태 이름을 전달했다면 경고를 출력합니다.
		print("경고: SetQuestState - 유효하지 않은 퀘스트 상태 이름('" .. tostring(stateName) .. "')이 전달되었습니다.")
	end
end

function GetQuestState()
	-- API를 통해 현재 퀘스트 상태의 숫자 값을 가져옵니다.
	local currentStateValue = LuaApi:GetQuestState()

	-- ECampaignQuestState 테이블을 순회하여 숫자 값에 해당하는 문자열 키(Key)를 찾습니다.
	for stateName, stateValue in pairs(ECampaignQuestState) do
		if stateValue == currentStateValue then
			return stateName -- 일치하는 상태 이름을 문자열로 반환합니다.
		end
	end

	-- 만약 ECampaignQuestState 테이블에 없는 값을 반환받았다면 경고를 출력하고 nil을 반환합니다.
	print("경고: GetQuestState() - 알 수 없는 퀘스트 상태 값입니다: " .. tostring(currentStateValue))
	return nil
end

------------------------------------------------------------------
-- LoungeQuest 헬퍼 함수
------------------------------------------------------------------

function SetLoungeQuestState(loungeQuestId, stateName)
	local stateValue = ELoungeQuestState[stateName]

	if stateValue ~= nil then
		LuaApi:SetLoungeQuestState(loungeQuestId, stateValue)
	else
		print("경고: SetLoungeQuestState - 유효하지 않은 상태 이름('" .. tostring(stateName) .. "')이 전달되었습니다.")
	end
end

function GetLoungeQuestState(loungeQuestId)
	local currentStateValue = LuaApi:GetLoungeQuestState(loungeQuestId)

	for stateName, stateValue in pairs(ELoungeQuestState) do
		if stateValue == currentStateValue then
			return stateName
		end
	end

	print("경고: GetLoungeQuestState() - 알 수 없는 상태 값입니다: " .. tostring(currentStateValue))
	return nil
end

function GetLoungeQuestProgress(loungeQuestId)
	return LuaApi:GetLoungeQuestProgress(loungeQuestId)
end

function GetLoungeQuestGoal(loungeQuestId)
	return LuaApi:GetLoungeQuestGoal(loungeQuestId)
end

function AddLoungeDialog(npc, questId, functionName, purpose, title, priority)
	if npc == nil then
		return
	end
	local luaKey = "LoungeQuest/" .. questId
	LuaApi:AddDialog(CharacterIDs[npc], {
		Title = title or "Title",
		Type = "Lounge",
		Priority = priority or 1,
		LuaKey = luaKey,
		FunctionName = functionName,
		Purpose = purpose
	})
end

function RemoveLoungeDialog(npc, questId, functionName)
	if npc == nil then
		return
	end
	local luaKey = "LoungeQuest/" .. questId
	LuaApi:RemoveDialog(CharacterIDs[npc], luaKey, functionName)
end

------------------------------------------------------------------
-- 공용 ID 및 헬퍼 함수
------------------------------------------------------------------

--[[
	1. 이름-ID 연결 테이블
	- 모든 캐릭터와 NPC의 이름과 고유 ID를 여기에 정의합니다.
	- DialogSay, RadioSay 등의 함수가 이 테이블을 참조하여 ID를 찾습니다.
]]
CharacterIDs = {

	["셰이"] = 700101,
	["도어"] = 700102,	
	["가영"] = 100001,
	["레온"] = 100002,
	["헤드"] = 100003,
	["미오"] = 100004,

	["엘라"] = 700000,
	["루카"] = 700001,
	["안티"] = 700002,
	["에블"] = 700003,
	["쇼파"] = 700004,
	["오너"] = 700005,	
	["에드"] = 700006,
	["펠릭"] = 700008,

	["부엉"] = 700011,
	["게이"] = 700012,
	["거울"] = 700013,
	["더스"] = 700014,	
	["핌핌"] = 700015,
	["집무"] = 700102,
	["혼령"] = 700105,	
	["엘라2"] = 700300,
	["루카2"] = 700301,
	["에블2"] = 700303,
	["에드2"] = 700306,
	["펠릭2"] = 700308,

	["아서"] = 700401,
	["아서2"] = 700402,

	["엑스"] = 700010,
	["아주"] = 700200,
	["재현"] = 700201,
	["조이"] = 700202,
	["사도"] = 700203,
	["평사"] = 700204,
	["고사"] = 700205,
	["악마"] = 700206,
	["마스"] = 700207,
	["좀요"] = 700208,
	["상인"] = 700209,
	["좀의"] = 700210,
	["좀간"] = 700211,
	["좀공"] = 700212
	
}

-- ====================================================================================================
-- [신규] NPC 상태 설정 헬퍼 함수 (이름 사용)
-- 기능: NPC의 이름(문자열)을 사용하여 상태를 변경합니다.
-- 사용법: SetNpcStateByName("NPC이름", ENpcState.상태)
-- 예시: SetNpcStateByName("엘라", ENpcState.QuestTalkable)
-- ====================================================================================================

function SetNpcStateByName(npcName, npcState)
	-- CharacterIDs 테이블에서 NPC 이름에 해당하는 숫자 ID를 찾습니다.
	local npcId = CharacterIDs[npcName]

	if npcId ~= nil then
		-- 유효한 이름이라면, 찾아낸 숫자 ID를 사용하여 원래 API 함수를 호출합니다.
		LuaApi:SetNpcState(npcId, npcState)
	else
		-- 만약 CharacterIDs 테이블에 없는 잘못된 NPC 이름을 전달했다면 경고를 출력합니다.
		print("경고: SetNpcStateByName - 알 수 없는 npcName 입니다: " .. tostring(npcName))
	end
end

function RadioSay(speakerName, emotion, text)
	local speakerType
	local idForApi
	local currentEmotion = emotion or "Default"

	-- [수정] 화자가 '제이'인지 먼저 확인
	if speakerName == "제이" then
		speakerType = ESpeaker.Player
		idForApi = -1
	else
		-- '제이'가 아닐 경우, 기존 로직 수행
		local speakerId = CharacterIDs[speakerName]
		if not speakerId then
			print("경고: RadioSay - 알 수 없는 speakerName 입니다: " .. tostring(speakerName))
			return
		end

		if speakerId >= 700000 and speakerId <= 799999 then
			speakerType = ESpeaker.Npc
			idForApi = speakerId
		elseif speakerId >= 100000 and speakerId <= 699999 then
			speakerType = ESpeaker.Character
			idForApi = speakerId
		else
			print("경고: RadioSay - 알 수 없는 speakerId 형식입니다 - " .. tostring(speakerId))
			-- ID 형식이 잘못되었을 경우, 기본값으로 NPC를 사용하거나 아니면 여기서 함수를 종료할 수 있습니다.
			-- 여기서는 일단 NPC로 처리합니다.
			speakerType = ESpeaker.Npc
			idForApi = speakerId
		end
	end

	-- 최종적으로 API 호출
	LuaApi:ShowRadioText(speakerType, idForApi, currentEmotion, text)
	LuaApi:PlaySfx("Radio")
end

-- 말풍선 텍스트 출력 헬퍼
function BubbleSay(speakerName, text)
	local speakerId = CharacterIDs[speakerName]
	if not speakerId then
		print("경고: BubbleSay - 알 수 없는 speakerName 입니다: " .. tostring(speakerName))
		return
	end

	local speakerType
	local idForApi

	if speakerId >= 700000 and speakerId <= 799999 then
		speakerType = ESpeaker.Npc
		idForApi = speakerId
	elseif speakerId >= 100000 and speakerId <= 699999 then
		speakerType = ESpeaker.Character
		idForApi = -1
	else
		print("경고: BubbleSay - 알 수 없는 speakerId 형식입니다 - " .. tostring(speakerId))
		speakerType = ESpeaker.Npc
		idForApi = speakerId
	end

	LuaApi:ShowBubbleText(speakerType, idForApi, text)
end

-- 독백 텍스트 출력 헬퍼
function MonologueSay(speakerName, text)
	local speakerId = CharacterIDs[speakerName]
	if not speakerId then
		print("경고: MonologueSay - 알 수 없는 speakerName 입니다: " .. tostring(speakerName))
		return
	end

	local speakerType
	local idForApi

	if speakerId >= 100000 and speakerId <= 699999 then
		speakerType = ESpeaker.Character
		idForApi = -1
	elseif speakerId >= 700000 and speakerId <= 799999 then
		speakerType = ESpeaker.Npc
		idForApi = speakerId
	else
		print("경고: MonologueSay - 알 수 없는 speakerId 형식입니다 - " .. tostring(speakerId))
		speakerType = ESpeaker.Character
		idForApi = -1
	end

	LuaApi:ShowMonologueText(speakerType, idForApi, text)
end

function OnLoungeCommon()
	LuaApi:LogInfo("OnLounge 함수가 호출되었습니다.")
	local step = LuaApi:GetStep();

	if (LuaApi:IsAllTaskAchieved() == true) then -- 태스크 전체가 완료된 상황인지 확인
		SetQuestState("NotCompleted")
		LuaApi:SetStep(10)	
		SetNpcStateByName("엘라", ENpcState.QuestCompletable)
		return
	end
	
	if (LuaApi:GetActionPoint() == 0 and LuaApi:IsAllTaskAchieved() == false) then -- 실패 상황
		SetQuestState("NotCompleted")
		SetQuestState("Failed")
		SetNpcStateByName("엘라", ENpcState.None)		
		return
	end

	if (step == 0) then
		LuaApi:SetStep(1)
	end
end

function OnLoungeCommonSub()
	LuaApi:LogInfo("OnLounge 함수가 호출되었습니다.")
	local step = LuaApi:GetStep();

	if (LuaApi:IsAllTaskAchieved() == true) then -- 태스크 전체가 완료된 상황인지 확인
		SetQuestState("NotCompleted")
		LuaApi:SetStep(10)
		return
	end
	
	if (LuaApi:GetActionPoint() == 0 and LuaApi:IsAllTaskAchieved() == false) then -- 실패 상황
		SetQuestState("NotCompleted")
		SetQuestState("Failed")
		SetNpcStateByName("엘라", ENpcState.None)		
		return
	end

	if (step == 0) then
		LuaApi:SetQuestState(2)
		await(LuaApi:WaitDelayAsync(3500))
		-- [1000번대]: 라운지 진행 기본 메시지
		LuaApi:ShowSystemToastText("<Key:LCommon_1001>준비를 마친 후 다이빙 부스에 탑승하세요.")
	end
end

function OnStageCommon()
	local step = LuaApi:GetStep();
	LuaApi:LogInfo("OnStage 함수가 호출되었습니다.")
	LuaApi:SetStep(3)
	if (GetQuestState() ~= "InProgress") then
		SetQuestState("InProgress")
		LuaApi:LogInfo("퀘스트를 강제로 진행중으로 변경합니다.")
	end
end

function ReadyAndStartToast()
	-- [1100번대]: 준비/시작 관련 토스트
	LuaApi:ShowSystemToastText("<Key:LCommon_1001>준비를 마친 후 다이빙 부스에 탑승하세요.")
end

function OnStep10CommonSub()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/QuestCommon",
		FunctionName = "QuestCompleteSub",
		Purpose = "Complete"
	})
end

-- ====================================================================================================
-- 다중 화자 다이얼로그 헬퍼 함수 (내부용)
-- ====================================================================================================
function _CreateMultiDialog(leftName, leftEmotion, centerName, centerEmotion, rightName, rightEmotion, speakerName,message)
	local function getIdByName(name)
		if name == nil or name == "None" or name == "비움" then
			return 0
		end
		return CharacterIDs[name] or 0
	end

	local leftId = getIdByName(leftName)
	local centerId = getIdByName(centerName)
	local rightId = getIdByName(rightName)
	local speakerId = getIdByName(speakerName)

	local function getSpeakerType(id)
		if id == 0 then
			return ESpeaker.None
		elseif id >= 700000 and id <= 799999 then
			return ESpeaker.Npc
		elseif id >= 100000 and id <= 699999 then
			return ESpeaker.Character
		else
			return ESpeaker.None
		end
	end

	local function getPortraitName(id, emotion)
		if id == 0 or emotion == nil then
			return nil
		end
		return tostring(id) .. "_" .. (emotion or "Default")
	end

	local speakers = {
		DialogSpeakerEntry(getSpeakerType(leftId), leftId, getPortraitName(leftId, leftEmotion)),
		DialogSpeakerEntry(getSpeakerType(centerId), centerId, getPortraitName(centerId, centerEmotion)),
		DialogSpeakerEntry(getSpeakerType(rightId), rightId, getPortraitName(rightId, rightEmotion)),
	}

	-- [수정] '제이'가 화자일 경우 speakerIndex를 -1로 설정하는 로직 추가
	local speakerIndex
	if speakerName == "제이" then
		speakerIndex = -1
	elseif speakerId == leftId and speakerId ~= 0 then
		speakerIndex = 0
	elseif speakerId == centerId and speakerId ~= 0 then
		speakerIndex = 1
	elseif speakerId == rightId and speakerId ~= 0 then
		speakerIndex = 2
	else
		LuaApi:LogError("DialogSay: 화자('" .. tostring(speakerName) .. "')를 찾을 수 없거나 유효하지 않습니다!")
		return nil
	end

	return speakers, speakerIndex, message
end

-- ====================================================================================================
-- [최종 수정] 다중 화자 다이얼로그 통합 함수
-- ====================================================================================================
function MultiDialogSay(leftName, leftEmotion, centerName, centerEmotion, rightName, rightEmotion, speakerName, message, selectableMessages)
	local speakers, speakerIndex, msg = _CreateMultiDialog(leftName, leftEmotion, centerName, centerEmotion, rightName, rightEmotion, speakerName, message)
	
	if speakers then
		if selectableMessages == nil then
			return await(LuaApi:AppendDialogAsync(speakers, speakerIndex, msg, nil))
		else
			return await(LuaApi:AppendDialogAsync(speakers, speakerIndex, msg, selectableMessages))
		end
	end
	return -1
end

-- ====================================================================================================
-- [추가] MDSay 헬퍼 함수 (단축형)
-- 기능: 표정(Emotion)을 앞 두 글자로 단축하여 입력할 수 있도록 가독성을 높인 함수입니다.
-- 사용법: MDSay(LName, LEmo, CName, CEmo, RName, REmo, Speaker, Message, SelectableMessages)
-- 예시: MDSay("비움", "De", "펠릭2", "De", "비움", "De", "펠릭2", "<Key:LQuest_…>", Choices)
-- ====================================================================================================

function MDSay(leftName, leftEmoShort, centerName, centerEmoShort, rightName, rightEmoShort, speakerName, message, selectableMessages)
	
	local function expandEmotion(short)
		if short == "De" then return "Default" end
		if short == "An" then return "Angry" end
		if short == "Sm" then return "Smile" end
		if short == "Sa" then return "Sad" end
		if short == "Af" then return "Afraid" end
		if short == "Ha" then return "Happy" end
		if short == "Su" then return "Surprised" end
		if short == "Pa" then return "Pain" end
		if short == "Cu" then return "Curious" end
		if short == "Co" then return "Comic" end
		
		-- 여기에 필요한 다른 표정 코드를 추가하세요.
		return "Default" -- 매칭되는 표정이 없으면 기본값으로 "Default" 사용
	end
	
	local leftEmotion = expandEmotion(leftEmoShort)
	local centerEmotion = expandEmotion(centerEmoShort)
	local rightEmotion = expandEmotion(rightEmoShort)

	-- 기존의 MultiDialogSay 함수를 호출하여 실제 다이얼로그 로직 실행
	return MultiDialogSay(leftName, leftEmotion, centerName, centerEmotion, rightName, rightEmotion, speakerName, message, selectableMessages)
end

-- ====================================================================================================
-- [최종 수정] 단일 화자 다이얼로그 헬퍼 함수
-- ====================================================================================================
function CenterDialogSay(speakerName, emotion, message, selectableMessages)
	return MultiDialogSay("비움", "Default", speakerName, emotion, "비움", "Default", speakerName, message,selectableMessages)
end

function GrantRandomItemReward()
	-- 1. 각 GradeType별 가중치 설정
	local gradeWeights = {
		Normal = 0,
		Rare = 35,
		Epic = 60,
		Legendary = 5
	}

	-- 3. GradeType별 Artifact 아이템 ID 목록 (동일함, 생략 가능하지만 전체 코드 유지를 위해 포함)
	local artifactLists = {
		Normal = {
			100003, 100005, 100009, 100015, 100017, 100021, 100025, 100029, 100033, 100037,
			100041, 100045, 100047, 100053, 100057, 100061, 100065, 100071, 100075, 100081,
			100085, 100089, 100093, 100097, 100103, 100107, 100111, 100115, 100117, 100121,
			100127, 100131, 100135, 100139, 100143, 100147, 100153, 100157, 100159, 100165,
			100169, 100173, 100175, 100181, 100187, 100191, 100193, 100197, 100201, 100203,
			100209, 100215, 100219, 100221, 100225, 100229, 100233, 100237, 100243, 100247,
			100249, 100253, 100257, 100259, 100265, 100269, 100273, 100277, 100281, 100283,
			100291, 100295, 100299, 100305, 100307, 100309, 100313
		},
		Rare = {
			100004, 100006, 100010, 100016, 100018, 100022, 100026, 100030, 100034, 100038,
			100042, 100046, 100048, 100054, 100058, 100062, 100066, 100072, 100076, 100082,
			100086, 100090, 100094, 100098, 100104, 100108, 100112, 100116, 100118, 100122,
			100128, 100132, 100136, 100140, 100144, 100148, 100154, 100158, 100160, 100166,
			100170, 100174, 100176, 100182, 100188, 100192, 100194, 100198, 100202, 100204,
			100210, 100216, 100220, 100222, 100226, 100230, 100234, 100238, 100244, 100248,
			100250, 100254, 100258, 100260, 100266, 100270, 100274, 100278, 100282, 100284,
			100292, 100296, 100300, 100306, 100308, 100310, 100314
		},
		Epic = {
			100001, 100007, 100011, 100013, 100019, 100023, 100027, 100031, 100035, 100039,
			100043, 100049, 100051, 100055, 100059, 100063, 100067, 100069, 100073, 100077,
			100079, 100083, 100087, 100091, 100095, 100099, 100101, 100105, 100109, 100113,
			100119, 100123, 100125, 100129, 100133, 100137, 100141, 100145, 100149, 100151,
			100155, 100161, 100163, 100167, 100171, 100177, 100179, 100183, 100185, 100189,
			100195, 100199, 100205, 100207, 100211, 100213, 100217, 100223, 100227, 100231,
			100235, 100239, 100241, 100245, 100251, 100255, 100261, 100263, 100267, 100271,
			100275, 100279, 100285, 100287, 100289, 100293, 100297, 100301, 100303, 100311,
			100315
		},
		Legendary = {
			100002, 100008, 100012, 100014, 100020, 100024, 100028, 100032, 100036, 100040,
			100044, 100050, 100052, 100056, 100060, 100064, 100068, 100070, 100074, 100078,
			100080, 100084, 100088, 100092, 100096, 100100, 100102, 100106, 100110, 100114,
			100120, 100124, 100126, 100130, 100134, 100138, 100142, 100146, 100150, 100152,
			100156, 100162, 100164, 100168, 100172, 100178, 100180, 100184, 100186, 100190,
			100196, 100200, 100206, 100208, 100212, 100214, 100218, 100224, 100228, 100232,
			100236, 100240, 100242, 100246, 100252, 100256, 100262, 100264, 100268, 100272,
			100276, 100280, 100286, 100288, 100290, 100294, 100298, 100302, 100304, 100312,
			100316
		}
	}

	-- 4. 가중치 기반 랜덤 선택 로직
	local totalWeight = 0
	local weightedGrades = {}

	for grade, weight in pairs(gradeWeights) do
		local itemList = artifactLists[grade]
		if itemList and #itemList > 0 and weight > 0 then
			totalWeight = totalWeight + weight
			table.insert(weightedGrades, { grade = grade, weight = weight })
		end
	end

	if totalWeight == 0 then
		LuaApi:LogError("GrantRandomArtifactByGrade: 뽑을 수 있는 아티팩트가 없거나 가중치가 모두 0입니다.")
		return
	end

	local randomNum = math.random(1, totalWeight)
	local cumulativeWeight = 0
	local selectedGrade = nil

	for _, gradeInfo in ipairs(weightedGrades) do
		cumulativeWeight = cumulativeWeight + gradeInfo.weight
		if randomNum <= cumulativeWeight then
			selectedGrade = gradeInfo.grade
			break
		end
	end

	-- 5. 선택된 등급 내에서 무작위 아이템 ID 선택
	local selectedItemList = artifactLists[selectedGrade]
	if not selectedItemList or #selectedItemList == 0 then
		LuaApi:LogError("GrantRandomArtifactByGrade: 선택된 등급(" .. selectedGrade .. ")에 아이템 목록이 비어있습니다.")
		return
	end

	local randomIndex = math.random(1, #selectedItemList)
	local selectedItemId = selectedItemList[randomIndex]

	LuaApi:GiveEquipment(selectedItemId, 1)
	LuaApi:LogInfo("가중치 랜덤 아티팩트 지급: 등급(" .. selectedGrade .. "), 아이템 ID(" .. tostring(selectedItemId) .. ")")

	-- [중요] 여러 개의 로컬 키가 동시에 들어가지 않도록, 등급별 전체 문장 키를 따로 정의하여 사용합니다.
	-- [2000번대]: 아이템 보상 관련
	local messageKeys = {
		Normal = "<Key:LCommon_2001>Normal 등급의 유물을 획득했다.",
		Rare = "<Key:LCommon_2002>Rare 등급의 유물을 획득했다.",
		Epic = "<Key:LCommon_2003>Epic 등급의 유물을 획득했다.",
		Legendary = "<Key:LCommon_2004>Legendary 등급의 유물을 획득했다."
	}

	local finalMessage = messageKeys[selectedGrade] or (tostring(selectedGrade) .. " 등급의 유물을 획득했다.")
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, finalMessage)
end

function OnEventDoorInCampaign()
	-- [3000번대]: 이벤트 상호작용 관련
	LuaApi:ShowBubbleText(ESpeaker.Npc, 700102, "<Key:LCommon_3001>지금 바빠요!")	
end

function PingToElara()

	await(LuaApi:WaitDelayAsync(700))
	-- [4000번대]: 핑 관련 (10단위로 구분)
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LCommon_4001>엘라라와 대화해야겠다.")
	local spawnPos = 	LuaApi:GetNpcPosition(CharacterIDs["엘라"])
	-- 핑 라벨 키는 고유하게 부여
	LuaApi:PlayPing("<Key:LCommon_4002>엘라라", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	

end

function PingToPhoneBooth()

	await(LuaApi:WaitDelayAsync(700))
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LCommon_4011>다이빙 부스로 가봐야겠다.")
	local spawnPos = 	LuaApi:GetNpcPosition(700105)
	LuaApi:PlayPing("<Key:LCommon_4012>엘라라", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	

end

function PingToLucas()

	await(LuaApi:WaitDelayAsync(700))
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LCommon_4021>루카스와 대화해야겠다.")
	local spawnPos = 	LuaApi:GetNpcPosition(CharacterIDs["루카"])
	LuaApi:PlayPing("<Key:LCommon_4022>루카스", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	

end

function PingToPelix()

	await(LuaApi:WaitDelayAsync(700))
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LCommon_4031>펠릭스와 대화해야겠다.")
	local spawnPos = 	LuaApi:GetNpcPosition(CharacterIDs["펠릭"])
	LuaApi:PlayPing("<Key:LCommon_4032>펠릭스", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	

end

function PingToMirror()

	await(LuaApi:WaitDelayAsync(700))
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LCommon_4041>나르시스에게 가봐야겠다.")
	local spawnPos = 	LuaApi:GetNpcPosition(CharacterIDs["거울"])
	LuaApi:PlayPing("<Key:LCommon_4042>엘라라", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	

end

function PingToDuster()

	await(LuaApi:WaitDelayAsync(700))
--	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LCommon_4051>더스터에게 가봐야겠다.")
	local spawnPos = 	LuaApi:GetNpcPosition(CharacterIDs["더스"])
	LuaApi:PlayPing("<Key:LCommon_4052>엘라라", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	

end

function PingToOnwer()

	await(LuaApi:WaitDelayAsync(700))
	LuaApi:ShowBubbleText(ESpeaker.Player, -1, "<Key:LCommon_4053>오너와 대화해야겠다.")
	local spawnPos = 	LuaApi:GetNpcPosition(CharacterIDs["오너"])
	LuaApi:PlayPing("<Key:LCommon_4054>오너", EPingType.Notice, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })	

end

------------------------------------------------------------------
-- [수정] 패러독스(랜덤 ID: 0) 관리 및 알림 헬퍼 함수
-- 인자 없이 호출하면 자동으로 랜덤(0)으로 처리하고 안내 메시지를 띄웁니다.
------------------------------------------------------------------

-- [5000번대]: 패러독스 관련

-- 1. 긍정 패러독스 획득 (랜덤)
function AcquirePositiveParadox()
	LuaApi:AcquireParadox(0, true, false)
	LuaApi:ShowSystemToastText("<Key:LCommon_5001>긍정 패러독스가 부여되었습니다.")
end

-- 2. 부정 패러독스 획득 (랜덤)
function AcquireNegativeParadox()
	LuaApi:AcquireParadox(0, false, true)
	LuaApi:ShowSystemToastText("<Key:LCommon_5002>부정 패러독스가 부여되었습니다.")
end

-- 3. 알 수 없는(긍정 or 부정) 패러독스 획득 (랜덤)
function AcquireRandomParadox()
	LuaApi:AcquireParadox(0, true, true)
	LuaApi:ShowSystemToastText("<Key:LCommon_5003>무작위 패러독스가 부여되었습니다.")
end

-- 4. 긍정 패러독스 제거 (랜덤)
function RemovePositiveParadox()
	LuaApi:RemoveParadox(0, true, false)
	LuaApi:ShowSystemToastText("<Key:LCommon_5004>긍정 패러독스가 제거되었습니다.")
end

-- 5. 부정 패러독스 제거 (랜덤)
function RemoveNegativeParadox()
	LuaApi:RemoveParadox(0, false, true)
	LuaApi:ShowSystemToastText("<Key:LCommon_5005>부정 패러독스가 제거되었습니다.")
end

-- 6. 알 수 없는(긍정 or 부정) 패러독스 제거 (랜덤)
function RemoveRandomParadox()
	LuaApi:RemoveParadox(0, true, true)
	LuaApi:ShowSystemToastText("<Key:LCommon_5006>패러독스가 제거되었습니다.")
end

function StartDialog810100()

	await(LuaApi:OpenDialogAsync(0))

	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810100_1001>가능하시다면 책 한 권을 가져다주셨으면 합니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810100_1002><color=#b91d1d>사이코패스 교화법</color>이라고 저자가 자신의 연구 대상에게 살해당한 사건으로 유명한 물건이지요.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810100_1003>교도소 접견실에서, 자신의 연구 대상이던 흉악범에게, 아주 끔찍하게 당했거든요.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "제이",	"<Key:LLoungeQ_810100_1004>(음? 그럼 교도관들은...)")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810100_1005>방심했던 겁니다. 흉기가 될 만한 물건은 없었으니까.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810100_1006>사건 당시 흉악범은 자신을 교화시킨 사이코패스 교화법의 저자에게 크게 감사해했다고 합니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810100_1007>감동한 저자는 막 출간된 그의 저서를 이 흉악범에게 선물하기로 했고…")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810100_1008>범인은 서명된 책을 건네받는 그 순간 저자의 손으로부터 펜을 낚아챘고, 그대로 푹, 푹, 푹…")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "제이",	"<Key:LLoungeQ_810100_1009>(묘하게 신난 말투네…)")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810100_1010>이만하면 눈치채셨을 겁니다. 의뢰품은 사건 당시 저자의 손에 들려 있던, 그래서 대량의 피가 눌어붙은 ‘사이코패스 교화법 초판’.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810100_1011>저자의 서명과 피 얼룩이 함께 담긴 세상에 단 하나밖에 없는 물건입니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810100_1012>물건은 주택가의 <color=#b91d1d>버려진 도서관</color> 내부에 있습니다. 부탁드립니다.")

	await(LuaApi:CloseDialogAsync())	

end

function StartDialog810101()

	await(LuaApi:OpenDialogAsync(0))

	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810101_1000>물건을 하나 더 부탁드려도 되겠습니까?")	
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810101_1001>이번에 가져다주셨으면 하는 물건은 <color=#b91d1d>비명 테이프</color>라고 합니다. 이야기하자면 조금 깁니다만…")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810101_1002>15년 전에 시작되어 약 7년간 이어졌던 부녀자 연쇄살인사건이 있었습니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810101_1003>무려 17건의 살인 사건이 벌어진 후에야 경찰은 마침내 용의자를 찾아냈죠. 하지만 범인은 순순히 체포될 생각이 없었습니다. 경찰이 들이닥치자 범인은 분신을 시도했습니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810101_1004>그런데 말입니다, 생각보다 화력이 약했던 탓에 범인은 쉽게 죽지 못했습니다. 때문에 한참 동안이나 고통에 몸부리치며 기괴한 비명을 질러댔지요.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810101_1005>테이프에는, 그 때 그 범인의 비명이 담겨있습니다. 대략 30분에 달하는, 아주 생생하게 살아있는 죽음의 소리죠.")

	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810101_1006>그리고 모종의 경로로 이 테이프를 손에 넣은 어떤 행동분석가는 실험을 하나 진행하기로 했습니다. 교도소 내의 흉악범들이 난동을 부릴 때마다 이 비명 테이프를 강제로 들려주었던 거죠.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810101_1007>그 결과… 실험 대상의 대부분이 채 10분을 못 버티고 잠잠해졌다고 합니다. 교화되었다기보다는 넋이 나가 미쳐 버린 것에 가까웠다는 말도 있습니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810101_1008>어찌 되었든 분명한 건 그 테이프 안에는 단순한 소음, 그 이상의 무언가가 담겨있다는 겁니다.")

	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_810101_1009>어쩌면 눈치채셨겠지만 그 행동분석가가 바로 '사이코패스 교화법'의 저자입니다.")	
	MDSay("비움", "De", "루카2", "De", "비움", "De", "제이",	"<Key:LLoungeQ_810101_1010>(흉악범들을 상대로 잔인한 실험을 했고, 그 결과 자신의 연구 대상에게 살해당했다는 거로군)")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810101_1011>물건은 주택가의 <color=#b91d1d>경찰서 내부</color>에 있습니다. 부탁드립니다.")

	await(LuaApi:CloseDialogAsync())	

end

function StartDialog810102()

	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810102_1001>창고 구석에서 먼지를 뒤집어쓰고 있는 '안티키테라 기계'를 보신 적 있습니까? 아주 매혹적인 장치지요.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810102_1002>무에서 유를 창조하는 기계… <color=#3d840e>아이템 제작</color>부터 잊힌 <color=#3d840e>기술 개발</color>까지. 그야말로 연금술사의 솥단지 같은 물건입니다.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810102_1003>하지만 아쉽게도 지금은 숨이 멎어 고철 덩어리에 불과합니다. 그런 명배우를 무대 뒤에 썩히는 건 예의가 아니죠.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810102_1004>제가 다시 그 심장을 뛰게 만들 수 있습니다. 다만… 약간의 '연료'가 필요하군요.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810102_1005>던전에서 흔해빠진 <color=#3d840e>잡동사니 더미</color> 10개. 그 정도면 멈춰버린 톱니바퀴를 다시 비명 지르게 하기에 충분할 겁니다. 부탁드리죠.")	
	await(LuaApi:CloseDialogAsync())	

end

function StartDialog810800()

	await(LuaApi:OpenDialogAsync(0))

    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810800_1000>부탁 하나만 해도 될까? 던전에 들어갔다가 기회가 되면 물건 하나만 가져다줄래?")
    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810800_1001>어쩌다가 고급 정보가 하나 들어왔는데 이게 꽤~ 귀한 물건이어서 말야. 위험한 주술이 걸려있는 물건이라 어떻게든 꼭 갖고 싶어졌거든.")
    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810800_1002>직접 나서고 싶지만 나도 급히 처리할 일이 들어왔지 뭐야. 게다가 그쪽 구역 녀석들하고는 이래저래 관계가 좀 복잡해.")
    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "제이",	"<Key:LLoungeQ_810800_1003>(해방의 목소리?)")

    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810800_1004>내가 원하는 건 팔척 귀신을 봉인했던 세 개의 봉인 주술품 중 하나인 도서관 출입증이야.")
    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810800_1005>아마도 팔척 귀신에게 희생당한 이의 물건에 주술을 걸어 봉인품으로 만든 거겠지.")
    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810800_1006>손상되지 않게 잘 회수해 주면 대신에 쓸만한 물건으로 보답할게.")
    MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810800_1007>참고로 팔척 귀신은 주택가의 <color=#b91d1d>저주받은 공터</color>에 있어.")

	await(LuaApi:CloseDialogAsync())	
end

function StartDialog810801()

	await(LuaApi:OpenDialogAsync(0))

	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1000>소울콜렉터에게서 회수해 줬으면 하는 물건이 있어. ")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1001><color=#b91d1d>녹슨 워크맨</color>이라고 불리는 물건인데 말이야...")
	
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "제이",	"<Key:LLoungeQ_810801_1002>(녹슨 워크맨... 고물상에나 있을 법한 물건인데.)")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1003>겉보기엔 평범한 구형 카세트 플레이어지. 작동도 안 될 것처럼 생겼지만... 문제는 그 안에 들어있는 '테이프'야.")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1004>원 주인은 던전에서 들려오는 환청을 견디지 못해 항상 이어폰을 꽂고 다니던 다이버였어. 음악 소리로 공포를 덮으려 했지.")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1005>하지만 어느 순간부터 테이프에선 음악 대신... 그가 산 채로 뜯어먹히며 내지른 '영혼의 파열음'이 녹음되기 시작했다더군.")
	
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1006>소울 콜렉터가 그 고물을 탐내는 이유? 놈에게는 그게 최고의 '명반'이거든. 영혼이 찢어지는 소리가 아주 선명한 음질로 담겨 있으니까.")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1007>어쨌든 조심해. 절대로 재생 버튼을 누르지 마. 그 소리를 듣는 순간, 네 영혼도 그 테이프의 '다음 트랙'으로 녹음되어 버릴지도 모르니까.")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_1008>소울 콜렉터는 주택가의 <color=#b91d1d>불길한 성역</color>에 있어.")

	await(LuaApi:CloseDialogAsync())	

end

function EndDialog810801()

	await(LuaApi:OpenDialogAsync(0))

	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_3001>호오, 이게 바로 녹슨 워크맨인가. 생각보다 상태가 좋은데?")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_3002>가만있어 봐. 안쪽에서 무슨 소리가 들리는 것 같은데.")
	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1000))	
	LuaApi:PlaySfx("MumblingWhisper")
	LuaApi.FadeInDialog()
	
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_3003>...들려? '열어줘... 말하고 싶어... 찬양하고 싶어...'")
	MDSay("비움", "De", "펠릭2", "Sm", "비움", "De", "펠릭2",	"<Key:LLoungeQ_810801_3004>수고했어. 이 녀석이 더 시끄럽게 떠들기 전에 봉인함에 넣어야겠어. 보수는 챙겨가라고.")
	await(LuaApi:CloseDialogAsync())	

end


function StartDialog811500()

	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_811500_1001>던전에 내려갈 생각이라면 의뢰 하나 할까.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_811500_1002>최근에 시장에서 <color=#3d840e>희미한 이상현상 잔해</color>의 가격이 오르고 있어. 일단은 5개 정도 필요한데, 구해다 줄 수 있겠나?")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_811500_1003>물건은 강력한 변종 몬스터들에게서 구할 수 있네. 모아놨다가 가져와. 섭섭지 않게 챙겨주지.")
	await(LuaApi:CloseDialogAsync())	

end

function StartDialog811501()

	await(LuaApi:OpenDialogAsync(0))

	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1000>구해다 줬으면 하는 물건이 하나 있는데...")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1001>혹시 경찰 서장 도노반에 대해 알고 있나?")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1002>그는 외우주 신봉자야. 10년 전 참사부터 이미 그랬지. 그 계기는 바로 <color=#b91d1d>무형의 지평선</color>이라네.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1003>(무형의 지평선?)")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1004>미술관에 떡하니 걸려 있으니 들어갈 수만 있다면 어렵지 않게 볼 수 있지만... 실은 그건 모작에 불과해. 진품은 서장이 가지고 있을 거야.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1005>진품 '무형의 지평선' 안에 담긴 것은 감히 인간은 상상조차 할 수 없는 압도적인 무언가라고 하지.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1006>절대적인 쾌락이자 고통이고 끝없는 행복이면서 동시에 절망…이라고 하더군.")	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "제이", 	"<Key:LLoungeQ_811501_1007>(음…)")
	
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1008>진품 '무형의 지평선'을 단 한 번이라도 보게 되면 반드시 매료되어 버리고 마는데, 그 말로는 결국 한 가지 밖에 없어… 운이 좋으면 하잘것없는 괴물이 되어 버리고, 운이 나쁘면…")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌", 	"<Key:LLoungeQ_811501_1009>외우주로 끌려가. 인간의 육체와 영혼이 버틸 수 있을 리 없으니 그 안에서 영원히 찢어발겨지는 거지.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",		"<Key:LLoungeQ_811501_1010>서장의 경우는 운이 좋았지, 괴물이 된 걸로 끝났으니. 물론, 하잘것없다는 건 외우주의 기준에서 그런 거고, 실제로 상대하려면 목숨을 걸어야 할 거야.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",		"<Key:LLoungeQ_811501_1011>조심해서 회수해주게. 절대 물건을 펼쳐보아서는 안 돼.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",		"<Key:LLoungeQ_811501_1012>물건은 잊혀진 주택가의 <color=#b91d1d>미술관 안</color>에 있어.")
	

	await(LuaApi:CloseDialogAsync())	

end

function EndDialog811501()

	await(LuaApi:OpenDialogAsync(0))

	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "엘라",	"<Key:LLoungeQ_811501_3001>이게 의뢰품인 '무형의 지평선'이로군요.")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3002>조심해, 실수로 펼쳐지기라도 하면 그날로 이 가게는 끝장이야.")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "엘라",	"<Key:LLoungeQ_811501_3003>앗, 잠깐. 그림 뒤에서 뭔가 떨어졌는데… 편지 같아요.")

	
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3004>어디 보자, 그림을 그린 화가가 쓴 건데. 상당히 겁에 질려있는 것 같군.")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3005>감히 외우주를 엿본 것을 크게 후회하고 있고… '그들'이 자신을 끌고 갈 거라는군.")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3006>나 스스로를 '무형의 지평선' 안에 가두어 둘 테니… 누군가 이 그림을 발견한다면 반드시 던전 안에서 불태워달라.")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3007>절대로 이 그림을 던전 밖으로 갖고 나가서는 안 된다.")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3008>내가 외우주의 공간에서 영원히 찢어 발겨지기를 원하지 않는다면 말이다.")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3009>…")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "엘라",	"<Key:LLoungeQ_811501_3010>…")
	
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	LuaApi:PlaySfx("PainterScream")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "제이",	"<Key:LLoungeQ_811501_3011>(기괴한 비명소리가 지나갔다.)")
	LuaApi.FadeOutDialog()				
	await(LuaApi:DelayDialogAsync(1500))	
	LuaApi.FadeInDialog()	
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "엘라",	"<Key:LLoungeQ_811501_3012>방금 무슨 소리 나지 않았어요?")
	MDSay("엘라", "De", "비움", "De", "핌핌", "De", "핌핌",	"<Key:LLoungeQ_811501_3013>음…")

	await(LuaApi:CloseDialogAsync())	

end