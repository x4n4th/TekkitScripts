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
  for i = 1, 16, 1 do
    if connections[i].color == color then
      if connections[i].isOn == on then
        return
      end  
      redstone.setBundledOutput("back", 0)
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
    overHeatingAlert(1, true)
    if not(colors.test (redstone.getBundledOutput("back"), colors.white)) then
      print "Reactor #1 OverHeating Shutting it Down."
    end
    setOutput("white", true)
	else
    overHeatingAlert(1, false)
		setOutput("white", false)
	end
end

--Reactor 2 Emergency Shutdown Controller
--Checks to make sure that the reactor is staying within temperature
function reactor2EmergencyShutdownController()
	if (colors.test (redstone.getBundledInput("back"), colors.magenta)) then
    overHeatingAlert(2, true)
    if not(colors.test (redstone.getBundledOutput("back"), colors.pink)) then
      print "Reactor #2 OverHeating Shutting it Down."
    end
    setOutput("pink", true)
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
  sensors.setActiveReading(controllerSide, reactor1Sensor, "ReactorContent")
  contents = sensors.getReadingAsTable(controllerSide, reactor1Sensor)
  
  local emptyUranium = 0
  local uranium = 0
  local reactor1State = 0
  local ice = 0;
  
  for i=1,#contents-1,2 do
    if(string.find(contents[i+1],"1*UranEmpty") ~= nil) then
      emptyUranium = emptyUranium + 1
    end
    if(string.find(contents[i+1],"1*Uran") ~= nil) then
      uranium = uranium + 1
    end
    if(string.find(contents[i+1],"1*ice") ~= nil) then
      ice = ice + 1
    end
  end
  
  uranium = uranium - emptyUranium
  
  print("Empty Uranium cells	 : "..emptyUranium)
  print("Ice Blocks	 : "..ice)
  if emptyUranium > 0 or uranium < 47 then
    reactor1State = 1
  else
    reactor1State = 0
  end
  
  -- Remove ice if there is more than 7 stacks in the reactor
  if ice > 7 then
    print "grey is false"
    setOutput("grey", false)
  else
    setOutput("grey", true)
  end
  -- remove uranium if there is more than 47
  if uranium > 47 then 
    print "brown is false"
    setOutput("brown", false)
  else
    setOutput("brown", true)
  end
    
  -- reactor states
  -- 0 is default state - cooling on
  -- 1 is cooling of - depleated uranium extractor on. uranium injector on
  if reactor1State == 0 then
    setOutput("cyan", true)
    setOutput("lime", true)
    setOutput("yellow", false)
  end
  
  if reactor1State == 1 then
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

-- setup ccSensors and set reactors sensor
function initializeSensors()
  controllerSide = sensors.getController()
  sensorDict = sensors.getSensors(controllerSide)
  reactor1Sensor = sensorDict[1]
end

--main

controllerSide = nil
sensorsDict = nil

print "Welcome to ReactorControl"
print "Starting ReactorControl"

while true do
  sleep(0.1)
  initializeSensors()
  reactorEmergencyShutdownHandler()
  reactorFuelHandler()
end