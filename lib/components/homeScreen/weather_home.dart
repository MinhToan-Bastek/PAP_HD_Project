import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 380.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFFE0F2EF),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/homeScreen/icon_weather.svg',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quận 10',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    'Hồ Chí Minh, Việt Nam',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Text(
                '31°',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48.0,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetail(
                icon: Icons.thermostat_outlined,
                label: 'Sensible',
                value: '27°C',
                iconColor: Colors.red,
              ),
              WeatherDetail(
                icon: Icons.opacity,
                label: 'Precipitation',
                value: '3%',
                iconColor: Colors.blue,
              ),
              WeatherDetail(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '67%',
                iconColor: Colors.blue,
              ),
              WeatherDetail(
                icon: Icons.air,
                label: 'Wind',
                value: '16 km/h',
                iconColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isMain;
  final Color iconColor;

  const WeatherDetail({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.isMain = false,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMain
        ? Expanded(
            child: Column(
              children: [
                Icon(
                  IconData(icon.codePoint,
                      fontFamily: icon.fontFamily,
                      fontPackage: icon.fontPackage,
                      matchTextDirection: true),
                  size: 48.0,
                  color: iconColor,
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48.0,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Icon(
                IconData(icon.codePoint,
                    fontFamily: icon.fontFamily,
                    fontPackage: icon.fontPackage,
                    matchTextDirection: true),
                color: iconColor,
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ],
          );
  }
}
