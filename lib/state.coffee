module.exports = (->

  @debug_mode = true

  @width = 1280
  @height = 480

  @player_movement_speed = 75
  @player_run_speed = 150
  @player_stamina_drain = 1
  @stamina = 1000

  @gravity =
    x: 0
    y: 800

  @lightAngle = Math.PI/4
  @numberOfRays = 20
  @rayLength = 100

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
