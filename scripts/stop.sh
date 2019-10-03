#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

LOG_FILEPATH=$PWD/logs/stop.log

source ./scripts/utils.sh

# Read from shell configuration file
source ./.env.sh

title "Stopping any existing jobs..."
python ./scripts/stop_all_jobs.py

# Prompt if should stop DB
if prompt "Should stop SingaAuto's DB?"
then
    bash scripts/stop_db.sh || exit 1
else
    echo "Not stopping SingaAuto's DB!"
fi

title "Stopping SingaAuto's Zookeeper..."
docker rm -f $ZOOKEEPER_HOST || echo "Failed to stop SingaAuto's Zookeeper"

title "Stopping SingaAuto's Kafka..."
docker rm -f $KAFKA_HOST || echo "Failed to stop SingaAuto's Kafka"

title "Stopping SingaAuto's Redis..."
docker rm -f $REDIS_HOST || echo "Failed to stop SingaAuto's Redis"

title "Stopping SingaAuto's Admin..."
docker rm -f $ADMIN_HOST || echo "Failed to stop SingaAuto's Admin"

title "Stopping SingaAuto's Web Admin..."
docker rm -f $WEB_ADMIN_HOST || echo "Failed to stop SingaAuto's Web Admin"

echo "You'll need to destroy your machine's Docker swarm manually"

