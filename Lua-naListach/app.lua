local lapis = require("lapis")
local db = require("lapis.db")
local json_params = require("lapis.application").json_params
local app = lapis.Application()
require 'saveTable'


local items = {
  size = 0,
  list = { },
  select = function(self)
    return self.list
  end,
  find = function(self, id)
    return self.list[tonumber(id)]
  end,
  set = function(self, id, name, price, category_id)
    category_id = tonumber(category_id)
    id = tonumber(id)
    self.list[id] = {["price"] = price, ["name"] = name,["category_id"] = category_id}
    return self.list[id]
  end,
  delete = function(self, id) 
    id = tonumber(id)
    self.list[id] = nil
    for i=id,self.size-1 do
      self.list[i] = self.list[i + 1]
    end
    self.size = self.size - 1
  end,
  create = function(self, name, price, category_id)
    category_id = tonumber(category_id)
    self.size =  self.size + 1
    self.list[self.size] = {["price"] = price, ["name"] = name,["category_id"] = category_id}
    return self.list[self.size]
  end,
  save = function(self)
    table.save(self.list, "data")
  end,
  restore = function(self)
    self.list  = table.load( "data" )
    self.size = #self.list
  end
}

local category = {
  size = 0,
  list = { },
  select = function(self)
    return self.list
  end,
  find = function(self, id)
    return self.list[tonumber(id)]
  end,
  set = function(self, id, name)
    id = tonumber(id)
    self.list[id] = {["name"] = name}
    return self.list[id]
  end,
  delete = function(self, id) 
    id = tonumber(id)
    self.list[id] = nil
    for i=id,self.size-1 do
      self.list[i] = self.list[i + 1]
    end
    self.size = self.size - 1
  end,
  create = function(self, name)
    self.size =  self.size + 1
    self.list[self.size] = {["name"] = name}
    return self.list[self.size]
  end,
  save = function(self)
    table.save(self.list, "catdata")
  end,
  restore = function(self)
    self.list  = table.load( "catdata" )
    self.size = #self.list
  end
}

function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then
     io.close(f) 
     return true 
  end
  return false
end

app:before_filter(function(self)
  if file_exists("data") then 
    items:restore()
  end
  if not file_exists("data") then 
    items:save()
  end
  if file_exists("catdata") then 
    category:restore()
  end
  if not file_exists("catdata") then 
    category:save()
  end
end)

app:get("/item", function(self)
  local row = items:select()
  return {json = { ["model"] = {row}} }
end)

app:get("/item/:id", function(self)
  local row = items:find(self.params.id)
  return {json = { ["model"] = {row}}}
end)

app:put("/item/:id", function(self)
  items:set(self.params.id, self.params.name, self.params.price, self.params.category_id)
  local row = items:find(self.params.id)
  items:save()
  return  {json = { ["model"] = {row}}}
end)

app:delete("/item/:id", function(self)
  local row = items:find(self.params.id)
  items:delete(self.params.id)
  items:save()
  return {json = { ["model"] = {row}}}
end)

app:post("/item", function(self)

  local row = items:create(
    self.params.name,
    self.params.price,
    self.params.category_id
  )
  items:save()
  return {json= {["model"] = {row}}}
end)


app:get("/category", function()
  local row = category:select()
  return {json = { ["model"] = {row}} }
end)

app:get("/category/:id", function(self)
  local row = category:find(self.params.id)
  return {json = { ["model"] = {row}}}
end)

app:put("/category/:id", function(self)
  category:set(self.params.id, self.params.name)
  local row = category:find(self.params.id)
  category:save()
  return  {json = { ["model"] = {row}}}
end)

app:delete("/category/:id", function(self)
  local row = category:find(self.params.id)
  category:delete(self.params.id)
  category:save()
  return {json = { ["model"] = {row}}}
end)

app:post("/category", function(self)
  local row = category:create(self.params.name)
  category:save()
  return {json= {["model"] = {row}}}
end)


return app

