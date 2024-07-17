import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'view/home/provider/select_index_provider.dart';
import 'view/home/provider/news_list_provider.dart';
import 'view/home/provider/overlay_provider.dart';
import 'package:application_frontend/view/page_manager/page_manager_screen.dart';

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
          ChangeNotifierProvider(create: (_)=> IndexState()),
          ChangeNotifierProvider(create: (_)=>NewsState()),
          ChangeNotifierProvider(create: (_)=>OverlayProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Pretendard'),
          home: const PageManagerScreen(),
        ),
    );
  }
}
