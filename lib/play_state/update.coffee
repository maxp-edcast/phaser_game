module.exports = ->

  console.log @player_movement_speed
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

    # @equipped_rock.body.x = @player.world.x
    # @equipped_rock.body.y = @player.world.y
    # @equipped_rock.body.rotation = @player.worldRotation

    # equipped_rock_offset = {
    #   walk_left: {x: 0, y: 100},
    #   walk_right: {x: 100, y: 100},
    #   walk_up: {x: 100, y: -50},
    #   walk_down: {x: 100, y: 100},
    # }[@player_walking_direction] || {x: 0, y: 0}
    # @equipped_rock.body.x += equipped_rock_offset.x
    # @equipped_rock.body.y += equipped_rock_offset.y
