local lapis = require("lapis")
local Model
Model = require("lapis.db.model").Model
local respond_to
respond_to = require("lapis.application").respond_to
local Items
do
  local _class_0
  local _parent_0 = Model
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Items",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.primary_key = {
    "id"
  }
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Items = _class_0
end
local Categories
do
  local _class_0
  local _parent_0 = Model
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Categories",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.primary_key = {
    "id"
  }
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Categories = _class_0
end
local App
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/item"] = respond_to({
      GET = function(self)
        local row = Items:select()
        return {
          json = {
            model = row
          }
        }
      end,
      POST = function(self)
        local row = Items:create({
          name = self.params.name,
          category_id = self.params.category_id,
          price = self.params.price
        })
        return {
          json = {
            model = self.params
          }
        }
      end
    }),
    ["/item/:id"] = respond_to({
      GET = function(self)
        local row = Items:find(self.params.id)
        return {
          json = {
            model = row
          }
        }
      end,
      PUT = function(self)
        local row = Items:find(self.params.id)
        row:update({
          name = self.params.name,
          category_id = self.params.category_id,
          price = self.params.price
        })
        return {
          json = {
            model = row
          }
        }
      end,
      DELETE = function(self)
        local row = Items:find(self.params.id)
        row:delete()
        return {
          json = {
            model = row
          }
        }
      end
    }),
    ["/category"] = respond_to({
      GET = function(self)
        local row = Categories:select()
        return {
          json = {
            model = row
          }
        }
      end,
      POST = function(self)
        local row = Categories:create({
          name = self.params.name
        })
        return {
          json = {
            model = self.params
          }
        }
      end
    }),
    ["/category/:id"] = respond_to({
      GET = function(self)
        local row = Categories:find(self.params.id)
        return {
          json = {
            model = row
          }
        }
      end,
      PUT = function(self)
        local row = Categories:find(self.params.id)
        row:update({
          name = self.params.name
        })
        return {
          json = {
            model = row
          }
        }
      end,
      DELETE = function(self)
        local row = Categories:find(self.params.id)
        row:delete()
        return {
          json = {
            model = row
          }
        }
      end
    })
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "App",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  App = _class_0
  return _class_0
end
