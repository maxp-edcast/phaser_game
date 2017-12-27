module.exports = ->

  # Load state, util, and assets
  Object.assign @game, GameState
  Object.assign @game, Assets: require("../assets")
  Object.assign @game, require("../util").load(@game)
  Object.assign @game, require("../game_helpers").load(@game)

  @game.use_p2_physics()

  # Helps with debugging
  if @game.debug_mode
    window.App = @game
