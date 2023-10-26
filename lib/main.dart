import 'package:ezytransact/constants.dart';
import 'package:ezytransact/firebase_options.dart';
import 'package:ezytransact/screens/splash_screen.dart';
import 'package:ezytransact/services/authentication_service.dart';
import 'package:ezytransact/services/transaction_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => TransactionService()),
      ],
      child: const EzyTransact(),
    ),
  );
}

class EzyTransact extends StatelessWidget {
  const EzyTransact({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EzyTransact',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: kLightSecondaryColor,
      ),
      home: const SplashScreen(),
    );
  }
}
