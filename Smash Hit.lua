--An adapted script from SnakeyWakey's MagicDagers mod.

function init()
	ball = FindBody("ball")
	armvel = -6
	local ct = GetCameraTransform()
	local startpos = TransformToParentPoint(ct, Vec(0, 0, -1))
	local fwdpos = TransformToParentPoint(ct, Vec(0, 0, -40))
	local direction = VecSub(fwdpos, startpos)
	SetBodyVelocity(ball, direction)
    SetBodyAngularVelocity(ball, Vec(math.random(-20,20),math.random(-20,20),math.random(-20,20)))
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