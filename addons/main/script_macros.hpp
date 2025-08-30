#define DEBUG_SYNCHRONOUS

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE
#define ENABLE_PERFORMANCE_COUNTERS

#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

/*
    Boolean
*/
#define TRUE 1
#define FALSE 0

/*
    SubComponent
*/
#ifdef SUBCOMPONENT
    #undef PATHTOF
    #define PATHTOF(var1) PATHTOF_SYS(PREFIX,DOUBLES(COMPONENT,SUBCOMPONENT),var1)

    #undef PATHTO
    #define PATHTO(var1) PATHTO_SYS(PREFIX,DOUBLES(COMPONENT_F,SUBCOMPONENT),var1)

    #define SUBGVAR(var1) DOUBLES(SUBADDON,var1)
    #define QSUBGVAR(var1) QUOTE(SUBGVAR(var1))

    #define ESUBGVAR(var1,var2) TRIPLES(SUBADDON,var1,var2)
    #define QESUBGVAR(var1,var2) QUOTE(ESUBGVAR(var1,var2))

    #define SUBFUNC(var1) TRIPLES(SUBADDON,fnc,var1)
    #define QSUBFUNC(var1) QUOTE(SUBFUNC(var1))
    #define QQSUBFUNC(var1) QUOTE(QSUBFUNC(var1))

    #undef COMPILE_SCRIPT
    #define COMPILE_SCRIPT(var1) compileScript ['PATHTO_SYS(PREFIX,DOUBLES(COMPONENT_F,SUBCOMPONENT),var1)']
#endif

/*
    Preprocessing and Compilation
*/
#undef PREP
#ifdef SUBCOMPONENT
    #define LINKFUNC(x) SUBFUNC(x)
    #define PREP(fncName) [ QPATHTOF(functions\DOUBLES(fnc,fncName).sqf),QSUBFUNC(fncName) ] call CBA_fnc_compileFunction
    #define PREP_RECOMPILE_START ; /* disabled */
    #define PREP_RECOMPILE_END ; /* disabled */
#else
    #define LINKFUNC(x) FUNC(x)
    #define PREP(fncName) [ QPATHTOF(functions\DOUBLES(fnc,fncName).sqf),QFUNC(fncName) ] call CBA_fnc_compileFunction
    #define PREP_RECOMPILE_START ; /* disabled */
    #define PREP_RECOMPILE_END ; /* disabled */
#endif

/*
    Material Light
*/
#define MATERIAL_LIGHT(var1) QPATHTOEF(main,data\rvmat\Light.rvmat)
