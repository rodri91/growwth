import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

const _brandMainColor = Color.fromRGBO(103, 80, 164, 1);

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      if (lightDynamic != null && darkDynamic != null) {
        // On Android S+ devices, use the provided dynamic color scheme.
        // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
        lightColorScheme = lightDynamic.harmonized();
        // (Optional) Customize the scheme as desired. For example, one might
        // want to use a brand color to override the dynamic [ColorScheme.secondary].
        // lightColorScheme = lightColorScheme.copyWith(secondary: _brandBlue);
        // (Optional) If applicable, harmonize custom colors.
        // lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

        // Repeat for the dark color scheme.
        darkColorScheme = darkDynamic.harmonized();
        //darkColorScheme = darkColorScheme.copyWith(secondary: _brandBlue);
        //darkCustomColors = darkCustomColors.harmonized(darkColorScheme);

      } else {
        // Otherwise, use fallback schemes.
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: _brandMainColor,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: _brandMainColor,
          brightness: Brightness.dark,
        );
      }

      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        home: HomeScreen(),
      );
    });
  }
}
