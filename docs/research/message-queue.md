---
title: Message Queues
description: Message Queues Research
---

# Message Queues

We compared rabbitmq, kafka and NATs as potential message queue solutions for our project.

Since we operator at a small scale at the moment and the we needed a pub sub model with persistent messages we decided to go with NATs as our message queue solution.
NATs is lightweight, easy to set up and has a simple API. It also supports clustering and has good performance.
With JetStream it also supports message persistence to make sure no messages are lost in case of a failure.

RabbitMQ and Kafka are both solid choices for message queues as well, but they tend to be very resource heavy, even when idel.
