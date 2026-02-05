local QUEST_ID = 810102
local START_NPC = "루카"
local START_TITLE = "<Key:LLoungeQ_810102_START_TITLE> 안티키테라 기계"
local START_PRIORITY = 1

-- 아이템 상수
local QUEST_ITEM_ID = 7000
local QUEST_ITEM_COUNT = 10

-- 1. 시작 전 상태
function OnNotStarted()
	-- [수정] 함수 정의 대신 직접 호출 (문법 오류 수정)
	await(LuaApi:WaitDelayAsync(50)) 

	AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)
end

function StartDialog()

	StartDialog810102()
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
		LuaApi:ShowSystemToastText("<Key:LLoungeQ_001>아이템이 부족합니다.")		
		await(LuaApi:CloseDialogAsync())
		SetLoungeQuestState(QUEST_ID, "InProgress")
		RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
		return
	end

	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810102_3001>훌륭합니다. 이 정도 분량이면 충분히 수리하고도 남겠군요.")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2", 	"<Key:LLoungeQ_810102_3002>자, 이제 안티키테라 기계가 깨어날 시간입니다. 그 기계가 토해낼 새로운 가능성들을… 마음껏 즐겨보십시오.")
	await(LuaApi:CloseDialogAsync())	
	
	LuaApi:RemoveItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT)
	SetLoungeQuestState(QUEST_ID, "Completed")
end

-- 4. 완료된 상태
function OnCompleted()
	-- [수정] 직접 호출
	await(LuaApi:WaitDelayAsync(50))

	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")
	RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
end