#!/bin/bash

# Deletes all queues from RabbitMQ that start with a specified prefix

PREFIX=${1:-ORG}

echo "This will delete all RabbitMQ queues beginning with '$PREFIX'"
read -p "Continue? (y/n) " CONTINUE
if [ "$CONTINUE" != "y" ]
then
	echo "Aborted"
	exit 1
fi

for Q in $(rabbitmqadmin list queues name | awk '{print $2}' | grep "^$PREFIX")
do
	(echo "Deleting queue $Q..." && rabbitmqadmin delete queue name="$Q") &
done
wait

for Q in $(rabbitmqadmin list exchanges name | awk '{print $2}' | grep "^$PREFIX")
do
	(echo "Deleting exchange $Q..." && rabbitmqadmin delete exchange name="$Q") &
done
wait
