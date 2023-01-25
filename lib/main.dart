import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project_session_2/view/screen/home_screen.dart';
import 'package:test_project_session_2/view/screen/login_screen.dart';
import 'package:test_project_session_2/view/screen/view_order_screen.dart';
import 'package:test_project_session_2/viewmodel/delivery_model.dart';
import 'package:test_project_session_2/viewmodel/login_model.dart';
import 'package:test_project_session_2/viewmodel/order_model.dart';
import 'style.dart' as style;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginModel()),
        ChangeNotifierProvider(create: (_) => DeliveryModel()),
        ChangeNotifierProvider(create: (_) => OrderModel()),
      ],
      child: MaterialApp(
        theme: style.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MyApp(),
          '/login': (context) => LoginScreen(),
          '/view/order': (context) => ViewOrderScreen(),
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginModel = Provider.of<LoginModel>(context);
    return !loginModel.loginCheck ? LoginScreen() : HomeScreen();
  }
}
