import config from require "lapis.config"
config "development", ->
  mysql ->
    host "mysql"
    port "3306"
    user "root"
    password "root"
    database "shop"