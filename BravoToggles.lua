--[[
    By: Danny Del Rio
    @https://github.com/danderio/Honeycomb-Bravo-Lua_scripts

    Based on demo from FSUIPC SDK by Pete & John Dowson @http://www.fsuipc.com/  
    
    This script helps manage the events from toggle switches of the Honeycomb Bravo Throttle Quadrant.

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

function on_toggle_Switch_Change()
	--all toggle switches have 4 states, 2 per position (up position is either on or off, down position is either on or off)
	--so we only need to detect when one position changes state
	--checking for both events can lead to dual firing of events.

    --uncomment the ones you need
	if check_If_Toggle(toggle_1_On) then toggle_1()	end
	if check_If_Toggle(toggle_2_On) then toggle_2()	end
	--if check_If_Toggle(toggle_3_On) then toggle_3() end
    --if check_If_Toggle(toggle_4_On) then toggle_4() end
    --if check_If_Toggle(toggle_5_On) then toggle_5() end
    --if check_If_Toggle(toggle_6_On) then toggle_6() end
    --if check_If_Toggle(toggle_7_On) then toggle_7() end

    --You can also check for toggle off events like this:
    --if check_If_Toggle(toggle_7_Off) then toggle_7() end

end

--******************** Bravo Toggle Functions *************************************

function toggle_1()
    --now we know toggle #1 changed, lets figure out if its off or on
    --
    if isToggleState(toggle_1_On) then --switch is on
        --implement your switch function here
        --ie. turn on fuelpump
        if ipc.readUB(0x3104) == 0 then
            ipc.control(66339)
        end

    else  --switch is off
        --turn off fuel pump
        if ipc.readUB(0x3104) == 1 then
            ipc.control(66339)
        end
	end

end

function toggle_2()
    --in this example I want to test for the off position of toggle2
    if isToggleState(toggle_2_Off) then --switch is off
        --do something, like release parking brake
        if ipc.readUB(0x0BC8) ~= 0 then
            ipc.control(65752)
        end

        --I wouldnt implement parking release this way, but just to show that you could :-)
	end
end

function toggle_3()
    ipc.log("Toggle 3 changed state!")
end

function toggle_4()
    --TODO: implement your toggle switch logic
end

function toggle_5()
    --TODO: implement your toggle switch logic
end

function toggle_6()
    --TODO: implement your toggle switch logic
end

function toggle_7()
    --TODO: implement your toggle switch logic
end


--*************** End Toggle Functions *******************************************





if Pollrate == 0 then
   -- Ouch. Mustn't divide by zero!
   Pollrate = 25 
end

--kick off the timer to watch for events!
event.timer(1000/Pollrate, "Poll")  -- poll values 'Pollrate' times per second







