--Catches gm_spawn on gamemodes other than sandbox
if engine.ActiveGamemode( ) == "sandbox" then return end

local old = concommand.GetTable( )[1]["gm_spawn"]

concommand.Add("gm_spawn", function( ply, cmd, args, mdl, flUnknown, iUnknown, ... )
	if not ply:GetNWBool("in pac3 editor") then
		return old( ply, cmd, args, mdl, flUnknown, iUnknown, ... )
	end
	
	Pointshop2.SpawnMenu = g_SpawnMenu or Pointshop2.SpawnMenu
	local mdl = args[1]
	if pace.close_spawn_menu then
		pace.Call("VariableChanged", pace.current_part, "Model", mdl)
	
		if Pointshop2.SpawnMenu:IsVisible() then
			Pointshop2.SpawnMenu:Close()
		end
		
		pace.close_spawn_menu = false
	elseif pace.current_part.ClassName ~= "model" then
		local name = mdl:match(".+/(.+)%.mdl")
		
		pace.Call("CreatePart", "model", name, nil, mdl)
	else
		pace.Call("VariableChanged", pace.current_part, "Model", mdl)
	end
end)