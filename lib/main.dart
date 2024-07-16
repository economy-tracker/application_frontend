import 'view/home/provider/select_index_provider.dart';
import 'package:application_frontend/view/page_manager/page_manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> IndexState())
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: PageManagerScreen(),
        ),
    );
  }
}
