# 🌱 Pitchy App
Pitchy is a real-time smart farming companion, empowering you to monitor your plants’ health anywhere, anytime.
With IoT sensors (Arduino + ESP32), Firebase, and a sleek Flutter mobile app, Pitchy helps you ensure your plants always get the water, humidity, and temperature they need.

# 🚀 Features
Live Monitoring: Instantly view soil humidity, water level, and temperature from your phone.
Detail Pages: Dive deep into each sensor with intuitive charts and plant care tips.
Real-time Alerts: Visual indicators for plant status: Good, Caution, or Bad (color-coded).
Seamless Integration: ESP32/Arduino hardware pushes sensor data to Firebase; Flutter app fetches and updates in real-time.

# 🛠️ Tech Stack
Hardware: Arduino Nano ESP32, DHT11, soil moisture & water level sensors
Backend: Google Firebase Realtime Database
Mobile App: Flutter 



# 💡 How It Works
Arduino/ESP32 collects data from plant sensors.
Sends data to Firebase every second (customizable).
Flutter app retrieves and displays live sensor data on your phone.

# 📲 Getting Started
Flash the Arduino code (see /arduino folder).
Set up Firebase and add your credentials.
Run the Flutter app (flutter run) and connect your device.

