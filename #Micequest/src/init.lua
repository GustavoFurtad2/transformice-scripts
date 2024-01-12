do
  local settings = {"AutoNewGame", "AutoShaman", "AfkDeath", "MortCommand", "PhysicalConsumables"}
  for _, i in next, settings do
     tfm.exec["disable" .. i]()
  end
end

tfm.exec.newGame[[<C><P G="0,0" MEDATA=";0,1;;;-0;0:::1-"/><Z><S/><D><DS X="390" Y="200"/></D><O/><L/></Z></C>]]
ui.setMapName("#Micequest")

local Datas, Timers = {}, {}
