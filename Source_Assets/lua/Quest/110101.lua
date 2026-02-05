-- 110101.lua

function OnLounge()
	OnLoungeCommon()
end

function OnStage() -- 캠페인 입장 세팅
	OnStageCommon()
end

function OnEvent(eventType, value)
	local state = LuaApi:GetString(80100, "State")

	if (state == "Selling") and (eventType == 205) then
		if LuaApi:HasEquipment(100233) == false and state ~= "Completed" then 
			LuaApi:SetString(80100, "State", "Return")
			LuaApi:DespawnPointerArrow(80100)
			LuaApi:SetNpcNavigationActive(700005, true)
			PingToOnwer()	
		end
	end

	local step = LuaApi:GetStep();
	if (step == 3) then

		if (eventType == E_TaskAchieved and value == 1101011) then
			if (LuaApi:IsAllTaskAchieved() == true) then -- 태스크 전체가 완료된 상황인지 확인	
		
				CallTaskAchieved_A()
			end
		end	
		if (eventType == E_TaskAchieved and value == 1101012) then
			if (LuaApi:IsAllTaskAchieved() == true) then -- 태스크 전체가 완료된 상황인지 확인	
		
				CallTaskAchieved_A()
			end
		end	
	end
end

function Step_00001() -- 캠페인 시작 세팅
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110101",
		FunctionName = "TalkToNPC",
		Purpose = "Start"
	})
	LuaApi:DespawnPointerArrow(CharacterIDs["엘라"])
	await(LuaApi:WaitDelayAsync(3000))
	PingToElara()
end

function TalkToNPC()            -- 캠페인 시작 시 (라운지, 엘라라)
	await(LuaApi.OpenDialogAsync()) -- 다이얼로그 시작
	LuaApi:SetNpcNavigationActive(700000, false)
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110101_1001>짜잔~ 발루샤의 재 오픈과 함께 시작하는 역사적인 첫 번째 임무입니다.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110101_1002>이번 임무에서 특별히 지정된 물품은 없어요. 그냥 팔 수 있을 만한 건 뭐든 잔뜩 모아서 안전하게 돌아오면 되는 거죠. 물론, 의뢰기한은 지켜야 해요!")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110101_1003>응. 이것저것 돈이 될 만한 것들을 보이는 대로 주워서 돌아오면 된다는 거구나. 다이브 할 때마다 의뢰기한이 줄어드는 거고.")	
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "제이",	"<Key:LQuest_110101_1004>간단해서 좋네, 조금은… 처량한 느낌도 있지만 말야.")	
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110101_1005>네, 맞아요. 점장님 말씀처럼 갈 곳 없는 노숙자가 자판기 밑을 뒤져가며 동전을 줍는 것과 비슷하죠.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110101_1006>그렇게까진 말 안했어.")		
	MDSay("비움", "De", "엘라", "An", "비움", "De", "엘라",	"<Key:LQuest_110101_1007>하지만! 던전에서 괴물을 상대해야 하는 일이에요.")
	MDSay("비움", "De", "엘라", "An", "비움", "De", "엘라",	"<Key:LQuest_110101_1008>절대 안전을 보장할 수 없는 일이고 뭣보다 다이버가 정상 귀환하지 못하면 가게는 가차없이 적자라고요.")

	MDSay("비움", "De", "엘라", "An", "비움", "De", "제이",	"<Key:LQuest_110101_1009>음… 그렇네. 위험한 일인데 내가 안일했어. 정신 바짝 차려야겠…")
	MDSay("비움", "De", "엘라", "An", "비움", "De", "제이",	"<Key:LQuest_110101_1010>그런데, 다이버보다 적자 쪽이 더 문제냐고…")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110101_1011>다이버는 괜찮아요. 만약에 던전에서 쓰러지더라도 우리에겐 <color=#3d840e>다이빙 부스</color>가 있으니까.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110101_1012>아, 가영이 구출 때의 그 붉은색 전화 부스 말이지?")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110101_1013>맞아요. 다른 업체의 것보다 확실히 진보한 <color=#3d840e>발루샤 특제 이동수단</color>이죠. 던전 깊숙한 곳까지 다이렉트로 오갈 수 있거든요.")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "엘라",	"<Key:LQuest_110101_1014>흠이 하나 있다면 구동 가격이 조금 비싸다는 것? 특히 <color=#b91d1d>긴급 송환</color>이라도 해야될 때에는 음… 저번에 청구서 보셨죠?")
	MDSay("비움", "De", "엘라", "De", "비움", "De", "제이",	"<Key:LQuest_110101_1015>청구서 봤지. 음… 명심할게.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110101_1015_2>그렇다고 해도 무사히 탈출하는 것이 당연히 더 좋죠! 한번에 모든 임무를 완수할 필요는 없으니 위험해지면 바로 탈출을 지시해주세요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라",	"<Key:LQuest_110101_1016>그럼, <color=#3d840e>Tab버튼</color>을 눌러 소모품등을 챙기고 원하는 다이버를 선택하여 출발시켜주세요.")


	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료
--	LuaApi:SetNpcNavigationActive(700105, true)	
	PingToPhoneBooth()	
	LuaApi:SetNpcNavigationActive(700105, true)	
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110101", "TalkToNPC")
	LuaApi:SetStep(2)
end

function Step_00002() -- 캠페인 시작 세팅2
	SetQuestState("InProgress")
	await(LuaApi:WaitDelayAsync(700))
	ReadyAndStartToast()	
end

function Step_00003() -- 캠페인 입장 세팅
	await(LuaApi:WaitDelayAsync(1500))
	RadioSay("엘라", "Default", "<Key:LQuest_110101_2001>목표는 둘이에요.")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110101_2002>매대에서 팔 만한 물건들을 모으는 것.")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110101_2003>그리고 고대의 부품을 모으는 것이에요.")
end

function CallTaskAchieved_A()
	await(LuaApi:WaitDelayAsync(1000))
	RadioSay("엘라", "Default", "<Key:LQuest_110101_2004>팔 물건들을 모두 모았네요.")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110101_2005>지도를 보고 단말기를 찾아 활성화하세요. 해당 위치로 다이빙 부스를 내려드릴게요.")
	await(LuaApi:WaitDelayAsync(3000))
	RadioSay("엘라", "Default", "<Key:LQuest_110101_2006>신호를 감지하고 적들이 몰려들 테니 조심하시고요.")

end

function Step_00010()
	LuaApi:AddDialog(CharacterIDs["엘라"], {
		Type = "Quest",
		Priority = 1,
		LuaKey = "Quest/110101",
		FunctionName = "QuestComplete",
		Purpose = "Complete"
	})
end

function QuestComplete()
	await(LuaApi.OpenDialogAsync(0))        -- 다이얼로그 시작

	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LQuest_110101_3001>좋아요, 임무 완수! 어때요? 첫 번째 임무는 간단하죠?")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LQuest_110101_3002>앞으로도 이렇게 매대에서 판매할 상품을 모아오는 것이 주된 임무가 될 거예요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LQuest_110101_3003>그러니 이번 임무의 진행 순서를 잘 기억해주세요. 만약에 잊어버린다면 언제든 <color=#3d840e>매뉴얼(F1)</color>을 살펴보시면 돼요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LQuest_110101_3004>참, 임무 완료 보상은 <color=#3d840e>더스터</color>에게서 받아갈 수 있으니 잊지 마시고요.")
	MDSay("비움", "De", "비움", "Sm", "비움", "De", "제이", 	"<Key:LQuest_110101_3005>(더스터라면 메인 데스크 바로 앞에 있군.)")
	
	LuaApi.FadeOutDialog()	
	PingToDuster()	
	await(LuaApi:WaitDelayAsync(1000))	
	await(LuaApi.CloseDialogAsync()) -- 다이얼로그 종료	
	LuaApi:RemoveDialog(CharacterIDs["엘라"], "Quest/110101", "QuestComplete")
	SetQuestState("Completed")

end