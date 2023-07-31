import 'package:downlorder/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


final locator = GetIt.asNewInstance();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await regiterServices();
  runApp(
   const  MaterialApp(

      home: Homepage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> regiterServices() async {
  locator..registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance)
  ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform);
  // locator.registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance);
  // locator.registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform);
}
