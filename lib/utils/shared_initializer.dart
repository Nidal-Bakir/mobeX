import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// in splash screen (initState()) we await unit the SharedPreferences
/// var be available and then register it using get_it
class SharedInitializer {
  late final SharedPreferences sharedPreferences;

  SharedInitializer() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;

      // notify  get_it that the instance is ready
      GetIt.instance.signalReady(this);
    });
  }
}
