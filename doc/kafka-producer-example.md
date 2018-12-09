# Kafka Producer Examples

### Lot created producer
```ruby
require 'kafka'
require 'active_support/all'

kafka = Kafka.new([ENV.fetch('KAFKA_URL','0.0.0.0:9092')])
message_id = 0
topic = 'lot_creator-topic'
lot_id = 16

loop do
  text = {
    hello: :world,
    number: message_id,
    lot_id: lot_id
  }
  kafka.deliver_message(
    text.to_json,
    topic: topic,
  )
  puts text
  message_id += 1
  sleep 5
end
```

### Bid created producer
```ruby
require 'kafka'
require 'active_support/all'

kafka = Kafka.new([ENV.fetch('KAFKA_URL','0.0.0.0:9092')])
message_id = 0
topic = 'bid_creator-topic'
bid_id = 16

loop do
  text = {
    hello: :world,
    number: message_id,
    bid_id: bid_id
  }
  kafka.deliver_message(
    text.to_json,
    topic: topic,
  )
  puts text
  message_id += 1
  sleep 5
end
```
