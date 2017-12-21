module.exports = ->

  # -----------------------------------------------------------------------------
  # TODO
  # http://www.html5gamedevs.com/topic/22905-p2-attach-2-physics-bodies-together/
  # -----------------------------------------------------------------------------

  # -----------------------------------------------------------------------------
  # background color
  @game.stage.backgroundColor = "#FFFFFF"
  # -----------------------------------------------------------------------------

  # -----------------------------------------------------------------------------
  # global group, for z-index sorting
  # -----------------------------------------------------------------------------
  @groups.global = @add_group()

  # -----------------------------------------------------------------------------
  # rock
  # -----------------------------------------------------------------------------
  @rock = @add_p2_sprite 200, 200, 'rock'
  # @rock.scale.set 0.1, 0.1
  @collide_world_bounds(@rock)
  @add_physics_file(@rock, 'rock_physics', 'rock')
  @make_static(@rock)
  @rock.anchor.setTo 0.7, 0.7
  @groups.rock = @add_group()
  @groups.rock.add @rock
  @groups.global.add @rock

  # -----------------------------------------------------------------------------
  # rock 2
  # -----------------------------------------------------------------------------
  @rock2 = @add_p2_sprite(300,300, 'rock')
  # @rock2 = @add.sprite(300,300, 'rock')
  @add_physics_file @rock2, 'rock_physics', 'rock'
  @rock2.anchor.setTo 0.7, 0.7
  # @collide_world_bounds(@rock)
  @make_static @rock
  @groups.global.add @rock2
  # @groups.rock2 = @add_group()
  # @groups.rock2.add @rock2

  # -----------------------------------------------------------------------------
  # player
  # -----------------------------------------------------------------------------
  @player = @add_p2_sprite 50, 50, 'player'
  @collide_world_bounds(@player)
  @player.body.fixedRotation = true
  @groups.player = @add_group()
  @groups.global.add @player

  # -----------------------------------------------------------------------------
  # player position
  # -----------------------------------------------------------------------------
  @player_position = @game.add.sprite 0,0, 'invisible'
  @player_position.visible = false
  @player.addChild @player_position

  # -----------------------------------------------------------------------------
  # collision groups
  # -----------------------------------------------------------------------------
  @collision_groups.rock = @create_collision_group()
  @collision_groups.rock2 = @create_collision_group()
  @collision_groups.player = @create_collision_group()

  # -----------------------------------------------------------------------------
  # Connects collision groups to world bounds
  # -----------------------------------------------------------------------------
  @game.physics.p2.updateBoundsCollisionGroup();

  # -----------------------------------------------------------------------------
  # apply collision groups
  # -----------------------------------------------------------------------------

  @set_sprite_collision_group(@player, @collision_groups.player)
  @set_sprite_collision_group(@rock, @collision_groups.rock)
  @set_sprite_collision_group(@rock2, @collision_groups.rock2)

  # -----------------------------------------------------------------------------
  # specific collision interactions
  # -----------------------------------------------------------------------------
  @player.body.collides @collision_groups.rock
  @rock.body.collides @collision_groups.player
  @player.body.collides @collision_groups.rock2
  @rock2.body.collides @collision_groups.player, (rock_body, player_body) =>
    # rock_body.sprite.destroy()
    if !@equipped_rock
      @equipped_rock = rock_body.sprite
      # @equipped_rock ||= @add_p2_sprite(@player.position.x, @player.position.y, 'rock')
      @add_physics_file(@equipped_rock, 'rock_physics', 'rock')
      # @equipped_rock ||= rock_body.sprite
      @equipped_rock.anchor.setTo 0.7, 0.7
      @set_sprite_collision_group @equipped_rock, @collision_groups.rock
      @equipped_rock.body.collides @collision_groups.rock
      @rock.body.collides @collision_groups.rock
      # @make_static @equipped_rock
      # rock_body.sprite.position = player_body.sprite.position
      # player_body.sprite.addChild rock_body.sprite
      # @groups.player.add rock_body.sprite

  # -----------------------------------------------------------------------------
  # materials
  # -----------------------------------------------------------------------------
  @materials.world = @add_world_material 'world_material'
  @materials.player = @add_sprite_material @player, 'player_material'
  @materials.rock = @add_sprite_material @rock, 'rock_material'
  @contact_materials.world_and_player = @add_contact_material(
    @materials.world,
    @materials.player,
    restitution: 0.1
  )
  @contact_materials.world_and_rock = @add_contact_material(
    @materials.world,
    @materials.rock,
    restitution: 0.1
  )
  @contact_materials.player_and_rock = @add_contact_material(
    @materials.player,
    @materials.rock,
    restitution: 0.1
  )

  # -----------------------------------------------------------------------------
  # rock animations
  # -----------------------------------------------------------------------------
  _.each
    roll: [0..1]
  , (frames, key) =>
    @rock.animations.add key, frames
  @rock.animations.play 'roll', @rock_anim_speed, true

  # -----------------------------------------------------------------------------
  # player animations and walk control
  # -----------------------------------------------------------------------------
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


