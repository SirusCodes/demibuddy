import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

final getIt = GetIt.I;
Future<void> initGetIt() async {
  final client =
      Client().setEndpoint(APPWRITE_ENDPOINT).setProject(APPWRITE_PROJECT);

  getIt.registerSingleton(Database(client));
  getIt.registerSingleton(Storage(client));
  getIt.registerSingleton(Account(client));

  final _sharedPref = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(_sharedPref);
}
