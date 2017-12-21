module.exports = ->

  speed = 200

  # This movement is EXCLUSIVE. Only one direction at a time.
  movement_vector = {
    walk_left: x: -speed
    walk_right: x: speed
    walk_up: y: -speed
    walk_down: y: speed
  }[@player_walking_direction] || {}
  @player.body.moveLeft -(movement_vector.x||0)
  @player.body.moveUp -(movement_vector.y||0)

  # Allows pressing multiple keys at once
  # TODO: fix
  # -----------------------------------------------------------------------------
  keys = ["W","A","S","D"]
  pressed_keys = (key for key in keys when @game_keys[key].isDown)
  if pressed_keys.length == 0
      @player_walking = false
      @player_walking_direction = null
      @player.animations.stop null, true

  if @equipped_rock

    # Set origin to player
    @equipped_rock.body.x = @player.world.x
    @equipped_rock.body.y = @player.world.y
    @equipped_rock.body.rotation = @player.worldRotation

    # Adjust position based on walk direction
    equipped_rock_offset = {
      walk_left: {x: 0, y: 100},
      walk_right: {x: 100, y: 100},
      walk_up: {x: 100, y: -50},
      walk_down: {x: 100, y: 100},
    }[@player_walking_direction] || {x: 0, y: 0}
    @equipped_rock.body.x += equipped_rock_offset.x
    @equipped_rock.body.y += equipped_rock_offset.y
    # @equipped_rock.anchor.setTo equipped_rock_anchor...


    # @equipped_rock.body.x = @player_position.world.x
    # @equipped_rock.body.y = @player_position.world.y
    # @equipped_rock.body.rotation = @player.worldRotation

