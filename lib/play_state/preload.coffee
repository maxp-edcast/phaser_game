module.exports = ->

  @game.load.spritesheet(
    'player', @Assets.player,
    64,64,16
  )

  # @game.load.tilemap(
  #   "tilemap1",
  #   @Assets.tilemap1,
  #   null,
  #   Phaser.Tilemap.TILED_JSON
  # )

  tileset_images = require("../../assets.json")
  console.log tileset_images
  for key,path of tileset_images
    @game.load.image(key, path)



