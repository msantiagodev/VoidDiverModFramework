local QUEST_ID = 891503
local START_NPC = "핌핌"
local START_TITLE = "<Key:LLoungeQ_891503_START_TITLE> 불법적인 일인데 리스크는?"
local START_PRIORITY = 1

function CommonDialog()
	await(LuaApi:OpenDialogAsync(0))
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891503_1001>없을 리가 있나. 하지만 생각해 봐. 이 일은 어디까지나 불법이니까 가능한 거야.")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891503_1002>유물을 합법적으로 수집해서 거래할 수 있다면 우리 같은 영세 상인들이 나설 자리가 있겠어? 게다가 정부놈들도 바보가 아니야. 던전을 통제하는 일이 가능할 리 없다는 걸 잘 알고 있지. ")
	MDSay("비움", "De", "핌핌", "De", "비움", "De", "핌핌",	"<Key:LLoungeQ_891503_1003>그러니 적당히 뇌물 먹이고 가끔 쓸만한 정보를 던져주면 알아서 눈감아줘. 이 도시는 법으로 돌아가지 않아. 이해관계로 돌아가지.")
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