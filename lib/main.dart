import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_goals/screens/homescreen.dart';
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =AndroidInitializationSettings('water');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  onSelectNotification: (String ?payload)async{
        if(payload != null){
          debugPrint('notification payload: ' + payload);
        }
  });
  
  runApp(MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: PrimaryScreen(),
  ));
}

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({ Key? key }) : super(key: key);

  @override
  _PrimaryScreenState createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  int _quantity = 0;
    int _hrs = 0;
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _quantity = (prefs.getInt('quantity') ?? 0);
    _hrs = (prefs.getInt('hours') ?? 0);
    print(_hrs.toString()+ " " + _quantity.toString());
    
  }
  void initState(){
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(child: Text("Tap to Continue"), onPressed: (){
        startNotification();
        Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen(_quantity,_hrs)),
  );
      },),
      
    );
  }
  Future<void> startNotification() async {

      var scheduleNotificationDateTime = 
          DateTime.now().add(Duration(seconds: 10));
          var time = tz.TZDateTime.from(
    scheduleNotificationDateTime,
    tz.local,
);

          var androidPlatformChannelSpecifs = AndroidNotificationDetails(
            'alarm_notif',
            'alarm_notif',
            'Channel for alarm notification',
            icon: 'water',
         //   sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
            largeIcon: DrawableResourceAndroidBitmap('water'),
          );

          var platformChannelSpecifics =  NotificationDetails(
            android: androidPlatformChannelSpecifs
          );

          await flutterLocalNotificationsPlugin.zonedSchedule(0,'Blue Time', 'Time to drink water', time, platformChannelSpecifics, androidAllowWhileIdle: true,
          //payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,);
     
  }
}