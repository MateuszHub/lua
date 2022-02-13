local lapis = require("lapis")
local db = require("lapis.db")
local json_params = require("lapis.application").json_params
local Model = require("lapis.db.model").Model
local app = lapis.Application()

local items = Model:extend("items", {
  relations = {
    {"category", belongs_to = "categories"}
  }
})

app:get("/item", function()
  local row = items:select()
  return {json = { ["model"] = {row}} }
end)

app:get("/item/:id", function(self)
  local row = items:find(self.params.id)
  return {json = { ["model"] = {row}}}
end)

app:put("/item/:id", function(self)
  local row = items:find(self.params.id)
  row.category_id = self.params.category_id or row.category_id
  row.name = self.params.name or row.name
  row.price = self.params.price or row.price
  row:update("name", "price", "category_id")
  return  {json = { ["model"] = {row}}}
end)

app:delete("/item/:id", function(self)
  local row = items:find(self.params.id)
  row:delete()
  return {json = { ["model"] = {row}}}
end)

app:post("/item", function(self)
  print(self.params.name)
  local row = items:create({
    name = self.params.name,
    price = self.params.price,
    category_id = self.params.category_id
  })
  return {json= {["model"] = {row}}}
end)


local category = Model:extend("categories")
app:get("/category", function()
  local row = category:select()
  return {json = { ["model"] = {row}} }
end)

app:get("/category/:id", function(self)
  local row = category:find(self.params.id)
  return {json = { ["model"] = {row}}}
end)

app:put("/category/:id", function(self)
  local row = category:find(self.params.id)
  row.name = self.params.name or row.name
  row:update("name")
  return  {json = { ["model"] = {row}}}
end)

app:delete("/category/:id", function(self)
  local row = category:find(self.params.id)
  row:delete()
  return {json = { ["model"] = {row}}}
end)

app:post("/category", function(self)
  local row = category:create({
    name = self.params.name
  })
  return {json= {["model"] = {row}}}
end)


return app

