module.exports = ->

  @game.load.spritesheet(
    'player', @Assets.player,
    64,64,16
  )
  @game.load.spritesheet(
    'rock', @Assets.rock,
    240, 240, 64
  )

  @game.load.physics(
    'rock_physics', @Assets.rock_physics
  )

  @game.load.tilemap(
    "tilemap1",
    @Assets.tilemap1,
    null,
    Phaser.Tilemap.TILED_JSON
  )

# (key, tileWidth, tileHeight, width, height
  @game.load.image("tileset1", @Assets.tileset1)
  # @game.load.image("object1", @Assets.object1)



