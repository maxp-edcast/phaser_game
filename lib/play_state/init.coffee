module.exports = ->

  # Load state, util, and assets
  Object.assign @game, GameState
  Object.assign @game, Assets: require("../assets")
  Object.assign this, require("../util").load(@game)
  Object.assign this, require("../game_helpers").load(@game)

  @use_p2_physics()

  # Helps with debugging
  if @debug_mode
    window.App = @game
