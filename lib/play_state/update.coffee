module.exports = -> (->

  @update_player_movement()

  @update_active_event()
  # debugger
  @mask_graphics.clear()

  if @player

    mouseAngle = Math.atan2(
      (@player.world.y - @input.worldY),
      (@player.world.x - @input.worldX)
    )
    @mask_graphics.lineStyle(2, 0xffffff, 1)
    @mask_graphics.beginFill(0xffff00)
    @mask_graphics.moveTo(@player.world.x, @player.world.y)
    for i in [0..@numberOfRays]
      @ray_angle = mouseAngle - (@lightAngle/2) +
                   (@lightAngle/@numberOfRays) * i
      { x, y } = @player.world
      for j in [1...@rayLength+1]
        landing_x = Math.round(@player.world.x-(2*j)*Math.cos(@ray_angle))
        landing_y = Math.round(@player.world.y-(2*j)*Math.sin(@ray_angle))
        if @light_map.getPixel32(landing_x,landing_y) == 0
          x = landing_x
          y = landing_y
        else
          @mask_graphics.lineTo(x,y)
          break
      @mask_graphics.lineTo(x,y)
      @mask_graphics.endFill()

).apply @game
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
