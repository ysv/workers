# Kafka Producer Example

```ruby
require 'kafka'
require 'active_support/all'

kafka = Kafka.new(['0.0.0.0:9092'])
message_id = 0

loop do
  text = {
    hello: :world,
    number: message_id
  }
  kafka.deliver_message(
    text.to_json,
    topic: "example-topic-#{[1,2].sample}",
    key:   "example-key-#{[1,2].sample}"
  )
  puts text
  message_id += 1
  sleep 5
end
```