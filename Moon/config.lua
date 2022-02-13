local config
config = require("lapis.config").config
return config("development", function()
  return mysql(function()
    host("mysql")
    port("3306")
    user("root")
    password("root")
    return database("shop")
  end)
end)
