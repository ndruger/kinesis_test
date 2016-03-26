require 'dotenv'
require 'aws-sdk'
require 'parallel'

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

shards     = client.describe_stream(stream_name: STREAM).stream_description.shards
shard_ids  = shards.map(&:shard_id)


Parallel.each(shard_ids, in_threads: shard_ids.count) do |shard_id|
  shard_iterator_info = client.get_shard_iterator(
                          stream_name: STREAM,
                          shard_id: shard_id,
                          shard_iterator_type: 'LATEST'
                        )
  shard_iterator = shard_iterator_info.shard_iterator

  current_iterator = shard_iterator
  loop do
    records_info = client.get_records(
                     shard_iterator: current_iterator
                   )
    current_iterator = records_info.next_shard_iterator # next

    records_info.records.each do |record|
      from = record.data.to_i
      delay = (Time.now.to_f * 1000).to_i - from
      puts "Sequence Number: #{record.sequence_number}, Data: #{record.data}, Delay: #{delay}, Shard Id: #{shard_id}"
    end
    sleep 0.1
  end
end
