local L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGSb
L[PHANTOM.name] = "Phantom"
L["info_popup_" .. PHANTOM.name] = [[Du bist ein Phantom, ein Mythos. Wenn eine unschuldige Seele versucht, dich zu durchsuchen, kannst du von den Toten auferstehen und das Leben des Unschuldigen nehmen.]]
L["body_found_" .. PHANTOM.abbr] = "Das war ein Phantom."
L["search_role_" .. PHANTOM.abbr] = "Diese Person war ein Phantom!"
L["target_" .. PHANTOM.name] = "Phantom"
L["ttt2_desc_" .. PHANTOM.name] = [[Ein Phantom kann von den Toten auferstehen, wenn eine unschuldige Seele ihren Leichnam durchsucht.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_phantom_begin_epop"] = "Ein Phantom schwebt umher. Pass auf, wen du zu durchsuchen versuchst!"
L["ttt2_cannot_search_corpse_" .. PHANTOM.name] = "Du kannst diesen Leichnam nicht durchsuchen, da ein Phantom aktiv ist!"

-- F1 MENU: CONVAR EXPLANATIONS
L["label_phantom_revive_intel"] = "Wenn es auf wahr gesetzt ist, wird das Phantom wiederbelebt, nachdem ein Spieler den Leichnam des Phantoms durchsucht hat und gestorben ist."
L["label_phantom_revive_after_found"] = "Erwecke das Phantom wieder zum Leben, nachdem ein Spieler es durchsucht hat"

L["label_phantom_rev_everytime_intel"] = "Wenn es auf wahr gesetzt ist, wird das Phantom jedes Mal wiederbelebt, wenn ein Spieler die Leiche des Phantoms durchsucht hat. Aber Vorsicht: diese CVar wird nur verwendet, wenn das Phantom überhaupt wiederbelebt wird. Dazu muss die obige CVar ebenfalls aktiviert sein."
L["label_phantom_resurrection_everytime"] = "Das Phantom jedes Mal wieder auferstehen lassen, wenn jemand versucht, es zu durchsuchen"

L["label_phantom_kill_everytime_intel"] = "Wenn es auf wahr gesetzt ist, wird jeder Spieler, der versucht, die Leiche des Phantoms zu suchen, getötet. Andernfalls wird nur der erste Spieler getötet."
L["label_phantom_kill_everytime"] = "Töte jeden Spieler, der die Leiche des Phantoms durchsucht"

L["label_phantom_prevention_no_t_intel"] = "Diese Cvars steuern, welche Leichen von unschuldigen oder neutralen Spielern bestätigt werden können. Verräter und Detektive werden in den kommenden Cvars separat behandelt."
L["label_phantom_prevent_confirmation"] = "Verhindere, dass die Leiche des Phantoms bestätigt wird"
L["label_phantom_prevent_all_searches"] = "Verhindere, dass alle Leichen - außer die des Phantoms - bestätigt werden"

L["label_phantom_prevention_only_t_intel"] = "Diese Cvars steuern, welche Leichen von Verräter-Teammitgliedern bestätigt werden können."
L["label_phantom_traitor_cannot_search"] = "Verräter können die Leiche des Phantoms nicht durchsuchen"
L["label_phantom_traitor_cannot_search_all"] = "Verräter können keine Leichen durchsuchen - außer die des Phantoms"

L["label_phantom_begin_popup_intel"] = "Wenn es auf wahr eingestellt ist, wird zu Beginn der Runde ein Pop-up-Fenster angezeigt, dass sich ein Phantom unter den Spielern befindet."
L["label_phantom_send_epop_at_beginning"] = "Anzeigen eines Pop-ups, das die Spieler vor dem Phantom warnt"

L["label_phantom_prevent_policing_searches_intel"] = "Diese Cvars steuern, welche Leichen von bspw. Detektiven durchsucht werden können. Beachte: Wenn du verhinderst, dass Detektive Phantom-Leichen durchsuchen können, stirbt der Detektiv-Spieler bei dem Versuch, die Leiche des Phantoms zu durchsuchen."
L["label_phantom_prevent_policing_search_phantom"] = "Verhindere, dass die Leiche des Phantoms bestätigt wird"
L["label_phantom_prevent_policing_search_all"] = "Verhindere, dass alle Leichen - außer die des Phantoms - bestätigt werden"

L["label_phantom_kill_policing_nonetheless_intel"] = "Da etwa Detektive theoretisch Phantome bestätigen können, ohne getötet zu werden, kann dieser CVar verwendet werden, um zu steuern, dass etwa Detektive trotzdem sterben, sobald sie das Phantom bestätigen. Ob das Phantom dann wiederbelebt wird, wird durch den entsprechenden CVar oben gesteuert. Beachte, dass dies nur funktioniert, wenn die Suche nicht verhindert wird, und es funktioniert nur einmal, wenn die cvar 'kill everytime' nicht aktiv ist."
L["label_phantom_kill_policing_after_search"] = "Töte Detektive o.Ä. Rollen, wenn sie das Phantom bestätigen."

L["label_phantom_in_round_hint_intel"] = "Wenn diese Option auf true gesetzt ist, erhält der Spieler, der versucht, eine Leiche zu durchsuchen, dies aber nicht kann, eine Warnung, dass er diese Leiche nicht durchsuchen kann, weil ein Phantom unterwegs ist."
L["label_phantom_in_round_hint"] = "Anzeige einer Warnmeldung, dass Leichen nicht durchsucht werden können, während ein Phantom aktiv ist"