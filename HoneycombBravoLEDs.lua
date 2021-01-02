--[[
    By: Danny Del Rio
    @https://github.com/danderio/Honeycomb-Bravo-Lua_scripts
    
    Note: This script is intended to used as a module to be called from another Lua script by FSUIPC.
    Pete & John Dowson @http://www.fsuipc.com/

    "BravoToggles_Example.lua" for exmaple on how to use.

    ----------------------------------------------------------

    Below this comment is the full list of LED's that are avialable to be controlled for the Honeycomb Bravo Throttle Quadrant.
    These are in the form of B.LED_<led name>

    For each LED light there are 3 functions: On, Off and Toggle

        function Toggle_LED_FUEL_PUMP()
        function On_LED_FUEL_PUMP()
        function Off_LED_FUEL_PUMP()

    Calling each function only sets the state values for the data string that needs to be sent to the Bravo Quadrant.
    The changes are not sent to the controller until you send them in your code. 
        
    To send the state change to the Bravo Quadrant, you can use the provided function that creates the data string to be sent to the controller
        function getBravoString()
    
    Use this with the FSUIPC library function "com.writefeature()" to send the values of the state registers to the controller, like this:
        com.writefeature(dev, getBravoString(), wfr)
]]


local B = {}
--------------------------------------------------------------------------------------------------------

B.ANUNCIATOR_W2 = 0
B.LED_FUEL_PUMP = 1
B.LED_PARKING_BRAKE = 2
B.LED_LOW_VOLTS = 4
B.LED_DOOR = 8

B.ANUNCIATOR_W1 = 0
B.LED_LOW_OIL_PRESS = 1
B.LED_LOW_FUEL_PRESS = 2
B.LED_ANTI_ICE = 4
B.LED_STARTER = 8
B.LED_APU = 16
B.LED_MASTER_CAUTION = 32
B.LED_VACUUM = 64
B.LED_LOW_HYD_PRESS = 128

B.LANDING_GEAR_W = 0
B.LED_LEFT_GEAR_GREEN = 1
B.LED_LEFT_GEAR_RED = 2
B.LED_NOSE_GEAR_GREEN = 4
B.LED_NOSE_GEAR_RED = 8
B.LED_RIGHT_GEAR_GREEN = 16
B.LED_RIGHT_GEAR_RED = 32
B.LED_MASTER_WARNING = 64
B.LED_ENGINE_FIRE = 128

B.AUTO_PILOT_W = 0
B.LED_HEADING = 1
B.LED_NAV = 2
B.LED_APR = 4
B.LED_REV	= 8
B.LED_ALT	= 16
B.LED_VS = 32
B.LED_IAS = 64
B.LED_AP = 128

-----------------------------------------------------------------------------------------------------------------------

function B.getBravoString()
    strLightCommand = string.char(0) .. string.char(B.AUTO_PILOT_W) .. string.char(B.LANDING_GEAR_W) .. string.char(B.ANUNCIATOR_W1) .. string.char(B.ANUNCIATOR_W2)
    return strLightCommand
end

----------------------------------------------

function B.Toggle_LED_FUEL_PUMP()
    B.ANUNCIATOR_W2 = logic.Xor(B.ANUNCIATOR_W2, B.LED_FUEL_PUMP)
end

function B.On_LED_FUEL_PUMP()
    B.ANUNCIATOR_W2 = logic.Or(B.ANUNCIATOR_W2, B.LED_FUEL_PUMP)
end

function B.Off_LED_FUEL_PUMP()
    B.ANUNCIATOR_W2 = logic.And(B.ANUNCIATOR_W2, logic.Not(B.LED_FUEL_PUMP))
end

----------------------------------------------

function B.Toggle_LED_PARKING_BRAKE()
    B.ANUNCIATOR_W2 = logic.Xor(B.ANUNCIATOR_W2, B.LED_PARKING_BRAKE)
end

function B.On_LED_PARKING_BRAKE()
    B.ANUNCIATOR_W2 = logic.Or(B.ANUNCIATOR_W2, B.LED_PARKING_BRAKE)
end

function B.Off_LED_PARKING_BRAKE()
    B.ANUNCIATOR_W2 = logic.And(B.ANUNCIATOR_W2, logic.Not(B.LED_PARKING_BRAKE))
end

----------------------------------------------

function B.Toggle_LED_LOW_VOLTS()
    B.ANUNCIATOR_W2 = logic.Xor(B.ANUNCIATOR_W2, B.LED_LOW_VOLTS)
end

function B.On_LED_LOW_VOLTS()
    B.ANUNCIATOR_W2 = logic.Or(B.ANUNCIATOR_W2, B.LED_LOW_VOLTS)
end

function B.Off_LED_LOW_VOLTS()
    B.ANUNCIATOR_W2 = logic.And(B.ANUNCIATOR_W2, logic.Not(B.LED_LOW_VOLTS))
end

----------------------------------------------

function B.Toggle_LED_DOOR()
    B.ANUNCIATOR_W2 = logic.Xor(B.ANUNCIATOR_W2, B.LED_DOOR)
end

function B.On_LED_DOOR()
    B.ANUNCIATOR_W2 = logic.Or(B.ANUNCIATOR_W2, B.LED_DOOR)
end

function B.Off_LED_DOOR()
    B.ANUNCIATOR_W2 = logic.And(B.ANUNCIATOR_W2, logic.Not(B.LED_DOOR))
end

----------------------------------------------

function B.Toggle_LED_LOW_OIL_PRESS()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_LOW_OIL_PRESS)
end

function B.On_LED_LOW_OIL_PRESS()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_LOW_OIL_PRESS)
end

function B.Off_LED_LOW_OIL_PRESS()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_LOW_OIL_PRESS))
end

----------------------------------------------

function B.Toggle_LED_LOW_FUEL_PRESS()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_LOW_FUEL_PRESS)
end

function B.On_LED_LOW_FUEL_PRESS()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_LOW_FUEL_PRESS)
end

function B.Off_LED_LOW_FUEL_PRESS()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_LOW_FUEL_PRESS))
end

----------------------------------------------

function B.Toggle_LED_ANTI_ICE()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_ANTI_ICE)
end

function B.On_LED_ANTI_ICE()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_ANTI_ICE)
end

function B.Off_LED_ANTI_ICE()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_ANTI_ICE))
end

----------------------------------------------

function B.Toggle_LED_STARTER()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_STARTER)
end

function B.On_LED_STARTER()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_STARTER)
end

function B.Off_LED_STARTER()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_STARTER))
end

----------------------------------------------

function B.Toggle_LED_APU()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_APU)
end

function B.On_LED_APU()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_APU)
end

function B.Off_LED_APU()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_APU))
end

----------------------------------------------

function B.Toggle_LED_MASTER_CAUTION()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_MASTER_CAUTION)
end

function B.On_LED_MASTER_CAUTION()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_MASTER_CAUTION)
end

function B.Off_LED_MASTER_CAUTION()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_MASTER_CAUTION))
end

----------------------------------------------

function B.Toggle_LED_VACUUM()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_VACUUM)
end

function B.On_LED_VACUUM()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_VACUUM)
end

function B.Off_LED_VACUUM()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_VACUUM))
end

----------------------------------------------

function B.Toggle_LED_LOW_HYD_PRESS()
    B.ANUNCIATOR_W1 = logic.Xor(B.ANUNCIATOR_W1, B.LED_LOW_HYD_PRESS)
end

function B.On_LED_LOW_HYD_PRESS()
    B.ANUNCIATOR_W1 = logic.Or(B.ANUNCIATOR_W1, B.LED_LOW_HYD_PRESS)
end

function B.Off_LED_LOW_HYD_PRESS()
    B.ANUNCIATOR_W1 = logic.And(B.ANUNCIATOR_W1, logic.Not(B.LED_LOW_HYD_PRESS))
end

----------------------------------------------

function B.Toggle_LED_LEFT_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_LEFT_GEAR_GREEN)
end

function B.On_LED_LEFT_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_LEFT_GEAR_GREEN)
end

function B.Off_LED_LEFT_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_LEFT_GEAR_GREEN))
end

----------------------------------------------

function B.Toggle_LED_LEFT_GEAR_RED()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_LEFT_GEAR_RED)
end

function B.On_LED_LEFT_GEAR_RED()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_LEFT_GEAR_RED)
end

function B.Off_LED_LEFT_GEAR_RED()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_LEFT_GEAR_RED))
end

----------------------------------------------

function B.Toggle_LED_NOSE_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_NOSE_GEAR_GREEN)
end

function B.On_LED_NOSE_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_NOSE_GEAR_GREEN)
end

function B.Off_LED_NOSE_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_NOSE_GEAR_GREEN))
end

----------------------------------------------

function B.Toggle_LED_NOSE_GEAR_RED()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_NOSE_GEAR_RED)
end

function B.On_LED_NOSE_GEAR_RED()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_NOSE_GEAR_RED)
end

function B.Off_LED_NOSE_GEAR_RED()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_NOSE_GEAR_RED))
end

----------------------------------------------

function B.Toggle_LED_RIGHT_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_RIGHT_GEAR_GREEN)
end

function B.On_LED_RIGHT_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_RIGHT_GEAR_GREEN)
end

function B.Off_LED_RIGHT_GEAR_GREEN()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_RIGHT_GEAR_GREEN))
end

----------------------------------------------

function B.Toggle_LED_RIGHT_GEAR_RED()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_RIGHT_GEAR_RED)
end

function B.On_LED_RIGHT_GEAR_RED()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_RIGHT_GEAR_RED)
end

function B.Off_LED_RIGHT_GEAR_RED()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_RIGHT_GEAR_RED))
end

----------------------------------------------

function B.Toggle_LED_MASTER_WARNING()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_MASTER_WARNING)
end

function B.On_LED_MASTER_WARNING()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_MASTER_WARNING)
end

function B.Off_LED_MASTER_WARNING()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_MASTER_WARNING))
end

----------------------------------------------

function B.Toggle_LED_ENGINE_FIRE()
    B.LANDING_GEAR_W = logic.Xor(B.LANDING_GEAR_W, B.LED_ENGINE_FIRE)
end

function B.On_LED_ENGINE_FIRE()
    B.LANDING_GEAR_W = logic.Or(B.LANDING_GEAR_W, B.LED_ENGINE_FIRE)
end

function B.Off_LED_ENGINE_FIRE()
    B.LANDING_GEAR_W = logic.And(B.LANDING_GEAR_W, logic.Not(B.LED_ENGINE_FIRE))
end

----------------------------------------------

function B.Toggle_LED_HEADING()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_HEADING)
end

function B.On_LED_HEADING()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_HEADING)
end

function B.Off_LED_HEADING()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_HEADING))
end

----------------------------------------------

function B.Toggle_LED_NAV()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_NAV)
end

function B.On_LED_NAV()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_NAV)
end

function B.Off_LED_NAV()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_NAV))
end

----------------------------------------------

function B.Toggle_LED_APR()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_APR)
end

function B.On_LED_APR()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_APR)
end

function B.Off_LED_APR()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_APR))
end

----------------------------------------------

function B.Toggle_LED_REV()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_REV)
end

function B.On_LED_REV()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_REV)
end

function B.Off_LED_REV()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_REV))
end

----------------------------------------------

function B.Toggle_LED_ALT()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_ALT)
end

function B.On_LED_ALT()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_ALT)
end

function B.Off_LED_ALT()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_ALT))
end

----------------------------------------------

function B.Toggle_LED_VS()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_VS)
end

function B.On_LED_VS()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_VS)
end

function B.Off_LED_VS()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_VS))
end

----------------------------------------------

function B.Toggle_LED_IAS()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_IAS)
end

function B.On_LED_IAS()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_IAS)
end

function B.Off_LED_IAS()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_IAS))
end

----------------------------------------------

function B.Toggle_LED_AP()
    B.AUTO_PILOT_W = logic.Xor(B.AUTO_PILOT_W, B.LED_AP)
end

function B.On_LED_AP()
    B.AUTO_PILOT_W = logic.Or(B.AUTO_PILOT_W, B.LED_AP)
end

function B.Off_LED_AP()
    B.AUTO_PILOT_W = logic.And(B.AUTO_PILOT_W, logic.Not(B.LED_AP))
end

----------------------------------------------


return B
