
function init()
	RegisterTool("Smash Hit", "smashBall", "MOD/smashHand.vox")
	SetBool("game.tool.SmashHit.enabled", true)
	tim = 0
end

--Return a random vector of desired length
function rndVec(length)
	local v = VecNormalize(Vec(math.random(-100,100), math.random(-100,100), math.random(-100,100)))
	return VecScale(v, length)	
end

function tick(dt)

	if GetString("game.player.tool") == "smashBall" then
	
		--Check if tool is firing
		if GetBool("game.player.canusetool") and InputDown("usetool") then

			local ct = GetCameraTransform()
			local startpos = TransformToParentPoint(ct, Vec(0, 0, -1))
			local fwdpos = TransformToParentPoint(ct, Vec(0, 0, -40))
			local direction = VecSub(fwdpos, startpos)
			tim = tim + dt

			if tim > 0.1 then
				PlaySound(throw)
			Spawn("MOD/smashBall.xml", Transform(startpos))
			tim = 0
			end
		end
	end
end

function GetAimPos()
	local ct = GetCameraTransform()
	local forwardPos = TransformToParentPoint(ct, Vec(0, 0, -100))
    local direction = VecSub(forwardPos, ct.pos)
    local distance = VecLength(direction)
	local direction = VecNormalize(direction)
	local hit, hitDistance = QueryRaycast(ct.pos, direction, distance)
	if hit then
		forwardPos = TransformToParentPoint(ct, Vec(0, 0, -hitDistance))
		distance = hitDistance
	end
	return forwardPos, hit, distance
end