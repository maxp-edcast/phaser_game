module.exports = load: (caller) -> (->

  { game } = caller

  @game_width = GameWidth
  @game_height = GameHeight

  @midpoint_x = @game_width / 2
  @midpoint_y = @game_height / 2

  @collision_groups = {}
  @materials = {}
  @contact_materials = {}
  @groups = {}
  @animations = {}

  @player = null
  @player_anim_speed = 5
  @player_walking = false
  @player_walking_direction = null

  @rock_anim_speed = 5

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

  @gravity =
    x: 0
    y: 800

  this

).apply {}
