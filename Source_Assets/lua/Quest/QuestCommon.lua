function QuestCompleteSub()	
	LuaApi:LogInfo("[LUALUA]-beforeComplete")
	SetQuestState("Completed")	
	LuaApi:LogInfo("[LUALUA]-afterComplete")
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/QuestCommon", "QuestCompleteSub")		
end
