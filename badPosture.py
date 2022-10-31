import sys
import base64
import io
from PIL import Image
 
decodedPayload = base64.b64decode(bytes(sys.argv[1], "utf-8"))
image = decodedPayload[:-3]
anglePayload = decodedPayload[-2:]

with open("bad-posture.jpg", "wb") as fh:
    fh.write(image)

with open("angle.txt", "w") as fh:
    fh.write(str(anglePayload.decode('utf-8')))
     
print("\n\Angle:", anglePayload)