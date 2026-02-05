local QUEST_ID = 110301	

function OnLounge()
	OnLoungeCommon()
end

function OnStage()
	LuaApi:SetString(QUEST_ID, "Key", "false")	
	local spawnPos3 = LuaApi:GetZoneSpawnPosition(1103011)	
	LuaApi:SpawnMiniMapMarker(11030101, "PortalMarker", { x = spawnPos3.x, y = spawnPos3.y, z = spawnPos3.z })
	OnStageCommon()	
end

function OnEvent(eventType, value)
	local step = LuaApi:GetStep();

	if (eventType == E_Trigger and value == 800005) then
		LuaApi:TriggerEventToAll(800005)
	end

	if (eventType == E_Custom and value == 800005) then
		CallToAll_1()
	end

	if (step == 3 and eventType == E_TaskAchieved) then
		CallTaskAchieved_A()
	end

	if (eventType == E_MonsterKill and value == 300004) then -- 보스몹 킬
		CallMonsterKilled()
	end
end

function Step_00001()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110301",
		FunctionName = "TalkToNPC",
		Purpose = "Start"
	})	
	await(LuaApi:WaitDelayAsync(3000))	
	PingToElara()
end

function TalkToNPC()
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작

	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 		"<Key:LQuest_110301_1001>이번에도 역시 익명의 의뢰입니다. 역시 보수가 상당하고요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1002>또? 저번의 그 의뢰인인가?")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 		"<Key:LQuest_110301_1003>그건 알 수 없죠.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1004>의뢰 내용은?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 		"<Key:LQuest_110301_1005>도시 주택가의 경찰서에서 <color=#b91d1d>훔쳐본 자의 눈</color>을 가져다 달라고 합니다.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1006>눈? 안구 말이야? ")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1007>음… 뭔지 몰라도 굉장한 걸 본 모양인데. 훔쳐봤다고 눈알이 뽑힐 정도라면… 음…")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 		"<Key:LQuest_110301_1008>혹시 야한 걸까요?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1009>그, 그야 알 수 없지. 그보다 그런 이야기는 좀 조용히 말해주지 않을래?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 		"<Key:LQuest_110301_1010>(소근소근)이런, 주의하겠습니다.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 		"<Key:LQuest_110301_1011>훔쳐본 자의 눈을 가지고 있는 자는 경찰서장이라고 합니다. 자신의 알몸을 본 상대의 눈을 뽑은 게 아닐까요?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1012>서장? 서장 <color=#b91d1d>도노반?!</color>")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1013>결국 던전에 삼켜졌구나. 그래… 이상하지 않은 일이지.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 		"<Key:LQuest_110301_1014>아는 분이었군요?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1015>응. 그 훔쳐본 자의 눈이라는 게 어떤 물건인지도 대충 감이 와.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이", 		"<Key:LQuest_110301_1016>어찌되었건 이번에도 만만한 상대는 아니네.")

	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110301", "TalkToNPC")	
	LuaApi:SetStep(2)
end

function Step_00002() -- 캠페인 시작 세팅2
	SetQuestState("InProgress")
	await(LuaApi:WaitDelayAsync(700))
	ReadyAndStartToast()	
end

function Step_00003()
	await(LuaApi:WaitDelayAsync(1500))
	RadioSay("엘라", "Default", "<Key:LQuest_110301_2001>훔쳐본 자의 눈은 서장 도노반에게 있을 것으로 예상돼요.")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110301_2002>도노반이 마지막으로 목격된 곳은 경찰서 옥상이에요.")
	await(LuaApi:WaitDelayAsync(3000))	
	RadioSay("엘라", "Default", "<Key:LQuest_110301_2003>옥상으로 진입하는 통로는 경찰서 가장 안쪽에 있어요.")
end

function CallToAll_1()

	LuaApi:SetTriggerable(ETriggerableObjectType.Triggerable, 800005, false)
	local spawnPos = LuaApi:GetZoneSpawnPosition(800005)	
	RadioSay("엘라", "Default", "<Key:LQuest_110301_2004>서장이에요!")		
	if (LuaApi:IsHost() == true and LuaApi:GetMonsterCount(300004) == 0 and LuaApi:GetString(QUEST_ID, "Key")~="true") then

		LuaApi:SpawnMonster(300004, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })
		LuaApi:SetString(QUEST_ID, "Key", "true")		
	end
end

function CallMonsterKilled()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110301_2005>쓰러뜨렸군요!")
end

function CallTaskAchieved_A()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110301_3001>다이빙 부스를 소환해드릴게요.")
	local spawnPos = LuaApi:GetZoneSpawnPosition(800005)
	if LuaApi:IsHost() == true then
		LuaApi:SpawnExit(1007, { x = spawnPos.x, y = spawnPos.y, z = spawnPos.z })			
	end
end

function Step_00010()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110301",
		FunctionName = "QuestComplete",
		Purpose = "Complete"
	})
end

function QuestComplete()

	await(LuaApi.OpenDialogAsync(0))        -- 다이얼로그 시작
	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110301_4001>이게 의뢰품인 <color=#b91d1d>훔쳐본 자의 눈</color>이로군요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110301_4002>(소근소근)대단히 야한 걸 훔쳐봐서 눈이 뽑혔다고 했던가요?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110301_4003>그건 아니고… 훔쳐본 자가 자신의 눈을 스스로 뽑았을 거야, 아마.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110301_4004>저런, 도저히 못 볼 걸 봐버린 모양이네요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110301_4005>…….")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110301_4006>그나저나 서장이 가지고 있던 그 문서는 뭐야?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110301_4007>알 수 없는 언어로 쓰여있어서 내용은 모르겠어요. 그치만 음.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110301_4008>이건 <color=#b91d1d>해방의 목소리</color> 문양인데요?")


	await(LuaApi:CloseDialogAsync()) -- 다이얼로그 종료	

	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110301", "QuestComplete")	
	SetQuestState("Completed")
end