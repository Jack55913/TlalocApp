import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../models/app_state.dart';
import '../../models/google_sign_in.dart';

List<SingleChildWidget> appProviders = [
ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProxyProvider<GoogleSignInProvider, AppState>(
          create:
              (context) => AppState(
                Provider.of<GoogleSignInProvider>(context, listen: false),
              ),
          update:
              (context, authProvider, previousState) => AppState(authProvider),
        ),
];
