#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: cwh_hud_fnc_updateSquad
Description:
    Refreshes the squad related data (called by the slow update):
    - Members of the player's group, used by the 3D markers and the compass.
    - Notifications when a member goes down or is killed.
    - Position marked on the compass: custom waypoint (shift + click on the
      map), destination of the current task, or current group waypoint.

Parameters:
    <NONE>

Returns:
    <NONE>

Author:
    Bragg
---------------------------------------------------------------------------- */

private _members = (units group player) select {_x != player};
GVAR(squadUnits) = _members select {alive _x};

// Squad member down (unconscious) or killed. A member seen for the first time takes its current
// state without notification (joining a group, respawn).
if (GVAR(notifySquad)) then {
    private _states = createHashMap;
    {
        private _key = hashValue _x;
        private _state = switch (true) do {
            case (!alive _x): {2};
            case (lifeState _x == "INCAPACITATED" || {_x getVariable ["ACE_isUnconscious", false]}): {1};
            default {0};
        };
        if (_state > GVAR(squadStates) getOrDefault [_key, _state]) then {
            [
                format [[LLSTRING(squadDown), LLSTRING(squadKilled)] select (_state - 1), name _x],
                ["warning", "alert"] select (_state - 1)
            ] call FUNC(notify);
        };
        _states set [_key, _state];
    } forEach _members;
    GVAR(squadStates) = _states;
};

// Compass waypoint
private _waypoint = [];
if (GVAR(compassShowWaypoint)) then {
    _waypoint = customWaypointPosition;

    if (_waypoint isEqualTo []) then {
        private _task = currentTask player;
        if (!isNull _task) then {
            private _destination = taskDestination _task;
            if (_destination isNotEqualTo [] && {_destination isNotEqualTo [0, 0, 0]}) then {
                _waypoint = _destination;
            };
        };
    };

    if (_waypoint isEqualTo []) then {
        private _group = group player;
        private _index = currentWaypoint _group;
        if (_index > 0 && {_index < count waypoints _group}) then {
            _waypoint = waypointPosition [_group, _index];
        };
    };
};
GVAR(compassWaypoint) = _waypoint;
