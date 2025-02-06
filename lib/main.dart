import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeviceInfoScreen(),
    );
  }
}

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  String deviceModel = 'Loading...';
  String osVersion = 'Loading...';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Theme.of(context).platform == TargetPlatform.android) {
      // For Android
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceModel = androidInfo.model;
        osVersion = 'Android ${androidInfo.version.release}';
      });
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      // For iOS
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        deviceModel = iosInfo.utsname.machine;
        osVersion = 'iOS ${iosInfo.systemVersion}';
      });
    } else {
      // For other platforms (e.g., web, desktop)
      setState(() {
        deviceModel = 'Unsupported platform';
        osVersion = 'Unsupported platform';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Device Model:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              deviceModel,
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'OS Version:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              osVersion,
              style: TextStyle(fontSize: 22, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}