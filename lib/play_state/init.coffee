module.exports = ->

  # Load state, util, and assets
  Object.assign this,
    require("../util"),
    Assets: require("../assets")

  Object.assign this, state: GameState

  # Use phaser physics
  @physics.startSystem Phaser.Physics.P2JS
  @game.physics.p2.setImpactEvents(true);

  # Debug mode
  window.debugMode = @state.debug_mode
  window.App = this
