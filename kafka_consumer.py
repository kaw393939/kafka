from kafka import KafkaConsumer

def get_messages(topic):
    consumer = KafkaConsumer(topic,
                             bootstrap_servers=['kafka:9092'],
                             auto_offset_reset='earliest',
                             consumer_timeout_ms=1000)
    messages = []
    for message in consumer:
        messages.append(message.value.decode('utf-8'))
    return messages
