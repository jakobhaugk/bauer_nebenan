import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'provider/text_provider.dart';
import 'provider/user_provider.dart';
import 'screens/launch/launch_screen.dart';
import 'route_generator_main.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => TextProvider()),
    ], child: App()),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Color(0xFF535353),
                fontFamily: 'Montserrat',
                fontSizeFactor: 1.1,
              ),
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(36)),
            contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.light(
            primary: Colors.green[800],
          ),
          primaryColor: Colors.green[800],
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Montserrat',
        ),
        home: LaunchScreen(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      );
}
