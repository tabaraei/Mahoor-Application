import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'template/theme.dart';
import 'template/routes.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // import 'package:flutter/services.dart';
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"),
      ],
      locale: Locale("fa", "IR"),
      title: 'Mahoor',
      theme: theme,
      onGenerateRoute: (settings) => navigate(settings),
      // home: BlocProvider<NavigationBloc>(
      //   create: (context) => NavigationBloc(),
      //   child: Layout(),
      // ),
    );
  }
}
