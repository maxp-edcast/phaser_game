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

  @game.load.image(
    'invisible', @Assets.invisible
  )