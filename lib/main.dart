import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/categoriesProvider.dart';
import './providers/wishList.dart';
import './providers/itemsProvider.dart';
import './Screens/splashScreen.dart';
import './Screens/homePageScreen.dart';
import './Screens/loginScreen.dart';
import './Screens/signupScreen.dart';
import './Screens/itemDetails.dart';
import './Screens/shareItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Items>(
          builder: (context, auth, previousItems) => Items(auth.token,
              previousItems == null ? [] : previousItems.items, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, WishList>(
          builder: (context, auth, previousItems) =>
              WishList(auth.token, auth.userId),
        ),
        ChangeNotifierProvider(
          builder: (context) => Categories(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            accentColor: Colors.blue,
            fontFamily: 'Cardo',
            textTheme: ThemeData.light().textTheme.copyWith(
                  body1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  body2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  title: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 20.0,
                      color: Colors.white,
                      decorationColor: Colors.black),
                ),
          ),
          home: auth.isAuth
              ? HomePageScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapShot) =>
                      snapShot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          routes: {
            'homePageScreen': (context) => HomePageScreen(),
            'loginScreen': (context) => LoginScreen(),
            'signupScreen': (context) => SignUpScreen(),
            'itemDetails': (context) => ItemDetails(),
            'shareItem': (context) => ShareItemScreen(),
          },
        ),
      ),
    );
  }
}
