PlayState = require './play_state'

module.exports = this

@start = ->
  game = new Phaser.Game(
    GameState.width,
    GameState.height,
    Phaser.WEBGL,
    'game',
    null,
    false,
    true
  )
  game.state.add 'PlayState', PlayState
  game.state.start 'PlayState'
  game

