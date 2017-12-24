module.exports = ->

  # @world.scale.setTo(2, 2)

  @cursors = @input.keyboard.createCursorKeys()

  @game_keys =
    W: @input.keyboard.addKey @keys.W
    A: @input.keyboard.addKey @keys.A
    S: @input.keyboard.addKey @keys.S
    D: @input.keyboard.addKey @keys.D

  map = @game.add.tilemap("government_facility", 8, 8, 160, 60)

  for key in Object.keys(@tileset_images)
    map.addTilesetImage key

  tiles_layers = [0..5].map (i) ->
    layer = map.createLayer "Layer#{i}"
    layer.resizeWorld()
    # layer.fixedToCamera = true

  @game.stage.backgroundColor = "#FFFFFF"

  @player = @add_p2_sprite 50, 50, 'player'
  @collide_world_bounds(@player)
  @player.body.fixedRotation = true
  @groups.player = @add_group()
  @player_collision_group = @create_collision_group()
  @set_sprite_collision_group @player, @player_collision_group

  @game.camera.follow @player
  # @game.camera.roundPx = false
  # @player.fixedToCamera = true

  @objects_collision_group = @create_collision_group()
  for i in [0..1]
    colliders = @game.physics.p2.convertCollisionObjects(
      map,
      "Collision#{i}"
    )
    colliders.forEach (collider) =>
      collider.setCollisionGroup @objects_collision_group
      collider.collides @player_collision_group
      @player.body.collides @objects_collision_group

  @game.physics.p2.updateBoundsCollisionGroup();

  _.each
    walk_down: [0..3]
    walk_left: [4..7]
    walk_right: [8..11]
    walk_up: [12..15]
  , (frames, key) =>
    @player.animations.add key, frames
  _.each
    W: 'walk_up',
    A: 'walk_left',
    S: 'walk_down',
    D: 'walk_right'
  , (anim, key) =>
    @game_keys[key].onDown.add =>
        @player.animations.play anim, @player_anim_speed, true
        @player_walking = true
        @player_walking_direction = anim


