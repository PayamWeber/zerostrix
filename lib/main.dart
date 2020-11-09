
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zerostrix/Views/Auth/login.dart';
import 'package:zerostrix/Views/Auth/register.dart';
import 'package:zerostrix/Views/Home/index.dart';
import 'package:zerostrix/Views/Home/loading.dart';
import 'package:zerostrix/Views/Home/settings.dart';
import 'package:zerostrix/Views/Insta/show.dart';

void main() => runApp(ZeroApp());

class ZeroApp extends StatefulWidget {
	@override
	_ZeroAppState createState() => _ZeroAppState();
}

class _ZeroAppState extends State<ZeroApp> {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Zero Strix',
			routes: {
				'/': (context) => HomeIndex(),
				'/loading': (context) => Loading(),
				'/settings': (context) => Settings(),
				'/instagram/show': (context) => InstaShow(),
				'/login': (context) => LoginPage(),
				'/register': (context) => RegisterPage(),
			},
			initialRoute: '/loading',
			themeMode: ThemeMode.dark,
			darkTheme: ThemeData(
				brightness: Brightness.dark,
				splashColor: Colors.teal,
				accentColor: Colors.teal,
				primaryColorDark: Colors.teal,
				scaffoldBackgroundColor: Color.fromARGB(255, 32, 35, 43),
				fontFamily: 'IranSansDn',
			),
			theme: ThemeData(
				brightness: Brightness.light,
				fontFamily: 'IranSansDn',
			),
			debugShowCheckedModeBanner: false,
			navigatorObservers: [
				RouteObserver<PageRoute>()
			],
			localizationsDelegates: [
				GlobalMaterialLocalizations.delegate,
				GlobalWidgetsLocalizations.delegate,
			],
			supportedLocales: [
				Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
			],
			locale: Locale("fa", "IR")
		);
	}
}

