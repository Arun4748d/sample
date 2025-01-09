import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/controller/Chatcontroller.dart';
import 'package:sample/controller/logincontroller.dart';
import 'package:sample/controller/registrationcontroller.dart';
import 'package:sample/firebase_options.dart';


import 'package:sample/view/splashscreen/splshscreen.dart';

Future<void> main()  async {
  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Registrationcontroller()),
    ChangeNotifierProvider(create: (context) => Logincontroller()),
    ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Splshscreen(),
      ),
    );
  }
}
