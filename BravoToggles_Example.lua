--[[
    By: Danny Del Rio
    @https://github.com/danderio/Honeycomb-Bravo-Lua_scripts

    Based on demo from FSUIPC SDK by Pete & John Dowson @http://www.fsuipc.com/  
    
	This example script shows how to control the LED's for the Honeycomb Bravo Throttle Quadrant.
	It uses the toggles switches to turn on and off the LED's via the Module: HoneycombBravoLEDs.lua

    Note: This demo was tested with MSFS2020
    
    Requires FSUIPC

]]

--------------------------------------------------------
HCA = "E" -- Honeycomb Bravo joystick letter

Vendor = 0x294B -- Honeycomb Bravo vendor id
Product = 0x1901 -- Honeycomb Bravo product id
Device = 0 -- Multiple devices of the same name need increasing Device numbers.
Pollrate = 25 -- Polling rate in number of polls per second
--------------------------------------------------------

BravoLEDs = require("HoneycombBravoLEDs")

Report = 0
dev, rd, wrf, wr, init = com.openhid(Vendor, Product, Device, Report)

if dev == 0 then
	ipc.log("Could not open HID")
	ipc.exit()
end


buttons = {}
prevToggleSwitches = 0 
currentToggleSwitches = 0

-----------------------------------------------------------------------
--toggle variables to make it easier to code
toggle_1_On = 0x2
toggle_1_Off = 0x4
toggle_2_On = 0x8
toggle_2_Off = 0x10
toggle_3_On = 0x20
toggle_3_Off = 0x40
toggle_4_On = 0x80
toggle_4_Off = 0x100
toggle_5_On = 0x200
toggle_5_Off = 0x400
toggle_6_On = 0x800
toggle_6_Off = 0x1000
toggle_7_On = 0x2000
toggle_7_Off = 0x4000
------------------------------------------------------------------------

function Poll(time)

    -- We use "readlast" so the values we use are the most up-to-date
    CurrentData, n, discards = com.readlast(dev, rd)

    if n ~= 0 then
 	  
        -- Extract the values we need
        buttons[1], currentToggleSwitches, buttons[3], buttons[4],buttons[5], buttons[6], buttons[7], buttons[8] = com.GetHidButtons(dev, CurrentData)
       
        -- check if toggle state changed   
        if currentToggleSwitches ~= prevToggleSwitches then

            if prevToggleSwitches ~= 0 then   --to prevent from checking state on startup
                
                --this function figures out what toggle switch changed
                on_toggle_Switch_Change()

                --optionally we can also send to FSUIPC as a set of virtual buttons
                --just uncomment the line below
                --ipc.writeUD(0x3340 + ((i-1) * 4), currentToggleSwitches)
                
            end

            prevToggleSwitches = currentToggleSwitches

        end

    end

end

--helper function to declutter code
function check_If_Toggle(stateValue)
	if logic.And(currentToggleSwitches, stateValue) == logic.And(prevToggleSwitches, stateValue) then
		return false
	else
		return true
	end

end

function isToggleState(toggle)
    if logic.And(currentToggleSwitches, toggle) ~= 0 then 
        return true
    else 
        return false
	end
end

function send_To_Bravo()
	i = com.writefeature(dev, BravoLEDs.getBravoString(), wfr)
end

function on_toggle_Switch_Change()
	--all toggle switches have 4 states, 2 per position (up position is either on or off, down position is either on or off)
	--so we only need to detect when one position changes state
	--checking for both events can lead to dual firing of events.

    --uncomment the ones you need
	if check_If_Toggle(toggle_1_On) then toggle_1()	end
	if check_If_Toggle(toggle_2_On) then toggle_2()	end
	if check_If_Toggle(toggle_3_On) then toggle_3() end
    if check_If_Toggle(toggle_4_On) then toggle_4() end
    --if check_If_Toggle(toggle_5_On) then toggle_5() end
    --if check_If_Toggle(toggle_6_On) then toggle_6() end
    --if check_If_Toggle(toggle_7_On) then toggle_7() end

    --You can also check for toggle off events like this:
    --if check_If_Toggle(toggle_7_Off) then toggle_7() end

end

--******************** Bravo Toggle Functions *************************************
function toggle_1()
	BravoLEDs.Toggle_LED_DOOR()
	send_To_Bravo()
end

function toggle_2()
	BravoLEDs.Toggle_LED_PARKING_BRAKE()
	send_To_Bravo()
end

function toggle_3()

	--Auto Pilot lights check !

	if logic.And(currentToggleSwitches, 0x40) ~= 0 then --switch is off
		BravoLEDs.Off_LED_HEADING()
		send_To_Bravo()

		BravoLEDs.Off_LED_NAV()
		send_To_Bravo()

		BravoLEDs.Off_LED_APR()
		send_To_Bravo()

		BravoLEDs.Off_LED_REV()
		send_To_Bravo()

		BravoLEDs.Off_LED_ALT()
		send_To_Bravo()

		BravoLEDs.Off_LED_VS()
		send_To_Bravo()

		BravoLEDs.Off_LED_IAS()
		send_To_Bravo()

		BravoLEDs.Off_LED_AP()
		send_To_Bravo()

	else  --switch is on
		BravoLEDs.On_LED_HEADING()
		send_To_Bravo()

		BravoLEDs.On_LED_NAV()
		send_To_Bravo()

		BravoLEDs.On_LED_APR()
		send_To_Bravo()

		BravoLEDs.On_LED_REV()
		send_To_Bravo()

		BravoLEDs.On_LED_ALT()
		send_To_Bravo()

		BravoLEDs.On_LED_VS()
		send_To_Bravo()

		BravoLEDs.On_LED_IAS()
		send_To_Bravo()

		BravoLEDs.On_LED_AP()
		send_To_Bravo()

	end
end

function toggle_4()

	-- Fun with landing gear lights!

	if logic.And(currentToggleSwitches, 0x80) ~= 0 then --switch is On
		
		BravoLEDs.On_LED_LEFT_GEAR_GREEN()
		send_To_Bravo()

		BravoLEDs.On_LED_NOSE_GEAR_GREEN()
		send_To_Bravo()

		BravoLEDs.On_LED_RIGHT_GEAR_GREEN()
		send_To_Bravo()

		BravoLEDs.Off_LED_LEFT_GEAR_GREEN()
		send_To_Bravo()
		BravoLEDs.On_LED_LEFT_GEAR_RED()
		send_To_Bravo()

		BravoLEDs.Off_LED_NOSE_GEAR_GREEN()
		send_To_Bravo()
		BravoLEDs.On_LED_NOSE_GEAR_RED()
		send_To_Bravo()

		BravoLEDs.Off_LED_RIGHT_GEAR_GREEN()
		send_To_Bravo()
		BravoLEDs.On_LED_RIGHT_GEAR_RED()
		send_To_Bravo()



	else   --switch is off
		BravoLEDs.Off_LED_LEFT_GEAR_RED()
		BravoLEDs.Off_LED_NOSE_GEAR_RED()
		BravoLEDs.Off_LED_RIGHT_GEAR_RED()
		BravoLEDs.Off_LED_LEFT_GEAR_GREEN()
		BravoLEDs.Off_LED_NOSE_GEAR_GREEN()
		BravoLEDs.Off_LED_RIGHT_GEAR_GREEN()
		send_To_Bravo()

	end

end

--*************** End Toggle Functions *******************************************


init = true
if init then
	-- Deal with initial values, if supplied (some joysticks don't)
	ipc.log("init seen!")

	-- turn all lights off
	i = com.writefeature(dev, "\0\0\0\0\0" , wrf)
	--Poll(0)
	init = false
end


if Pollrate == 0 then
   -- Ouch. Mustn't divide by zero!
   Pollrate = 25 
end

--kick off the timer to watch for events!
event.timer(1000/Pollrate, "Poll")  -- poll values 'Pollrate' times per second







