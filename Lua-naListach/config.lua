local config = require("lapis.config")

config({"development", "production"}, {
  mysql = {
    host = "mysql",
    port = "3306",
    database = "shop",
    user = "root",
    password = "root"
  }
})