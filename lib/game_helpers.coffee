module.exports = load: (game) -> (->

  @add_player = =>
    @player = @add_p2_sprite 630, 320, 'player'
    @collide_world_bounds(@player)
    @player.body.fixedRotation = true
    @groups.player = @add_group()
    @player_collision_group = @create_collision_group()
    @set_sprite_collision_group @player, @player_collision_group
    @follow(@player)
    # @camera.roundPx = false
    # @player.fixedToCamera = true

  @add_static_objects = (map) =>
    @static_objects_collision_group = @create_collision_group()
    for i in [0..1]
      colliders = @physics.p2.convertCollisionObjects(
        map,
        "Collision#{i}"
      )
      for collider in colliders
        collider.setCollisionGroup @static_objects_collision_group
        collider.collides @player_collision_group
    @player.body.collides @static_objects_collision_group

  @add_trigger_objects = (map) =>
    @trigger_objects_collision_group = @create_collision_group()
    @active_events = {}
    [0..0].forEach (layer_idx) =>
      colliders = @physics.p2.convertCollisionObjects(
        map,
        "Event#{layer_idx}"
      )
      colliders.forEach (collider, collider_idx) =>
        collider.setCollisionGroup @trigger_objects_collision_group
        collider.collides @player_collision_group
        collider.data.shapes[0].sensor = true
        collider.onEndContact.add (a,b) =>
          event = map.objects["Event#{layer_idx}"][collider_idx].name
          @active_events[event].destroy()
          delete @active_events[event]
        collider.onBeginContact.add (a,b) =>
          event = map.objects["Event#{layer_idx}"][collider_idx].name
          text = @add.text(0, 0, event);
          @active_events[event] = text
    @player.body.collides @trigger_objects_collision_group

  @handle_trigger_entry = =>
    @game_keys.enter.onDown.add =>
      if Object.keys(@active_events).length == 1
        event = Object.keys(@active_events)[0]
        text = @active_events[event]
        text.setText("done")

  @get_player_walk_input = =>
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

  @update_player_movement = =>
    movement_vector = {
      walk_left: x: -@player_movement_speed
      walk_right: x: @player_movement_speed
      walk_up: y: -@player_movement_speed
      walk_down: y: @player_movement_speed
    }[@player_walking_direction] || {}
    @player.body.moveLeft -(movement_vector.x||0)
    @player.body.moveUp -(movement_vector.y||0)

    keys = ["W","A","S","D"]
    pressed_keys = (key for key in keys when @game_keys[key].isDown)
    if pressed_keys.length == 0
        @player_walking = false
        @player_walking_direction = null
        @player.animations.stop null, true


  @update_active_event = =>
    num_active_events = Object.keys(@active_events).length
    if num_active_events == 1
      event = Object.keys(@active_events)[0]
      text = @active_events[event]
      text.x = Math.floor(@player.x + @player.width / 2)
      text.y = Math.floor(@player.y + @player.height / 2)


  @finalize_p2 = =>
    @physics.p2.updateBoundsCollisionGroup();

  this

).apply game