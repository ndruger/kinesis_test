require 'dotenv'
require 'aws-sdk'

Dotenv.load

ACCESS_KEY_ID     = ENV["ACCESS_KEY_ID"]
SECRET_ACCESS_KEY = ENV["SECRET_ACCESS_KEY"]
REGION            = ENV["REGION"]
STREAM            = ENV["STREAM"]

client = Aws::Kinesis::Client.new(
  access_key_id: ACCESS_KEY_ID,
  secret_access_key: SECRET_ACCESS_KEY,
  region: REGION
)

loop do
  t = Time.now
  data = "#{(t.to_f * 1000).to_i}"
  response = client.put_record(
    stream_name: STREAM,
    data: data,
    partition_key: t.to_s,
  )
  puts "Sequence Number: #{response.sequence_number}, Data: #{data}, Shard Id: #{response.shard_id}"
  sleep 1
end
