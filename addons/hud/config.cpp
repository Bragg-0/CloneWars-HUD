#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = AUTHOR;
        authors[] = { "Bragg" };
        url = ECSTRING(main,url);
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { QUOTE(MAIN_ADDON) };
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

class RscText;
class RscPicture;
class RscPictureKeepAspect;
class RscProgress;

class RscTitles {
    #include "rsc\rscHUD.hpp"
};

#include "CfgEventHandlers.hpp"
