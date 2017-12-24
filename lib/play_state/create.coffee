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

  @player = @add_p2_sprite 630, 320, 'player'
  @collide_world_bounds(@player)
  @player.body.fixedRotation = true
  @groups.player = @add_group()
  @player_collision_group = @create_collision_group()
  @set_sprite_collision_group @player, @player_collision_group

  @game.camera.follow @player
  # @game.camera.roundPx = false
  # @player.fixedToCamera = true

  @game.physics.p2.updateBoundsCollisionGroup();

  @static_objects_collision_group = @create_collision_group()
  for i in [0..1]
    colliders = @game.physics.p2.convertCollisionObjects(
      map,
      "Collision#{i}"
    )
    for collider in colliders
      collider.setCollisionGroup @static_objects_collision_group
      collider.collides @player_collision_group
  @player.body.collides @static_objects_collision_group

  @trigger_objects_collision_group = @create_collision_group()

  [0..0].forEach (layer_idx) =>
    colliders = @game.physics.p2.convertCollisionObjects(
      map,
      "Event#{layer_idx}"
    )
    colliders.forEach (collider, collider_idx) =>
      collider.setCollisionGroup @trigger_objects_collision_group
      collider.collides @player_collision_group
      collider.data.shapes[0].sensor = true
      collider.onBeginContact.add (a,b) ->
        console.log map.objects["Event#{layer_idx}"][collider_idx].name

  @player.body.collides @trigger_objects_collision_group #, =>
  #   console.log "zone"
  #   false


    # for collider in colliders
      # console.log collider
      # collider.data.sensor = true
      # @player.body.collides @trigger_objects_collision_group
      # collider.createBodyCallback @player, ->
        # console.log("in zone")



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


