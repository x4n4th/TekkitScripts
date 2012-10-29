-- Lua Script to control tekkit nuclear reactors

-- Make redstone connections toggleable
connections = {
  {colorInt = 1, color = "white", isOn = false},
  {colorInt = 2, color = "orange", isOn = false},
  {colorInt = 4, color = "magenta", isOn = false},
  {colorInt = 8, color = "lightblue",  isOn = false},
  {colorInt = 16, color = "yellow", isOn = false},
  {colorInt = 32, color = "lime", isOn = false},
  {colorInt = 64, color = "pink", isOn = false},
  {colorInt = 128, color = "grey", isOn = false},
  {colorInt = 256, color = "lightgrey", isOn = false},
  {colorInt = 512, color = "cyan", isOn = false},
  {colorInt = 1024, color = "purple", isOn = false},
  {colorInt = 2048, color = "blue", isOn = false},
  {colorInt = 4096, color = "brown", isOn = false},
  {colorInt = 8192, color = "green", isOn = false},
  {colorInt = 16384, color = "red", isOn = false},
  {colorInt = 32768, color = "black", isOn = false}
}

overHeatingReactors = {
  {reactorNum = 1, overHeating = false},
  {reactorNum = 2, overHeating = false}
}

-- Set the output of a certain wire
function setOutput(color, on)
  redstone.setBundledOutput("back", 0)
  
  for i = 1, 16, 1 do
    if connections[i].color == color then
      connections[i].isOn = on
    end
  end
  
  local highOutputs = 0
  
  for i = 1, 16, 1 do
    if connections[i].isOn then  
      highOutputs = (connections[i].colorInt) + highOutputs
    end
  end  
  redstone.setBundledOutput("back", highOutputs)
end

--Reactor 1 Emergency Shutdown Controller
--Checks to make sure that the reactor is staying within temperature
function reactor1EmergencyShutdownController()
  if (colors.test (redstone.getBundledInput("back"), colors.orange)) then
    setOutput("white", true)
    overHeatingAlert(1, true)
    if output == false then
      print "Reactor #1 OverHeating Shutting it Down."
      output = true
    else
      output = false
    end
  else 
    overHeatingAlert(1, false)
    setOutput("white", false)
  end
end
--Reactor 2 Emergency Shutdown Controller
--Checks to make sure that the reactor is staying within temperature
function reactor2EmergencyShutdownController()
  if (colors.test (redstone.getBundledInput("back"), colors.magenta)) then
    setOutput("pink", true)
    overHeatingAlert(2, true)
    if output == false then
      print "Reactor #2 OverHeating Shutting it Down."
      output = true
    else
      output = false
    end
  else 
    setOutput("pink", false)
    overHeatingAlert(2, false)
  end
end

-- Alert User Reactor Number and true if over heating
function overHeatingAlert(number, bool)
  for i = 1, 2, 1 do
    if overHeatingReactors[i].reactorNum == number then
      overHeatingReactors[i].overHeating = bool
      break
    end
  end
    
  for i = 1, 2, 1 do
    if overHeatingReactors[i].overHeating == true then
      setOutput("purple", true)
      break
    else 
      setOutput("purple", false)
    end
  end
end

-- Reactor 1 cooling and fuel system
--  toggle true to disable the injectors/recievers
-- setOutput("cyan", true) Fuel Injector
-- setOutput("lime", true) Spent fuel reciever
-- setOutput("yellow", false) ice dispenser
  
function reactor1FuelController()
  if reactor1Status == 0 then
    setOutput("cyan", true)
    setOutput("lime", true)
    setOutput("yellow", false)
  end
  
  if reactor1Status == 1 then
    setOutput("cyan", false)
    setOutput("lime", false)
    setOutput("yellow", true)
  end
end

-- Reactor Fuel Handler
function reactorFuelHandler()
  reactor1FuelController()
end

-- Reactor Emergency ShutDown Handler.
function reactorEmergencyShutdownHandler()
  reactor1EmergencyShutdownController()
  reactor2EmergencyShutdownController()
end

--main
print "Welcome to ReactorControl"
print "Starting ReactorControl"

local output = false
reactor1Status = 0
while true do
  os.pullEvent() 
  reactorEmergencyShutdownHandler()
end