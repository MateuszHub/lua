lapis = require "lapis"
import Model from require "lapis.db.model"
import respond_to from require "lapis.application"

class Items extends Model
  @primary_key: {"id"}

class Categories extends Model
  @primary_key: {"id"}

class App extends lapis.Application
  "/item": respond_to {
      GET: =>
        row = Items\select!
        json: { model: row } 

      POST: =>
        row = Items\create {
          name: @params.name
          category_id: @params.category_id
          price: @params.price
        }
        json: { model: @params } 
      }

  "/item/:id": respond_to {
      GET: =>
        row = Items\find @params.id
        json: { model: row } 
      
      PUT: =>
        row = Items\find @params.id
        row\update {
          name: @params.name
          category_id: @params.category_id
          price: @params.price
        } 
        json: { model: row } 

      DELETE: =>
        row = Items\find @params.id
        row\delete!
        json: { model: row } 
    }

  "/category": respond_to {
      GET: =>
        row = Categories\select!
        json: { model: row } 

      POST: =>
        row = Categories\create {
          name: @params.name
        }
        json: { model: @params } 
      }

  "/category/:id": respond_to {
      GET: =>
        row = Categories\find @params.id
        json: { model: row } 
      
      PUT: =>
        row = Categories\find @params.id
        row\update {
          name: @params.name
        } 
        json: { model: row } 

      DELETE: =>
        row = Categories\find @params.id
        row\delete!
        json: { model: row } 
    }


