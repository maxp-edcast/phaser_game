module.exports = load: (game) -> (->

  @follow = (sprite) =>
    @camera.follow sprite

  @set_background_color = =>
    @stage.backgroundColor = "#FFFFFF"

  @add_tileset_images = (map) =>
    for key in Object.keys(@tileset_images)
      map.addTilesetImage key

  @add_layers = (map, key, range) =>
    range.map (i) ->
      layer = map.createLayer "#{key}#{i}"
      layer.resizeWorld()
      layer
    # layer.fixedToCamera = true


  @setup_game_keys = (keys...) =>
    # @cursors = @input.keyboard.createCursorKeys()
    @game_keys = keys.reduce (memo, key) =>
      memo[key] = @input.keyboard.addKey @keys[key]
      memo
    , {}

  @add_tilemap = (key, tile_size, width, height) =>
    @add.tilemap(key, tile_size, width, height)

  @use_p2_physics = =>
    @physics.startSystem Phaser.Physics.P2JS
    @physics.p2.setImpactEvents(true);

  @load_spritesheet = (key, tile_size, num_tiles) =>
    @load.spritesheet(key, @Assets[key], tile_size, tile_size, num_tiles)

  @load_tilemap = (key) =>
    @load.tilemap key, @Assets[key], null, Phaser.Tilemap.TILED_JSON

  @load_tileset_images = =>
    @tileset_images = require("../assets.json")
    for key,path of @tileset_images
      @load.image(key, path)

  @random_int = (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  @random_from_list = (list) ->
    list[Math.floor((Math.random() * list.length))]

  @collide_world_bounds = (sprite) ->
    sprite.body.collideWorldBounds = true

  @add_physics_file = (sprite, physics_file, physics_file_key) ->
    sprite.body.clearShapes()
    sprite.body.loadPolygon physics_file, physics_file_key

  @set_game_size_and_background = (width, height, background_key) ->
    @set_game_size(width, height)
    background = @add_p2_sprite @midpoint_x, @midpoint_y, background_key
    @make_static(background)
    @turn_off_gravity(background)
    background

  @set_game_size = (width, height) ->
    @world.setBounds 0, 0, width, height

  @add_p2_sprite = (x, y, key) ->
    sprite = @add.sprite x, y, key
    @physics.p2.enable sprite, @debug_mode
    sprite

  @make_static = (sprite) ->
    sprite.body.static = true

  @turn_off_gravity = (sprite) ->
    sprite.body.data.gravityScale = 0

  @create_collision_group = ->
    collision_group = @physics.p2.createCollisionGroup()
    @physics.p2.updateBoundsCollisionGroup()
    collision_group

  @set_sprite_collision_group = (sprite, collision_group) ->
    sprite.body.setCollisionGroup(collision_group)

  @add_group = ->
    group = @add.group();
    group.enableBody = true;
    group.physicsBodyType = Phaser.Physics.P2JS;
    group

  @add_sprite_material = (sprites..., key) ->
    material = @physics.p2.createMaterial key
    sprites.forEach (sprite) =>
      sprite.body.setMaterial material
    material

  @add_world_material = (key) =>
    material = @add_sprite_material key
    @physics.p2.setWorldMaterial material, true, true, true, true
    material

  @add_contact_material = (material1, material2, opts) =>
    contact_material = @physics.p2.createContactMaterial material1, material2
    Object.assign contact_material, opts
    contact_material.friction           ||= 0
    contact_material.restitution        ||= 1.0
    contact_material.stuffness          ||= 1e7
    contact_material.relaxation         ||= 3
    contact_material.frictionStiffness  ||= 1e7
    contact_material.frictionRelaxation ||= 3
    contact_material.surfaceVelocity    ||= 0
    contact_material

  this
).apply game