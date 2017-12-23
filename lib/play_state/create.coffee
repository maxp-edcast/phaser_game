module.exports = ->

  # map = @game.add.tilemap("tilemap1", 16, 16, 700, 500)
  # map.addTilesetImage "tileset1"
  # tiles_layer = map.createLayer "Tiles"
  # tiles_layer.resizeWorld()

  @game.stage.backgroundColor = "#FFFFFF"

  @player = @add_p2_sprite 50, 50, 'player'
  @collide_world_bounds(@player)
  @player.body.fixedRotation = true
  @groups.player = @add_group()
  @groups.global.add @player

  @game.physics.p2.updateBoundsCollisionGroup();

  # colliders = @game.physics.p2.convertCollisionObjects map, "Collides"
  # colliders.forEach (collider) =>
  #   collider.setCollisionGroup objects_collision_group
  #   collider.collides @collision_groups.player
  # @player.body.collides objects_collision_group

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


