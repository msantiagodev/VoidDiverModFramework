local QUEST_ID = 80100

-- 상수 정의
local OWNER_NPC_ID = 700005	-- 오너
local GUEST_ID = 600012		-- 아서 알바레온 (모든 유물 구매 가능)
local ITEM_ID = 100233		-- 고통의 묵주 (장비/유물 ID)
local MARKER_ID = 80100	-- 퀘스트 마커용 ID

-- 위치 정의
local GUEST_POS = { x = 14.0, y = 0.0, z = 8.0 }
local MARKER_POS = { x = 14.0, y = 1.0, z = 8.0 }

-- 로컬 변수
local START_NPC = "오너"
local START_TITLE = "<Key:LLoungeQ_80100_START_TITLE> 시작"
local START_PRIORITY = 1

-- [변경] 화살표 제거 함수로 변경
function DespawnQuestTarget()
	LuaApi:DespawnPointerArrow(MARKER_ID)
end

-- [변경] 화살표 생성 함수로 변경
function SpawnQuestTarget()
	DespawnQuestTarget()
	LuaApi:SpawnGuest(GUEST_ID, GUEST_POS)
	LuaApi:SpawnPointerArrow(MARKER_ID, MARKER_POS)
end

-- 1. 시작 대화 (오너)
function StartDialog()
	local state = LuaApi:GetString(QUEST_ID, "State")

	await(LuaApi:OpenDialogAsync(0))

	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1001>첫 번째 임무를 잘 해결했다고 들었어요. 시작이 좋네요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1002>이미 던전을 경험해 본 분이 경영학과 신비학까지 전공하였으니 잘 해낼 거라고는 생각했지만… 솔직히 기대 이상이에요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1003>그럼 앞으로 할 일에 대해 설명을 드릴게요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1004>캠페인이나 다이브를 진행하면 가게의 평판이 점점 올라가고 <color=#3d840e>평판 레벨</color>을 올릴 수 있게 돼요. 가게의 발전 단계라고 할 수 있죠.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1005>그러니 충분한 경험을 쌓았다고 생각하면 제게 오세요. 가게의 평판 레벨, 즉 '격'을 올려 드릴게요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1006>첫 캠페인을 이미 수행했기 때문에 다음 레벨로 올라갈 경험은 이미 충분해요. 약간의 투자금만 준비되면 되겠네요.")
	MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1007>제가 드리는 '고통의 묵주'를 판매하고 오시겠어요?")
	
	-- 아이템 지급 (장비)
	LuaApi:GiveEquipment(ITEM_ID, 1)
	LuaApi:ShowSystemToastText("<Key:LLoungeQ_80100_6001>아이템을 획득했습니다: 고통의 묵주")

	await(LuaApi:CloseDialogAsync())
	LuaApi:SetString(QUEST_ID, "State", "Selling")
	LuaApi:SetNpcNavigationActive(OWNER_NPC_ID, false)

	SetLoungeQuestState(QUEST_ID, "InProgress")	
	RemoveLoungeDialog(START_NPC, QUEST_ID, "StartDialog")	
	AddLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog", "Start", START_TITLE, START_PRIORITY)		
end

-- 2. 복귀 대화 (오너: 판매 완료 후)
function OnInProgressDialog()
	local state = LuaApi:GetString(QUEST_ID, "State")
	
	-- [수정] 판매 중(Selling) 상태일 때 아이템 보유 여부를 확인
	if state == "Selling" then
		
		-- 아이템이 없으면(팔았거나 버렸으면) Return 상태로 강제 전환 후 진행
		if LuaApi:HasEquipment(ITEM_ID) == false then
			state = "Return" -- 아래의 else 분기를 타도록 로컬 변수 갱신
			LuaApi:SetString(QUEST_ID, "State", "Return") -- 실제 상태값 갱신
			DespawnQuestTarget() -- 판매 대상 마커 제거
			
		else
			-- 아이템을 아직 가지고 있다면 안내 대사 출력
			await(LuaApi:OpenDialogAsync(0))	
			MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1007>제가 드리는 '고통의 묵주'를 판매하고 오시겠어요?")
			await(LuaApi:CloseDialogAsync())		
			return
		end
	end

	-- [수정] Selling이 아니거나(기존 로직), 위에서 아이템이 없어 Return으로 변경된 경우 실행
	if state ~= "Selling" then 
		await(LuaApi:OpenDialogAsync(0))
		MDSay("비움", "De", "오너", "De", "비움", "De", "오너", 	"<Key:LLoungeQ_80100_1008>이제 투자금도 마련되었으니 평판 레벨을 올릴 준비가 되었어요.")
		await(LuaApi:CloseDialogAsync())

		LuaApi:SetNpcNavigationActive(OWNER_NPC_ID, false)
		RemoveLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog")
		DespawnQuestTarget()
		PingToOnwer()	
	end
end

-- 상태 콜백: 시작 전
function OnNotStarted()
	LuaApi:SetNpcNavigationActive(OWNER_NPC_ID, true)
	AddLoungeDialog(START_NPC, QUEST_ID, "StartDialog", "Start", START_TITLE, START_PRIORITY)
end

-- 상태 콜백: 진행 중
function OnInProgress()
	AddLoungeDialog(START_NPC, QUEST_ID, "OnInProgressDialog", "Start", START_TITLE, START_PRIORITY)	
	local state = LuaApi:GetString(QUEST_ID, "State")
	
	if state == "Selling" then
		SpawnQuestTarget()
	end
end

function OnNotCompleted()
	LuaApi:SetString(QUEST_ID, "State", "Completed")
	SetLoungeQuestState(QUEST_ID, "Completed")
end

function OnCompleted()
	RemoveLoungeDialog(START_NPC, QUEST_ID, "FinishDialog")
	DespawnQuestTarget()
end