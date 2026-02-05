local QUEST_ID = 80200

-- 필요 없으면 삭제 가능한 로컬변수
local START_NPC = "엘라"
local START_TITLE = "<Key:LLoungeQ_80200_START_TITLE> 시작"
local START_PRIORITY = 1
local COMPLETE_NPC = "엘라"
local COMPLETE_TITLE = "<Key:LLoungeQ_80200_COMPLETE_TITLE> 끝"
local COMPLETE_PRIORITY = 1

-- 화살표 마커 ID 정의
local ARROW_ID_MIRROR = 8880201
local ARROW_ID_PELIX = 8880202
local ARROW_ID_LUCAS = 8880203

-- NPC 위치를 받아 Y좌표를 +1 한 뒤, Lua 테이블 형태로 반환하는 함수
function GetArrowPositionTable(npcId)
	local pos = LuaApi:GetNpcPosition(npcId)
	if pos ~= nil then
		return { x = pos.x, y = pos.y + 1.0, z = pos.z }
	end
	return nil
end

-- [수정] 진행도 체크 및 엘라라 복귀 유도 함수
function CheckProgressAndReturn()
	-- 숫자 카운팅 로직 제거하고, 오직 3개의 키 값만 확인합니다.
	local mirrorDone = LuaApi:GetString(QUEST_ID, "TalkedToMirror") == "true"
	local pelixDone = LuaApi:GetString(QUEST_ID, "TalkedToPelix") == "true"
	local lucasDone = LuaApi:GetString(QUEST_ID, "TalkedToLucas") == "true"

	-- 3명 모두와 대화했다면(모두 true라면) 엘라라 활성화
	if mirrorDone and pelixDone and lucasDone then
		
		LuaApi:ShowSystemToastText("<Key:LLoungeQ_80200_6001>모든 안내를 받았습니다. 엘라라에게 돌아가세요.")
		
		LuaApi:AddDialog(CharacterIDs["엘라"], {
			Type = "LoungeQuest",
			Priority = 1,
			LuaKey = "LoungeQuest/80200",
			FunctionName = "FinishDialog",
			Purpose = "Start"
		})
		RemoveLoungeDialog(START_NPC, QUEST_ID, "InProgressDialog")		
		LuaApi:SetNpcNavigationActive(CharacterIDs["엘라"], true)
		PingToElara()
	end
end

-- 1. 시작 대화 (엘라라)
function InProgressDialog()

	-- 이미 시작된 상태인지 확인
	local isStarted = LuaApi:GetString(QUEST_ID, "Started") == "true"

	if isStarted then
		-- 재진입 시 짧은 안내
		await(LuaApi.OpenDialogAsync(0))		
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80200_1004>본격적으로 가게를 소개시켜드릴게요. 일단은 한 번 둘러보시는 게 좋겠어요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80200_1005>나르시스, 펠릭스, 루카스와 대화를 나누고 오세요.")		
		await(LuaApi.CloseDialogAsync())
	else
		-- 최초 진입 시
		LuaApi:SetNpcNavigationActive(700000, false)

		await(LuaApi.OpenDialogAsync(0))
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80200_1001>일단은 가게를 한 번 둘러보시겠어요?")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80200_1002>아직은 필요한 사람이나 기계가 다 갖춰지지 않아서 좀 휑하지만 곧 차근차근 준비가 될 거예요.")
		MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", 	"<Key:LLoungeQ_80200_1003>나르시스, 펠릭스, 루카스와 대화를 나누고 오세요.")
		await(LuaApi.CloseDialogAsync())

		-- 시작 플래그 설정 및 진행도 초기화
		LuaApi:SetString(QUEST_ID, "Started", "true")
		-- 혹시 남아있을 수 있는 이전 데이터 초기화
		LuaApi:SetString(QUEST_ID, "TalkedToMirror", "false")
		LuaApi:SetString(QUEST_ID, "TalkedToPelix", "false")
		LuaApi:SetString(QUEST_ID, "TalkedToLucas", "false")
	end

	-- 각 NPC별 진행도를 확인하여 완료하지 않은 경우에만 다이얼로그/화살표 추가

	-- 1. 거울 (나르시스)
	if LuaApi:GetString(QUEST_ID, "TalkedToMirror") ~= "true" then
		LuaApi:AddDialog(CharacterIDs["거울"], {
			Type = "LoungeQuest",
			Priority = 1,
			LuaKey = "LoungeQuest/80200",
			FunctionName = "TalkToMirror",
			Purpose = "Start"
		})
		
		local mirrorPosTable = GetArrowPositionTable(CharacterIDs["거울"])
		if mirrorPosTable then
			LuaApi:DespawnPointerArrow(ARROW_ID_MIRROR) -- 기존 제거
			LuaApi:SpawnPointerArrow(ARROW_ID_MIRROR, mirrorPosTable)
		end
	end

	-- 2. 펠릭스
	if LuaApi:GetString(QUEST_ID, "TalkedToPelix") ~= "true" then
		LuaApi:AddDialog(CharacterIDs["펠릭"], {
			Type = "LoungeQuest",
			Priority = 1,
			LuaKey = "LoungeQuest/80200",
			FunctionName = "TalkToPelix",
			Purpose = "Start"
		})
		
		local pelixPosTable = GetArrowPositionTable(CharacterIDs["펠릭"])
		if pelixPosTable then
			LuaApi:DespawnPointerArrow(ARROW_ID_PELIX) -- 기존 제거
			LuaApi:SpawnPointerArrow(ARROW_ID_PELIX, pelixPosTable)
		end
	end

	-- 3. 루카스
	if LuaApi:GetString(QUEST_ID, "TalkedToLucas") ~= "true" then
		LuaApi:AddDialog(CharacterIDs["루카"], {
			Type = "LoungeQuest",
			Priority = 1,
			LuaKey = "LoungeQuest/80200",
			FunctionName = "TalkToLucas",
			Purpose = "Start"
		})
		
		local lucasPosTable = GetArrowPositionTable(CharacterIDs["루카"])
		if lucasPosTable then
			LuaApi:DespawnPointerArrow(ARROW_ID_LUCAS) -- 기존 제거
			LuaApi:SpawnPointerArrow(ARROW_ID_LUCAS, lucasPosTable)
		end
	end
	
	-- 혹시 이미 완료된 상태에서 재진입했을 경우를 대비
	CheckProgressAndReturn()
end

-- 2. 거울 (나르시스) 대화
function TalkToMirror()
	LuaApi:DespawnPointerArrow(ARROW_ID_MIRROR)
	LuaApi:SetNpcNavigationActive(CharacterIDs["거울"], false)	

	await(LuaApi.OpenDialogAsync(0))
	MDSay("엘라", "Sm", "비움", "De", "비움", "De", "엘라", 	"<Key:LLoungeQ_80200_2001>이것은 '나르시스'라고 불려요. 평범한 유리는 아니에요. 비치는 건 마주 선 자의 외면이 아니라, 껍데기 안쪽의 심연이죠.")
	MDSay("엘라", "Sm", "비움", "De", "비움", "De", "엘라", 	"<Key:LLoungeQ_80200_2002>임무를 수행하기 위한 <color=#3d840e>다이버를 선택</color>하고 싶다면 거울 앞에 서 보세요. 외면도 원하는 대로 꾸밀 수 있어요.")
	await(LuaApi.CloseDialogAsync())
	
	RemoveLoungeDialog("거울", QUEST_ID, "TalkToMirror")
	
	-- 완료 플래그 저장
	LuaApi:SetString(QUEST_ID, "TalkedToMirror", "true")
	CheckProgressAndReturn()
end

-- 3. 펠릭스 대화
function TalkToPelix()
	LuaApi:DespawnPointerArrow(ARROW_ID_PELIX)
	LuaApi:SetNpcNavigationActive(CharacterIDs["펠릭"], false)	

	await(LuaApi.OpenDialogAsync(0))
	MDSay("엘라", "Sm", "비움", "De", "펠릭2", "Sm", "엘라", 		"<Key:LLoungeQ_80200_3001>펠릭스는 발루샤의 기술 고문이에요. 임무에 나서기 전에 필요한 <color=#3d840e>스킬을 세팅</color>하려면 펠릭스를 거치셔야 해요.")
	MDSay("엘라", "Sm", "비움", "De", "펠릭2", "Sm", "펠릭2",		"<Key:LLoungeQ_80200_3002>난 펠릭스. 간단히 말해 다이버들의 코치라고 생각하면 돼.")
	MDSay("엘라", "Sm", "비움", "De", "펠릭2", "Sm", "펠릭2",		"<Key:LLoungeQ_80200_3003>현장에서 몸 쓰는 것도 재밌지만 지금은 다이버들이 던전에서 제대로 힘을 쓸 수 있게 '길'을 닦아주는 일을 하고 있어. ")
	MDSay("엘라", "Sm", "비움", "De", "펠릭2", "Sm", "펠릭2",		"<Key:LLoungeQ_80200_3004>다이버들이 가지고 있는 <color=#3d840e>스킬</color>을 세팅하거나 능력을 끌어올리는 <color=#3d840e>특성</color>을 활성화하고 싶다면 나를 찾아와. 있는 힘껏 도울 테니까.")
	await(LuaApi.CloseDialogAsync())
	
	RemoveLoungeDialog("펠릭", QUEST_ID, "TalkToPelix")
	
	-- 완료 플래그 저장
	LuaApi:SetString(QUEST_ID, "TalkedToPelix", "true")
	CheckProgressAndReturn()
end

-- 4. 루카스 대화
function TalkToLucas()
	LuaApi:DespawnPointerArrow(ARROW_ID_LUCAS)
	LuaApi:SetNpcNavigationActive(CharacterIDs["루카"], false)	

	await(LuaApi.OpenDialogAsync(0))
	MDSay("엘라", "Sm", "비움", "De", "루카2", "De", "엘라", 	"<Key:LLoungeQ_80200_4001>루카스는 발루샤의 보급관 역할을 하고 있어요. <color=#3d840e>소모품을 판매</color>하고 유물 외 물건은 <color=#3d840e>매입</color>하죠.")
	MDSay("엘라", "Sm", "비움", "De", "루카2", "De", "루카2",	"<Key:LLoungeQ_80200_4002>반갑습니다, 루카스라고 합니다.")
	MDSay("엘라", "Sm", "비움", "De", "루카2", "De", "루카2",	"<Key:LLoungeQ_80200_4003>임무에 필요한 약품, 재료, 그 외에 목숨을 부지해 줄 도구들이 필요하다면 제게 오십시오. ")
	MDSay("엘라", "Sm", "비움", "De", "루카2", "De", "루카2",	"<Key:LLoungeQ_80200_4004>물론 공짜는 아닙니다. 예? 상품의 출처는… 모르시는 게 좋을 것 같군요. ")
	MDSay("엘라", "Sm", "비움", "De", "루카2", "De", "엘라",	"<Key:LLoungeQ_80200_4005>임무 전에는 항상 잊지 말고 루카스에게 들르셔야 해요.")
	await(LuaApi.CloseDialogAsync())
	
	RemoveLoungeDialog("루카", QUEST_ID, "TalkToLucas")
	
	-- 완료 플래그 저장
	LuaApi:SetString(QUEST_ID, "TalkedToLucas", "true")
	CheckProgressAndReturn()
end

-- 5. 마무리 대화 (엘라라 복귀)
function FinishDialog()
	LuaApi:SetNpcNavigationActive(CharacterIDs["엘라"], false)	

	await(LuaApi.OpenDialogAsync(0))
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LLoungeQ_80200_5001>제 소개는 이미 드렸지만 정식으로 다시 인사드릴게요. ")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LLoungeQ_80200_5002>저는 발루샤의 운영을 보조하는 AI 비서, 엘라라예요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LLoungeQ_80200_5003>발루샤의 모든 업무를 보조하지만 가장 중요한 업무는 <color=#3d840e>의뢰 관리</color>죠. 모든 의뢰는 저를 통해 확인하고 진행하실 수 있어요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LLoungeQ_80200_5004>제게서 의뢰 목록을 확인하고 선택한 의뢰를 수행하시면 돼요.")
	MDSay("비움", "De", "엘라", "Sm", "비움", "De", "엘라", "<Key:LLoungeQ_80200_5005>이 정도면 업무에 대한 기본적인 부분은 다 소개해 드렸어요. 이제 첫 번째 의뢰를 시작해 볼까요?")
	await(LuaApi.CloseDialogAsync())

	RemoveLoungeDialog(START_NPC, QUEST_ID, "FinishDialog")		
	SetLoungeQuestState(QUEST_ID, "Completed")	
end

-- 상태 콜백
function OnNotStarted() -- 조건을 만족해서 시작가능한 상태
	LuaApi:SetNpcNavigationActive(CharacterIDs["엘라"], true)			
	SetLoungeQuestState(QUEST_ID, "InProgress")	
end

function OnInProgress() -- 진행중인 상태
	AddLoungeDialog(START_NPC, QUEST_ID, "InProgressDialog", "Start", START_TITLE, START_PRIORITY)
end

function OnNotCompleted() -- 완료조건을 만족했지만 완료처리 안된 상태
end

function OnCompleted() -- 완료된 상태
	RemoveLoungeDialog(START_NPC, QUEST_ID, "InProgressDialog")
	RemoveLoungeDialog(START_NPC, QUEST_ID, "FinishDialog")
	RemoveLoungeDialog("거울", QUEST_ID, "TalkToMirror")
	RemoveLoungeDialog("펠릭", QUEST_ID, "TalkToPelix")
	RemoveLoungeDialog("루카", QUEST_ID, "TalkToLucas")
	
	LuaApi:DespawnPointerArrow(ARROW_ID_MIRROR)
	LuaApi:DespawnPointerArrow(ARROW_ID_PELIX)
	LuaApi:DespawnPointerArrow(ARROW_ID_LUCAS)
end