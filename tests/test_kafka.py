from kafka_producer import send_message
from kafka_consumer import get_messages

def test_kafka_message_send_receive():
    topic = 'test_topic'
    message = 'Hello Kafka'
    
    # Send a message
    send_result = send_message(topic, message)
    assert send_result is not None, "Failed to send message"

    # Receive messages
    received_messages = get_messages(topic)
    
    # Assert that the sent message is in the received messages
    assert message in received_messages, "Message was not received"
