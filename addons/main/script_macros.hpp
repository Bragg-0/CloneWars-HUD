// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

/*
    Preprocessing and Compilation
*/
#undef PREP
#define LINKFUNC(x) FUNC(x)
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#define PREP_RECOMPILE_START ; /* disabled */
#define PREP_RECOMPILE_END ; /* disabled */
