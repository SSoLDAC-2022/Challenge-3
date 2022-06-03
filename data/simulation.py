from http.server import BaseHTTPRequestHandler, HTTPServer
import time
import json
import random
from shapely.geometry import Polygon, Point

hostName = "localhost"
serverPort = 8080

class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        p = Polygon([(0, 0), (66.4, 0), (66.4, 11.2), (17.1, 11.2), (17.1, 16.6), (24, 16.6), (24, 22.9), (17.1,22.9), (17.1,43), (37.2,43), (37.2,54), (0,54)])
        point_in_poly1 = self.get_random_point_in_polygon(p)
        point_in_poly2 = self.get_random_point_in_polygon(p)
        self.dictionary = [
                {
                    "tagId": "e9b870d9-5058-4d4a-802b-3457279524e0",
                    "tagGroup": "9d8b5d6e-691a-482a-ab8e-85a7e094dab0",
                    "assignedProjectId": "2b547f71-6e1c-4048-a61c-eb59c7e79976",
                    "location": [
                    round(point_in_poly1.x,1),
                    round(point_in_poly1.y,1)
                    ],
                    "locationRadius": 0.45,
                    "inferredAccuracy": 2,
                    "currentZone": "22O7WvOu1F3RpVxpkqDC6M",
                    "inferredMovement": 1,
                    "inferredSpeed": 0.1,
                    "batteryStatus": 1,
                    "lastSeen": int(time.time())
                },
                {
                    "tagId": "0176711d-00a6-5dab-be9c-a807e6dace25",
                    "tagGroup": "9d8b5d6e-691a-482a-ab8e-85a7e094dab0",
                    "assignedProjectId": "2b547f71-6e1c-4048-a61c-eb59c7e79976",
                    "location": [
                    round(point_in_poly2.x,1),
                    round(point_in_poly2.y,1)
                    ],
                    "locationRadius": 0.45,
                    "inferredAccuracy": 2,
                    "currentZone": "22O7WvOu1F3RpVxpkqDC6M",
                    "inferredMovement": 1,
                    "inferredSpeed": 0.1,
                    "batteryStatus": 1,
                    "lastSeen": int(time.time())
                }
            ]
        
        self.wfile.write(bytes(json.dumps(self.dictionary, indent=4), "utf-8"))

    def get_random_point_in_polygon(self, poly):
        minx, miny, maxx, maxy = poly.bounds
        while True:
            p = Point(random.uniform(minx, maxx), random.uniform(miny, maxy))
            if poly.contains(p):
                return p




if __name__ == "__main__":        
    webServer = HTTPServer((hostName, serverPort), MyServer)
    print("Server started http://%s:%s" % (hostName, serverPort))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")