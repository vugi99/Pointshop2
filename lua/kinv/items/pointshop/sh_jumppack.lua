ITEM.baseClass	= "base_hat"
ITEM.PrintName	= "Jump Pack"
ITEM.Description = "Makes you jump higher!"
ITEM.Price = {
	points = 20000,
}

ITEM.static.validSlots = {
	"Accessory",
}

ITEM.static.iconInfo = {
	["shop"] = {
		["iconMaterial"] = "",
		["useMaterialIcon"] = false,
		["iconViewInfo"] = {
			["fov"] = 74.620961142622,
			["angles"] = Angle(27.75, 99.875, 0),
			["origin"] = Vector(-9.75, -22.46875, 57),
		},
	},
	["inv"] = {
		["iconMaterial"] = "",
		["useMaterialIcon"] = false,
		["iconViewInfo"] = {
			["fov"] = 90,
			["angles"] = Angle(48.84375, 99.875, 0),
			["origin"] = Vector(-2.71875, -22.4375, 62.84375),
		},
	},
}

function ITEM.static.getBaseOutfit( )
	return {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
						[1] = {
							["children"] = {
								[1] = {
									["children"] = {
										[1] = {
											["children"] = {
											},
											["self"] = {
												["Arguments"] = "jump@@0.5",
												["UniqueID"] = "4206270507",
												["Invert"] = true,
												["Event"] = "animation_event",
												["Name"] = "jump",
												["ClassName"] = "event",
											},
										},
									},
									["self"] = {
										["Velocity"] = 200,
										["DrawOrder"] = 1,
										["UniqueID"] = "135234957",
										["StickToSurface"] = false,
										["EndSize"] = 6,
										["Material"] = "sprites/flamelet1",
										["EditorExpand"] = true,
										["StartAlpha"] = 200,
										["AirResistance"] = 4.8,
										["StartSize"] = 3,
										["Collide"] = false,
										["Position"] = Vector(0.84375, 0, 0),
										["Sliding"] = false,
										["Angles"] = Angle(0, -179.4375, 0),
										["Lighting"] = false,
										["AlignToSurface"] = false,
										["Gravity"] = Vector(0, 0.09375, -100),
										["Bounce"] = 10.8,
										["ClassName"] = "particles",
										["DoubleSided"] = false,
										["Spread"] = 0.2,
										["FireDelay"] = 0.03,
										["NumberParticles"] = 5,
										["DieTime"] = 0.5,
										["Color1"] = Vector(200, 200, 200),
									},
								},
							},
							["self"] = {
								["ClassName"] = "model",
								["EditorExpand"] = true,
								["UniqueID"] = "2613842725",
								["Position"] = Vector(-6.09375, -5.125, 3.875),
								["Size"] = 0.3,
								["Bone"] = "spine",
								["Model"] = "models/xqm/jetenginemedium.mdl",
								["Angles"] = Angle(-1.1875, -94.40625, -15.125),
							},
						},
						[2] = {
							["children"] = {
							},
							["self"] = {
								["Angles"] = Angle(33.4375, 0, 0),
								["ClassName"] = "model",
								["UniqueID"] = "2559247851",
								["Position"] = Vector(0.96875, 0, 5.78125),
								["EditorExpand"] = true,
								["Bone"] = "spine",
								["Model"] = "models/xqm/polex1.mdl",
								["Scale"] = Vector(0.375, 1, 1),
							},
						},
					},
					["self"] = {
						["Angles"] = Angle(-14.875, 91.375, 0),
						["ClassName"] = "model",
						["UniqueID"] = "709861256",
						["Position"] = Vector(5.0625, -5.75, -2.09375),
						["EditorExpand"] = true,
						["Bone"] = "spine",
						["Model"] = "models/xqm/polex1.mdl",
						["Scale"] = Vector(0.375, 1, 1),
					},
				},
			},
			["self"] = {
				["EditorExpand"] = true,
				["UniqueID"] = "1708383976",
				["ClassName"] = "group",
				["Name"] = "my outfit",
				["Description"] = "add parts to me!",
			},
		}
	}, 10000
end

function ITEM:Think( )
	KInventory.Items.base_hat.Think( self )

	--[[if self:GetOwner( ):KeyDown( IN_JUMP ) then
		--self:GetOwner( ):SetVelocity( self:GetOwner( ):GetUp( ) * 2 )
		if SERVER then
			local owner = self:GetOwner()
			if IsValid(owner) then
				owner:SetVelocity( owner:GetUp( ) * 2 )
			end
		end
	end]]--
end
Pointshop2.AddItemHook( "Think", ITEM )

function ITEM:OnEquip()
	KInventory.Items.base_hat.OnEquip( self )

	local owner = self:GetOwner()
	if IsValid(owner) then
		owner.PS2_JP_Grav = 0.87
		--print("JumpPack Gravity")
	end
end

function ITEM:OnHolster()
	KInventory.Items.base_hat.OnHolster( self )

	local owner = self:GetOwner()
	if IsValid(owner) then
		owner.PS2_JP_Grav = nil
		--print("Normal Gravity")
		owner:SetGravity(1)
	end
end

hook.Add( "KeyPress", "JumpPackEnGravModifier", function( ply, key )
	if ( key == IN_JUMP ) then
		if (IsValid(ply) and ply.PS2_JP_Grav and ply:Alive()) then
			ply:SetGravity(ply.PS2_JP_Grav)
			--print("Enable JP")
		end
	end
end )

hook.Add( "KeyRelease", "JumpPackRemGravModifier", function( ply, key )
    if ( key == IN_JUMP ) then
		if (ply.PS2_JP_Grav) then
        	ply:SetGravity(1)
			--print("Disable JP")
		end
    end
end )



function ITEM.static.getOutfitForModel( model )
	return ITEM.static.getBaseOutfit( )
end
