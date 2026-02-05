local QUEST_ID = 810800
local START_NPC = "펠릭"
local START_TITLE = "<Key:LLoungeQ_810800_START_TITLE> 팔척 귀신"
local START_PRIORITY = 1

-- 아이템 상수
local QUEST_ITEM_ID = 300016 -- 팔척 귀신 관련 아이템
local QUEST_ITEM_COUNT = 2
local REWARD_ITEM_ID = 221012 -- 보상 아이템
local REWARD_ITEM_COUNT = 1

-- 1. 시작 전 상태
function OnNotStarted()
	await(LuaApi:WaitDelayAsync(50)) 
	AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)
end

function StartDialog()

	StartDialog810800()


	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")	
	SetLoungeQuestState(QUEST_ID, "InProgress")	
end

-- 2. 진행 중 상태
function OnInProgress()
	await(LuaApi:WaitDelayAsync(50))

	if LuaApi:HasItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT) then
		SetLoungeQuestState(QUEST_ID, "NotCompleted")
	end
end

-- 3. 완료 가능 상태
function OnNotCompleted()
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
	if not LuaApi:HasItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT) then
		LuaApi:ShowSystemToastText("<Key:LLoungeQ_001>아이템이 부족합니다.")			
		await(LuaApi:CloseDialogAsync())
		SetLoungeQuestState(QUEST_ID, "InProgress")
		RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
		return
	end

	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "펠릭2", "Ha", "비움", "De", "펠릭2",	"<Key:LQuest_110101_04002>야호~! 신선한 저주가 아주 꽉꽉 들어 차있는걸?")
	MDSay("비움", "De", "펠릭2", "Ha", "비움", "De", "제이",	"<Key:LQuest_110101_04003>…")
	await(LuaApi:CloseDialogAsync())	
	
	LuaApi:RemoveItem(QUEST_ITEM_ID, QUEST_ITEM_COUNT)
	LuaApi:GiveItemToStorage(REWARD_ITEM_ID, REWARD_ITEM_COUNT)	
	LuaApi:ShowSystemToastText("<Key:LLoungeQ_810800_4001>목표 완료: 보상이 더스터에게 지급되었습니다.")
	
	SetLoungeQuestState(QUEST_ID, "Completed")
end

-- 4. 완료된 상태
function OnCompleted()
	await(LuaApi:WaitDelayAsync(50))
	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")
	RemoveLoungeDialog(START_NPC, QUEST_ID, "OnNotCompletedDialog")
end