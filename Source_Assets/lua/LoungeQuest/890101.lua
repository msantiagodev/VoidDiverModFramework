local QUEST_ID = 890101
local START_NPC = "루카"
local START_TITLE = "<Key:LLoungeQ_890101_START_TITLE> 10년 전 사태에 대하여"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890101_1001>…그날 말씀이십니까? 아, 제 인생 최대의 오점이자 씻을 수 없는 아쉬움이죠. 그 거대한 파멸의 교향곡이 도시를 뒤덮을 때 하필이면 제가 그 '객석'에 없었거든요. ")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890101_1002>하늘이 찢어지는 굉음, 문명이 단말마를 내지르며 무너져 내리는 그 절경을… '라이브'로 보지 못했다니! 생각할수록 통탄할 노릇 아닙니까?")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890101_1003>제가 왜 이렇게 과거의 파편에 집착하겠습니까? 놓쳐버린 그날의 무대를… 이 남겨진 조각들로나마 상상 속에서 재현해보고 싶은 갈망 때문이죠. ")
	MDSay("비움", "De", "루카2", "De", "비움", "De", "루카2",	"<Key:LLoungeQ_890101_1004>다음번 종말이 올 때는, 반드시 1열에서 지켜보고 말 겁니다.")
	await(LuaApi:CloseDialogAsync())
end

function OnNotStarted()
	AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)
end

function StartDialog()
	CommonDialog()
	SetLoungeQuestState(QUEST_ID, "InProgress")
end

function OnInProgress()
	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")
	AddLoungeDialog(START_NPC, QUEST_ID, "InProgressDialog", "InProgress", START_TITLE, START_PRIORITY)
end

function InProgressDialog()
	CommonDialog()
end