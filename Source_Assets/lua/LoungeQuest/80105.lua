local QUEST_ID = 80105

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "오너"
local START_TITLE = "<Key:LLoungeQ_80105_START_TITLE> 시작"
local START_PRIORITY = 1
local COMPLETE_NPC = "오너"
local COMPLETE_TITLE = "<Key:LLoungeQ_80105_COMPLETE_TITLE> 끝"
local COMPLETE_PRIORITY = 1

function StartDialog()
	LuaApi:SetNpcNavigationActive(700005, false)

	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80105_1001>보여드릴 이야기는 일단 여기까지예요.")	
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80105_1002>더 넓은 세계, 더 많은 유물, 더 끔찍한 적, 그리고 더 기묘한 이야기들이 잔뜩 준비되어있으니 앞으로 기대해도 좋아요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80105_1003>물론 원한다면 주어진 세계에서 자유롭게 뛰어노는 것은 말리지 않겠어요. 더 가혹한 난이도로 시도해보는 것도 꽤 스릴있을 거예요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80105_1004>그럼, 다음 다이브에서 또 만나죠. 안녕.")
	
	await(LuaApi:CloseDialogAsync())
	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")	
	LuaApi:SetString(80105, "talk", "true")	
end

function OnNotStarted()
	SetLoungeQuestState(QUEST_ID, "InProgress")

end

function OnInProgress()
	
	if LuaApi:GetString(80105, "talk") ~= "true" then	
		LuaApi:SetNpcNavigationActive(700005, true)
		AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)	
	end
end

function OnNotCompleted()
end

function OnCompleted()
end