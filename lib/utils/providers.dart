import 'package:abe/view_models/auth/login_view.dart';
import 'package:abe/view_models/auth/posts_view_model.dart';
import 'package:abe/view_models/auth/register_view_model.dart';
import 'package:abe/view_models/theme/theme_view_model.dart';
import 'package:abe/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_models/conversation/conversation_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => UserViewModel()),
  ChangeNotifierProvider(create: (_) => PostsViewModel()),
  ChangeNotifierProvider(create: (_) => ConversationViewModel()),
];
