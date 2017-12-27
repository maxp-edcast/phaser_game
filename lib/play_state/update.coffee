module.exports = ->

  @update_player_movement()

  @update_active_event()

  # for trigger in @triggers
  #   if p2.Broadphase.aabbCheck(@player, trigger)
  #     console.log "zone"

# overlap,if you uses a Box,p2.Broadphase.aabbCheck(bodyA,bodyB)bodyA overlap bodyB.

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
