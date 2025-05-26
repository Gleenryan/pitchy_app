import 'package:flutter/material.dart';

class MonitorPage extends StatelessWidget {
  final int soilHumidity;
  final int waterLevel;
  final int temperature;

  const MonitorPage({
    super.key,
    this.soilHumidity = 81,
    this.waterLevel = 81,
    this.temperature = 21,
  });

  // --- Arduino logic for status ---
  String getStatusText(int soilValue, int waterPercentage) {
    if ((soilValue >= 0) && waterPercentage <= 0) {
      return "BAD";
    } else if ((soilValue >= 0) && waterPercentage <= 10) {
      return "CAUTION";
    } else if ((soilValue > 650) && waterPercentage > 10) {
      return "CAUTION";
    } else if ((soilValue <= 650) && waterPercentage > 10) {
      return "GOOD";
    } else {
      return "UNKNOWN";
    }
  }

  Color getStatusColor(int soilValue, int waterPercentage) {
    if ((soilValue >= 0) && waterPercentage <= 0) {
      return Colors.red;
    } else if ((soilValue >= 0) && waterPercentage <= 10) {
      return Colors.yellow[700]!; // deep yellow
    } else if ((soilValue > 650) && waterPercentage > 10) {
      return Colors.yellow[700]!;
    } else if ((soilValue <= 650) && waterPercentage > 10) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- Get dynamic status and color based on live data ---
    final statusText = getStatusText(soilHumidity, waterLevel);
    final statusColor = getStatusColor(soilHumidity, waterLevel);

    return Scaffold(
      backgroundColor: const Color(0xFF171E22), // dark bg
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.bubble_chart_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                  Icon(Icons.settings, color: Colors.white, size: 32),
                ],
              ),
            ),
            // White area fills the rest
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF3F1EA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 18,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Back arrow
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Profile image
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/32.jpg",
                          ),
                        ),
                        SizedBox(height: 10),
                        // Field name and location
                        Text(
                          "Pitchy Field 1",
                          style: TextStyle(
                            color: Color(0xFF53B316),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Ngaliyan, Semarang",
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        SizedBox(height: 16),
                        // Plant Status
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            children: [
                              Text(
                                "Plant Status",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                statusText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 18),
                        // Sensor cards
                        SensorCard(
                          title: "Soil Humidity",
                          value: "$soilHumidity%",
                          icon: Icons.water_drop_outlined,
                        ),
                        SizedBox(height: 10),
                        SensorCard(
                          title: "Water Level",
                          value: "$waterLevel%",
                          icon: Icons.waves_outlined,
                        ),
                        SizedBox(height: 10),
                        SensorCard(
                          title: "Temperature",
                          value: "$temperature C",
                          icon: Icons.thermostat,
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SensorCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Label and value
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    color: Color(0xFF53B316),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Icon
            Icon(icon, size: 40, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
