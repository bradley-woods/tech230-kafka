#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java
# ------------
# Import the Corretto public key and then add the repository to the system list
wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add - 
sudo add-apt-repository 'deb https://apt.corretto.aws stable main'

# Install Java OpenJDK 11 Amazon Corretto 11
sudo apt-get update; sudo apt-get install -y java-11-amazon-corretto-jdk

# Check Java version
java -version

# If you do not see Corretto, change default Java or Javac provider
sudo update-alternatives --config java
sudo update-alternatives --config javac

# Install Apache Kafka
# --------------------
# Download Scala 2.13 - Kafka 3.5.0 binary file
wget https://downloads.apache.org/kafka/3.5.0/kafka_2.13-3.5.0.tgz

# Extract the downloaded file
tar -xzf kafka_2.13-3.5.0.tgz

# Add Kafka binaries to PATH to make them easily accessible
echo -e "PATH="$PATH:~/kafka_2.13-3.5.0/bin"" | sudo tee -a .bashrc
source .bashrc
export PATH="$PATH:~/kafka_2.13-3.5.0/bin"

# Start Zookeeper in background (daemon mode)
zookeeper-server-start.sh -daemon ~/kafka_2.13-3.5.0/config/zookeeper.properties

# Start Apache Kafka in background (daemon mode)
kafka-server-start.sh -daemon ~/kafka_2.13-3.5.0/config/server.properties

# Alternatively, start Apache Kafka without Zookeeper (KRaft mode)
# kafka-storage.sh random-uuid
# kafka-storage.sh format -t <uuid> -c ~/kafka_2.13-3.5.0/config/kraft/server.properties
# kafka-server-start.sh -daemon ~/kafka_2.13-3.5.0/config/kraft/server.properties