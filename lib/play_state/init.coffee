module.exports = ->

  # Load state, util, and assets
  Object.assign this,
    GameState,
    require("../util"),
    Assets: require("../assets")
  # Use phaser physics
  @physics.startSystem Phaser.Physics.P2JS
  @game.physics.p2.setImpactEvents(true);

  # Debug mode
  window.App = this
