import 'dart:async';
import 'dart:io';
import 'package:abe/chats/recent_chats.dart';
import 'package:abe/screens/ChoosePhoto/choosePhotoScreen.dart';
import 'package:abe/screens/Gallery/galleryScreen.dart';
import 'package:abe/screens/circles/circlesScreen.dart';
import 'package:abe/screens/cityPage/cityScreen.dart';
import 'package:abe/screens/communities/communitiesScreen.dart';
import 'package:abe/screens/community/communityPage.dart';
import 'package:abe/screens/community/communityScreen.dart';
import 'package:abe/screens/countryPage/countyScreen.dart';
import 'package:abe/screens/discover/discoverScreen.dart';
import 'package:abe/screens/friends/friendScreen.dart';
import 'package:abe/screens/homePage/homePageScreen.dart';
import 'package:abe/screens/investor/investor.dart';
import 'package:abe/screens/members/membersScreen.dart';
import 'package:abe/screens/notifications/notifications.dart';
import 'package:abe/screens/offerScreen/offersScreen.dart';
import 'package:abe/screens/page/pageScreen.dart';
import 'package:abe/screens/profile/profileScreen.dart';
import 'package:abe/screens/search/searchScreen.dart';
import 'package:abe/screens/shareApp/shareApp.dart';
import 'package:abe/screens/signup/signupScreen.dart';
import 'package:abe/screens/splash/splashScreen.dart';
import 'package:abe/screens/sponsor/sponsor.dart';
import 'package:abe/screens/startup/startupScreen.dart';
import 'package:abe/screens/whatsapp_home.dart';
import 'package:abe/screens/writePost/writepost.dart';
import 'package:abe/screens/writePost/writepostC.dart';
import 'package:abe/services/auth_service.dart';
import 'package:abe/utils/config.dart';
import 'package:abe/utils/constants.dart';
import 'package:abe/utils/providers.dart';
import 'package:abe/view_models/auth/login_view.dart';
import 'package:abe/view_models/auth/posts_view_model.dart';
import 'package:abe/view_models/auth/register_view_model.dart';
import 'package:abe/view_models/conversation/conversation_view_model.dart';
import 'package:abe/view_models/theme/theme_view_model.dart';
import 'package:abe/view_models/user/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/partner/partner.dart';
import 'screens/commercial/commercialScreen.dart';
import 'screens/loginScreen/loginScreen.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initFirebase();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ABE',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/splashScreen',
          routes: {
            '/splashScreen': (context) => splashScreen(),
            '/loginScreen': (context) => Login(),
            '/signupScreen': (context) => Sign(),
            '/homePageScreen': (context) => Home(),
            '/startUpScreen': (context) => OnBoardingScreen(),
            '/shareAppScreen': (context) => ShareApp(),
            '/commercialScreen': (context) => Commercial(),
            '/discoverScreen': (context) => discover(),
            '/communityScreen': (context) => Community(),
            '/searchScreen': (context) => search(),
            '/friends': (context) => FriendsTab(),
            '/communityPageScreen': (context) => communityPage(),
            '/chatScreen': (context) => Chats(),
            '/abeCommunitiesScreen': (context) => communitiesPage(),
            '/abeCirclesScreen': (context) => circlesPage(),
            '/membersScreen': (context) => membersPage(),
            '/countryScreen': (context) => countryPage(),
            '/cityScreen': (context) => cityPage(),
            '/offerScreen': (context) => offerScreen(),
            '/galleryScreen': (context) => galleryPage(),
            '/choosePhoto': (context) => ChoosePhotoScreen(),
            '/writePost': (context) => createPost(),
            '/writePostC': (context) => createPostC(),
            '/notifications': (context) => Activities(),

          },
        )
    );
  },);
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterViewModel>(create: (_) => RegisterViewModel(),),
        ChangeNotifierProvider<LoginViewModel >(create: (_) => LoginViewModel() ,),
        ChangeNotifierProvider<ThemeProvider >(create: (_) => ThemeProvider() ,),
        ChangeNotifierProvider<UserViewModel >(create: (_) => UserViewModel()),
        ChangeNotifierProvider<PostsViewModel>(create: (_) => PostsViewModel()),
        ChangeNotifierProvider<ConversationViewModel>(create: (_) => ConversationViewModel()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider notifier, Widget? child) {
          return MaterialApp(
            title: "ABE",
            debugShowCheckedModeBanner: false,
            theme: themeData(
              notifier.dark ? Constants.darkTheme : Constants.lightTheme,
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return homePage();
                } else
                  return splashScreen();
              }),
            ),
          );
        },
      ),
    );
  }
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(
        theme.textTheme,
      ),
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}




