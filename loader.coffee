# Note! Not using Object.assign on purpose ...
window.Pixi = require 'pixi.js'
window.p2 = require 'p2'
window.Phaser = require 'phaser'
window.GameWidth = 500
window.GameHeight = 600
window._ = require 'underscore'
window.DebugMode = true
window.Game = require('./lib/game_loader').start()
