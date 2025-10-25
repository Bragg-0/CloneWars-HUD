#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Categories for the settings
private _categoryGlobal = QUOTE(MOD_NAME);
private _categoryColors = [QUOTE(MOD_NAME), "Colors"];
private _categoryListHelmets = [QUOTE(MOD_NAME), "Helmets"];

// Default helmet lists
private _listDefaultARFHelmet = str ["ls_gar_phase1Arf_helmet", "ls_gar_scout_helmet", "ls_gar_engineer_helmet", "ls_gar_phase1Arf_helmet", "ls_gar_phase2Arf_helmet", "ls_cloneHelmet_arf"];
private _listDefaultBARCHelmet = str ["JLTS_CloneHelmetAB", "JLTS_CloneHelmetBARC", "ls_gar_barc_helmet", "ls_gar_airborne_helmet", "ls_cloneHelmet_airborne","ls_gar_phase2Insulated_helmet"];
private _listDefaultP1Helmet = str ["ls_gar_phase1_helmet", "ls_gar_phase1Pilot_helmet", "ls_sob_phase1SpecOp_helmet", "ls_gar_rex_helmet","ls_sob_commando_helmet"];
private _listDefaultP2Helmet = str ["JLTS_CloneHelmetP2", "JLTS_CloneHelmetP2MC", "JLTS_CloneHelmetP2_rework", "ls_gar_phase2_helmet", "ls_gar_phase2Pilot_helmet", "ls_sob_phase2SpecOp_helmet", "ls_cloneHelmet_phase2", "ls_cloneHelmet_phase2Pilot", "ls_cloneHelmet_arc", "ls_gar_arc_helmet"];

#include "initSettings.inc.sqf"
#include "initKeybinds.inc.sqf"

ADDON = true;
