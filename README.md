kinesis delay test

## Result

### db540ff30a62a6b2622d17206cbe99193fa1ba92

- Region: ap-northeast-1
- Client Position: ISP user's pc in Japan

1: `Count: 100, Sequence Number: 49560447105722311515677824504594678250475697703986659330, Data: 1459007095970, Delay: 494, Average: 177, Max: 1011, Shard Id: shardId-000000000000`

2: `Count: 100, Sequence Number: 49560447105722311515677824504913834666853962417449205762, Data: 1459007134356, Delay: 110, Average: 153, Max: 965, Shard Id: shardId-000000000000`

3: `Count: 100, Sequence Number: 49560447105722311515677824505402240697978276864638058498, Data: 1459007195726, Delay: 209, Average: 182, Max: 707, Shard Id: shardId-000000000000`

## Reference

[Low-Latency Processing - Amazon Kinesis Streams](http://docs.aws.amazon.com/kinesis/latest/dev/kinesis-low-latency.html)

```
> Streams has a limit of 5 GetRecords calls per second, per shard`
```
