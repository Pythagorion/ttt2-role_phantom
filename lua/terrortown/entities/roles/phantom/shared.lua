if SERVER then
    AddCSLuaFile()
    resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_phant")
    util.AddNetworkString("ttt2_phant_begin_epop")
end

ROLE.Base = "ttt_role_base"

function ROLE:PreInitialize()
    self.color = Color(110, 8, 33, 255)

    self.abbr = "phant"
    self.unknownTeam = false
    self.defaultTeam = TEAM_TRAITOR
    self.preventFindCredits = true
    self.preventKillCredits = true
    self.preventTraitorAloneCredits = true
    self.preventWin = false
    self.scoreKillsMutliplier = 2
    self.TeamKillsMultiplier = -16

    self.conVarData = {
        pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 8, -- minimum amount of players until this role is able to get selected
		credits = 0, -- the starting credits of a specific role
		shopFallback = SHOP_DISABLED,
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 45,
		traitorButton = 1, -- can use traitor buttons
    }
end

function ROLE:Initialize()
    roles.SetBaseRole(self, ROLE_TRAITOR)
end

if SERVER then
    local function ResetPhantom()
        local plys = player.GetAll()

        for i = 1, #plys do
            local ply = plys[i]

            ply.phant_data = {}
            ply.phant_data.killed_once = false
            ply.phant_data.revd_once = false
        end
    end

    hook.Add("TTTCanSearchCorpse", "ttt2_role_phant_search_their_corpse", function(ply, rag, isCovert, isLongRange)
        local deadply = player.GetBySteamID64(rag.sid64)

        -- cache CVARs for further purposes
        local cv_phant_rev_after_search = GetConVar("ttt_phantom_revive_after_found"):GetBool()
        local cv_phant_prevent_confirmation = GetConVar("ttt_phantom_prevent_confirmation"):GetBool()
        local cv_phant_prevent_searching_of_all = GetConVar("ttt_phantom_prevent_all_searches"):GetBool()
        local cv_phant_rev_more_than_once = GetConVar("ttt_phantom_resurrection_everytime"):GetBool()
        local cv_phant_traitor_prevent_search_phant = GetConVar("ttt_phantom_traitor_prevent_search"):GetBool()
        local cv_phant_traitor_prevent_search_all = GetConVar("ttt_phantom_traitor_prevent_search_all"):GetBool()
        local cv_phant_kill_everytime = GetConVar("ttt_phantom_kill_everytime"):GetBool()
        local cv_phant_prevent_policing_search_phantom = GetConVar("ttt_phantom_prevent_policing_search_phantom"):GetBool()
        local cv_phant_prevent_policing_search_all = GetConVar("ttt_phantom_prevent_policing_search_all"):GetBool()
        local cv_phant_in_round_hint = GetConVar("ttt_phantom_in_round_hint"):GetBool()

        -- Kill the searching player if the dead is phantom and no policing role (handled extra) nor a traitor
        if deadply:GetSubRole() == ROLE_PHANTOM and ply:GetTeam() ~= TEAM_TRAITOR and not ply:GetSubRoleData().isPolicingRole then
            if not deadply.phant_data.killed_once then
                ply:Kill()
            end

            -- Revive phantom if wanted
            if cv_phant_rev_after_search and not deadply.phant_data.revd_once then
                deadply:Revive(0.1,_,_,false,1)
            end

            -- if phantom shall be revived only once, we must set the 'only-once'-flag
            if not cv_phant_rev_more_than_once then
                deadply.phant_data.revd_once = true
            end

            -- if phantom shall kill only once, we must set the 'only-once'-flag
            if not cv_phant_kill_everytime then
                deadply.phant_data.killed_once = true
            end
        end

        -- Kill policing roles nonetheless when they cannot search the Phantom's corpse
        if deadply:GetSubRole() == ROLE_PHANTOM and ply:GetSubRoleData().isPolicingRole and cv_phant_prevent_policing_search_phantom then
            if not deadply.phant_data.killed_once then
                ply:Kill()
            end

            -- Revive phantom if wanted
            if cv_phant_rev_after_search and not deadply.phant_data.revd_once then
                deadply:Revive(0.1,_,_,false,1)
            end

            -- if phantom shall be revived only once, we must set the 'only-once'-flag
            if not cv_phant_rev_more_than_once then
                deadply.phant_data.revd_once = true
            end

            -- if phantom shall kill only once, we must set the 'only-once'-flag
            if not cv_phant_kill_everytime then
                deadply.phant_data.killed_once = true
            end
        end

        -- prevent confirmation if cvar is configured as such and the dead is a phantom. Traitors and policing roles will be handled further down below.
        if cv_phant_prevent_confirmation and deadply:GetSubRole() == ROLE_PHANTOM and not ply:GetSubRoleData().isPolicingRole and ply:GetTeam() ~= TEAM_TRAITOR then

            -- Send out pop-in hint message if wanted and players arent able to search bodies
            if cv_phant_in_round_hint then
               LANG.Msg(ply, "ttt2_cannot_search_corpse_" .. PHANTOM.name, nil, MSG_MSTACK_WARN)
            end

            return false
        end

        -- prevent that any body can be searched. Once again traitors and policing roles will be handled below.
        if cv_phant_prevent_searching_of_all and deadply:GetSubRole() ~= ROLE_PHANTOM and not ply:GetSubRoleData().isPolicingRole and ply:GetTeam() ~= TEAM_TRAITOR then

            -- Send out pop-in hint message if wanted and players arent able to search bodies
            if cv_phant_in_round_hint then
                LANG.Msg(ply, "ttt2_cannot_search_corpse_" .. PHANTOM.name, nil, MSG_MSTACK_WARN)
            end

            return false
        end

        -- Don't let Traitors search phantoms if wanted
        if cv_phant_traitor_prevent_search_phant and ply:GetTeam() == TEAM_TRAITOR and not ply:GetSubRoleData().isPolicingRole and deadply:GetSubRole() == ROLE_PHANTOM then

            -- Send out pop-in hint message if wanted and players arent able to search bodies
            if cv_phant_in_round_hint then
                LANG.Msg(ply, "ttt2_cannot_search_corpse_" .. PHANTOM.name, nil, MSG_MSTACK_WARN)
            end

            return false
        end

        -- Don't let Traitors search other bodies than phantoms if wanted
        if cv_phant_traitor_prevent_search_all and ply:GetTeam() == TEAM_TRAITOR and not ply:GetSubRoleData().isPolicingRole and deadply:GetSubRole() ~= ROLE_PHANTOM then

            -- Send out pop-in hint message if wanted and players arent able to search bodies
            if cv_phant_in_round_hint then
                LANG.Msg(ply, "ttt2_cannot_search_corpse_" .. PHANTOM.name, nil, MSG_MSTACK_WARN)
            end

            return false
        end

        -- Don't let policing Roles search phantoms if wanted
        if cv_phant_prevent_policing_search_phantom and ply:GetSubRoleData().isPolicingRole and deadply:GetSubRole() == ROLE_PHANTOM then

            -- Send out pop-in hint message if wanted and players arent able to search bodies
            if cv_phant_in_round_hint then
                LANG.Msg(ply, "ttt2_cannot_search_corpse_" .. PHANTOM.name, nil, MSG_MSTACK_WARN)
            end

            return false
        end

        -- Don't let policing Roles search other bodies than phantoms if wanted
        if cv_phant_prevent_policing_search_all and ply:GetSubRoleData().isPolicingRole and deadply:GetSubRole() ~= ROLE_PHANTOM then

            -- Send out pop-in hint message if wanted and players arent able to search bodies
            if cv_phant_in_round_hint then
                LANG.Msg(ply, "ttt2_cannot_search_corpse_" .. PHANTOM.name, nil, MSG_MSTACK_WARN)
            end

            return false
        end
    end)

    hook.Add("TTTBodyFound", "ttt2_role_phant_kill_after_policing_found", function(ply, deadply, rag)

        -- cache Killing CVar here because it's used locally here
        local cv_phant_kill_policing_after_search = GetConVar("ttt_phantom_kill_policing_after_search"):GetBool()
        local cv_phant_rev_after_search_body_found = GetConVar("ttt_phantom_revive_after_found"):GetBool()

        if cv_phant_kill_policing_after_search and ply:GetSubRoleData().isPolicingRole and deadply:GetSubRole() == ROLE_PHANTOM then
            print("HOOKTEST")
            ply:Kill()

            if cv_phant_rev_after_search_body_found and not deadply.phant_data.revd_once then
                deadply:Revive(0.1,_,_,false,1)
            end
        end
    end)

    hook.Add("TTTBeginRound", "ttt2_role_phant_send_epop_to_begin_and_reset", function()
        local cv_phant_send_epop_at_beginning = GetConVar("ttt_phantom_send_epop_at_beginning"):GetBool()

        -- reset Phantom data
        ResetPhantom()
        
        -- send out an epop if cvar is configured as such
        if cv_phant_send_epop_at_beginning then
            net.Start("ttt2_phant_begin_epop")
            net.Broadcast()
        end
    end)

    -- reset Phantom data again
    hook.Add("TTTPrepareRound", "ttt2_role_phant_clear_data_prep", function()
        ResetPhantom()
    end)

    hook.Add("TTTEndRound", "ttt2_role_phant_clear_data_endround", function()
        ResetPhantom()
    end)
end

if CLIENT then
    net.Receive("ttt2_phant_begin_epop", function()
        EPOP:AddMessage({text = LANG.GetTranslation("ttt2_role_phantom_begin_epop"), color = PHANTOM.ltcolor}, "", 5)
    end)

    function ROLE:AddToSettingsMenu(parent)
        local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

        form:MakeHelp({
			label = "label_phantom_revive_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_revive_after_found",
			label = "label_phantom_revive_after_found"
		})

        form:MakeHelp({
			label = "label_phantom_rev_everytime_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_resurrection_everytime",
			label = "label_phantom_resurrection_everytime"
		})

        form:MakeHelp({
			label = "label_phantom_kill_everytime_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_kill_everytime",
			label = "label_phantom_kill_everytime"
		})

        form:MakeHelp({
			label = "label_phantom_prevention_no_t_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_prevent_confirmation",
			label = "label_phantom_prevent_confirmation"
		})

        form:MakeCheckBox({
			serverConvar = "ttt_phantom_prevent_all_searches",
			label = "label_phantom_prevent_all_searches"
		})

        form:MakeHelp({
			label = "label_phantom_prevention_only_t_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_traitor_prevent_search",
			label = "label_phantom_traitor_cannot_search"
		})

        form:MakeCheckBox({
			serverConvar = "ttt_phantom_traitor_prevent_search_all",
			label = "label_phantom_traitor_cannot_search_all"
		})

        form:MakeHelp({
			label = "label_phantom_begin_popup_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_send_epop_at_beginning",
			label = "label_phantom_send_epop_at_beginning"
		})

        form:MakeHelp({
			label = "label_phantom_prevent_policing_searches_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_prevent_policing_search_phantom",
			label = "label_phantom_prevent_policing_search_phantom"
		})

        form:MakeCheckBox({
			serverConvar = "ttt_phantom_prevent_policing_search_all",
			label = "label_phantom_prevent_policing_search_all"
		})

        form:MakeHelp({
			label = "label_phantom_kill_policing_nonetheless_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_kill_policing_after_search",
			label = "label_phantom_kill_policing_after_search"
		})

        form:MakeHelp({
			label = "label_phantom_in_round_hint_intel"
		})

		form:MakeCheckBox({
			serverConvar = "ttt_phantom_in_round_hint",
			label = "label_phantom_in_round_hint"
		})
    end
end
