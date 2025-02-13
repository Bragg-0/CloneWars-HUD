#include "..\macro.hpp"

#define CreateError(ErrorText) diag_log format["[CWHUD] %1", ErrorText]

#define GetVarHUDColor profileNamespace getVariable["CWHUD_color", [ 0.5, 0.5, 0.5, 1 ]]
#define SetVarHUDColor(Color) profileNamespace setVariable["CWHUD_color", Color, true]