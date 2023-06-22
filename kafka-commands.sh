# ==============
# Kafka Commands
# ==============



# 1. Starting Kafka
# -----------------
# Start Zookeeper in background (daemon mode)
zookeeper-server-start.sh -daemon ~/kafka_2.13-3.5.0/config/zookeeper.properties

# Start Kafka in background (daemon mode)
kafka-server-start.sh -daemon ~/kafka_2.13-3.5.0/config/server.properties

# Stop Kafka
kafka-server-stop.sh



# 2. Topics
# ---------
# Create a new topic called 'topic-name' with 1 replication factor and 3 partitions
kafka-topics.sh --create --bootstrap-server localhost:9092 --topic topic-name --replication-factor 1 --partitions 3

# Check details of a topic called 'topic-name'
kafka-topics.sh --bootstrap-server localhost:9092 --topic topic-name --describe

# List the topics
kafka-topics.sh --bootstrap-server localhost:9092 --list

# Delete a topic (only works if delete.topic.enable=true)
kafka-topics.sh --bootstrap-server localhost:9092 --topic topic-name --delete

# Show the consumer offsets logs
kafka-topics.sh --bootstrap-server localhost:9092 --topic __consumer_offsets --describe


# 3. Producers
# ------------
# Create a console producer with properties
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic first_topic --producer-property acks=all

# Create a console producer with keys to write and send messages in key-value format
kafka-console-producer.sh --bootstrap-server localhost:9092 --topic topic-name --property parse.key=true --property key.separator=:



# 4. Consumers
# ------------
# Create a console consumer that reads messages from the beginning of a specified topic
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-name --from-beginning

# Create a console consumer with keys that reads messages from a specified topic in key-value format
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-name --property print.key=true --property key.separator=:

# Create a consumer in a group, with each command it will add another consumer to the same group and messages will be spread across the group
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-name --group group-name



# 5. Consumer Groups
# ------------------
# List the Consumer Groups
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --list
 
# Check the details of a specific consumer group
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group group-name --describe



# 6. Offsets
# ----------
# Dry Run: reset the offsets to the beginning of each partition
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group group-name --reset-offsets --to-earliest --topic topic-name --dry-run

# Execute flag is needed to reset the offsets
kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group group-name --reset-offsets --to-earliest --topic topic-name --execute

# Consume from where the offsets have been reset
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-name --group group-name



# 7. Advanced Topic Configurations
# --------------------------------
# Add a configuration of 'min.insync.replicas=2' to the specified topic, overriding any default values
kafka-configs.sh --bootstrap-server localhost:9092 --entity-type topics --entity-name topic-name --alter --add-config min.insync.replicas=2

# Check the configurations of the specified topic
kafka-configs.sh --bootstrap-server localhost:9092 --entity-type topics --entity-name topic-name --describe

# Delete a configuration
kafka-configs.sh --bootstrap-server localhost:9092 --entity-type topics --entity-name topic-name --alter --delete-config min.insync.replicas

# Create log-compacted topic using configurations: cleanup.policy, min.cleanable.dirty.ratio and segment.ms
kafka-topics.sh --bootstrap-server localhost:9092 --create --topic topic-name --partitions 1 --replication-factor 1 --config cleanup.policy=compact --config min.cleanable.dirty.ratio=0.001 --config segment.ms=5000
