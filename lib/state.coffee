module.exports = (->

  @debug_mode = true

  @width = 1280 * 2
  @height = 480 * 2

  @player_movement_speed = 200

  @gravity =
    x: 0
    y: 800

  @collision_groups = {}
  @materials = {}
  @contact_materials = {}
  @groups = {}
  @animations = {}

  @keys =
    W: Phaser.Keyboard.W
    A: Phaser.Keyboard.A
    S: Phaser.Keyboard.S
    D: Phaser.Keyboard.D

  @groups = {}

  this

).apply {}
