module.exports = (->

  @debug_mode = false

  @width = 1280 * 2
  @height = 480 * 2

  @player_movement_speed = 75
  @player_run_speed = 150
  @player_stamina_drain = 1
  @stamina = 1000

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
    enter: Phaser.Keyboard.ENTER

  @groups = {}

  this

).apply {}
