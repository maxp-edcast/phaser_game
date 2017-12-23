module.exports = load: (caller) -> (->

  { game } = caller

  @debug_mode = true

  @width = 700
  @height = 500

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

  @cursors = game.input.keyboard.createCursorKeys()
  @game_keys =
    W: game.input.keyboard.addKey @keys.W
    A: game.input.keyboard.addKey @keys.A
    S: game.input.keyboard.addKey @keys.S
    D: game.input.keyboard.addKey @keys.D


  this

).apply {}
