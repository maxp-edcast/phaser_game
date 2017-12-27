module.exports = -> (->
  @load_spritesheet('player', 16, 16)
  @load_image 'government_facility_light_map'
  @load_tilemap 'government_facility'
  @load_tileset_images()

).apply @game