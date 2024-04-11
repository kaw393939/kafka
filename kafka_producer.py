from kafka import KafkaProducer

def send_message(topic, message):
    producer = KafkaProducer(bootstrap_servers=['kafka:9092'])
    future = producer.send(topic, message.encode('utf-8'))
    result = future.get(timeout=60)
    return result
