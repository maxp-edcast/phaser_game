
# ENTRY POINT
# Loaded from webpack.config.js
# and webpack.production.config.js

# Note! Not using Object.assign on purpose ...
# Some of these libraries have global dependencies,
# and so they need to be required and assigned to window
# in a specific order

window.Pixi = require 'pixi.js'
window.p2 = require 'p2'
window.Phaser = require 'phaser'
window._ = require 'underscore'
window.$ = require 'jquery'

# Contains all the game logic

window.Game = require('./lib/game_loader')

# POJO game state
window.GameState = require "./lib/state"

# FUNCTION TO START GAME
# is called by index.html

window.START_GAME = Game.start