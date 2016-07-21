$my_redis = Hash.new
$my_redis['created_count'] = 0
$my_redis['updated_count'] = 0
$my_redis['show_count'] = 0
$my_redis['destroy_count'] = 0

$redis = Redis.new
$redis.set('show_count', 0) if $redis.get('show_count').blank?

puts "========================== #{$redis.get('show_count')}"
