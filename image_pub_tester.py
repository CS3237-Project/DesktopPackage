import base64
import os
import paho.mqtt.client as mqtt
import paho.mqtt.publish as publish

host_ip = '34.81.217.13'  # Broker IP

IMAGE_FOLDER_PATH = './'

def on_connect(client, userdata, flags, rc):
    pass

def on_message(client, userdata, message):
    pass

def setup(hostname):
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message
    client.connect(hostname, 1884, 60)
    imageFile = open('./test.jpg', 'rb')
    encodedPayload = base64.b64encode(imageFile.read())
    client.publish('image', encodedPayload)
    print('published image')
    client.loop_forever()
    return client

def main():
    setup(host_ip)

    while True:
        pass

if __name__ == '__main__':
    main()