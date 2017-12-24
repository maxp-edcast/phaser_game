# build asset paths
ruby -e """
  require 'json'
  paths = %w{png jpg}.flat_map do |ext|
    Dir.glob(\"./assets/tileset_images/*.#{ext}\").to_a
  end.reduce({}) do |memo, path|
    memo.tap { memo[File.basename(path, File.extname(path))] = path }
  end
  File.open('./assets.json', 'w') do |file|
    file.write paths.to_json
  end
"""