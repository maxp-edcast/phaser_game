module.exports = ->

  # @world.scale.setTo(2, 2)

  @setup_game_keys("W", "A", "S", "D", "enter")

  @map = @add_tilemap "government_facility", 8, 160, 60

  @add_tileset_images(@map)

  @add_layers(@map, "Layer", [0..5])

  @set_background_color "#FFFFFF"

  @add_player()

  @add_static_objects(@map)

  @add_trigger_objects(@map)

  @handle_trigger_entry()

  @get_player_walk_input()

  @finalize_p2()


