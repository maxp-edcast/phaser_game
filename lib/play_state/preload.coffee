module.exports = ->

  @game.load.spritesheet(
    'player', @Assets.player,
    32,32,16
  )

  @game.load.tilemap(
    "government_facility",
    @Assets.government_facility,
    null,
    Phaser.Tilemap.TILED_JSON
  )

  @tileset_images = require("../../assets.json")
  for key,path of @tileset_images
    @game.load.image(key, path)



