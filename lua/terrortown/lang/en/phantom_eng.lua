local L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[PHANTOM.name] = "Phantom"
L["info_popup_" .. PHANTOM.name] = [[You are a Phantom, a myth. When an innocent soul tries to search you, you can rise from the dead, taking the innocent's live!]]
L["body_found_" .. PHANTOM.abbr] = "They were a Phantom."
L["search_role_" .. PHANTOM.abbr] = "This person was a Phantom!"
L["target_" .. PHANTOM.name] = "Phantom"
L["ttt2_desc_" .. PHANTOM.name] = [[Phantom can rise from the dead, when an innocent souls, searches their corpse.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_phantom_begin_epop"] = "A Phantom floats around. Watch out who you try to confirm!"
L["ttt2_cannot_search_corpse_" .. PHANTOM.name] = "You cannot search this corpse due to a phantom being active!"

-- F1 MENU: CONVAR EXPLANATIONS
L["label_phantom_revive_intel"] = "If it's set to true, the Phantom gets revived after a player searched the Phantom's corpse and died."
L["label_phantom_revive_after_found"] = "Resurrect the Phantom after a player searched them"

L["label_phantom_rev_everytime_intel"] = "If it's set to true, the Phantom gets revived everytime after a player searched the Phantom's corpse. But caution: this convar is only used if the Phantom is revived at all. For this, the above CVar must also be activated."
L["label_phantom_resurrection_everytime"] = "Resurrect the Phantom everytime when someone tries to search them"

L["label_phantom_kill_everytime_intel"] = "If it's set to true, every player that tries to search the Phantom's corpse is killed. Otherwise only the first player is killed."
L["label_phantom_kill_everytime"] = "Kill every player that searches the Phantom's corpse"

L["label_phantom_prevention_no_t_intel"] = "These cvars control which corpses can be confirmed by innocent or neutral players. Traitors and policing roles (like detectives) will be handled separately through the upcoming cvars."
L["label_phantom_prevent_confirmation"] = "Prevent the Phantom's corpse from being confirmed"
L["label_phantom_prevent_all_searches"] = "Prevent all corpses - except the Phantom's one - from being confirmed"

L["label_phantom_prevention_only_t_intel"] = "These cvars control which corpses can be confirmed by traitor-teammembers."
L["label_phantom_traitor_cannot_search"] = "Traitors cannot search the Phantom's corpse"
L["label_phantom_traitor_cannot_search_all"] = "Traitors cannot search all corpses - except the Phantom's one"

L["label_phantom_begin_popup_intel"] = "If it's set to true, a pop-up will announce at the beginning of the round that there is a phantom among the players."
L["label_phantom_send_epop_at_beginning"] = "Display a pop-up that will warn players about the Phantom"

L["label_phantom_prevent_policing_searches_intel"] = "These cvars control which corpses can be confirmed by public-policing roles, such as detectives. Notice: If you prevent that policing roles can search Phantom corpses, the public-policing player will die by trying to search the Phantom's corpse."
L["label_phantom_prevent_policing_search_phantom"] = "Prevent the Phantom's corpse from being confirmed by public-policing roles"
L["label_phantom_prevent_policing_search_all"] = "Prevent all corpses - except the Phantom's one - from being confirmed by public-policing roles"

L["label_phantom_kill_policing_nonetheless_intel"] = "Since public-policing roles can theoretically confirm Phantoms without being killed, this CVar can be used to control that a policing role still dies as soon as they confirm the Phantom. Whether the Phantom is then revived is controlled by the corresponding CVar above."
L["label_phantom_kill_policing_after_search"] = "Kill public-policing roles, when they confirm the Phantom"

L["label_phantom_in_round_hint_intel"] = "If it's set to true, the player who tries to search a corpse but cannot, receives a warning that they cannot search that corpse because a phantom is on the move."
L["label_phantom_in_round_hint"] = "Display a warn message that corpses can't be searched while a Phantom is active"