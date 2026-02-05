local QUEST_ID = 811500
local START_NPC = "핌핌"
local START_TITLE = "<Key:LLoungeQ_811500_START_TITLE> 희미한 이상현상 잔해"
local START_PRIORITY = 1

-- 아이템 상수
local QUEST_ITEM_ID = 10003 -- 희미한 이상현상 잔해
local QUEST_ITEM_COUNT = 5
local REWARD_ITEM_ID = 22014 -- 보상 아이템
local REWARD_ITEM_COUNT = 1

-- 1. 시작 전 상태
function OnNotStarted()
	-- [수정] 함수 정의 대신 직접 호출 (문법 오류 수정)
	await(LuaApi:WaitDelayAsync(50)) 

	AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)
end

function StartDialog()

	StartDialog811500()
	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")	
	SetLoungeQuestState(QUEST_ID, "InProgress")	
end

-- 2. 진행 중 상태
function OnInProgress()
	-- [수정] 직접 호출
	await(LuaApi:WaitDelayAsync(50))

	if LuaApi:HasItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT) then
		SetLoungeQuestState(QUEST_ID, "NotCompleted")
	end
end

-- 3. 완료 가능 상태
function OnNotCompleted()
	-- [수정] 직접 호출
	await(LuaApi:WaitDelayAsync(50))

	if LuaApi:HasItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT) then

		RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
		AddLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog", "Complete", "<Key:LLoungeQ_complete>완료", START_PRIORITY)
	else
		RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
		SetLoungeQuestState(QUEST_ID, "InProgress")
	end
end

function OnNotCompletedDialog()
	-- 대화 진입 시점 최종 확인
	if not LuaApi:HasItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT) then
		await(LuaApi:CloseDialogAsync())
		LuaApi:ShowSystemToastText("<Key:LLoungeQ_001>아이템이 부족합니다.")	
		SetLoungeQuestState(QUEST_ID, "InProgress")
		RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
		return
	end

	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_811500_3001>상태가 괜찮군, 이거면 됐어.")
	await(LuaApi:CloseDialogAsync())	
	
	LuaApi:RemoveItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT)
	LuaApi:GiveEquipmentToStorage(REWARD_ITEM_ID, REWARD_ITEM_COUNT)	
	LuaApi:ShowSystemToastText("<Key:LLoungeQ_811500_4001>목표 완료: 보상이 더스터에게 지급되었습니다.")
	
	SetLoungeQuestState(QUEST_ID, "Completed")
end

-- 4. 완료된 상태
function OnCompleted()
	-- [수정] 직접 호출
	await(LuaApi:WaitDelayAsync(50))

	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")
	RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
end