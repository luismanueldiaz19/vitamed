import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String userIdKey = 'userId';

  // Guardar el ID del usuario en SharedPreferences
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  // Obtener el ID del usuario desde SharedPreferences
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // Verificar si el usuario está autenticado
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(userIdKey);
  }

  // Eliminar el ID del usuario de SharedPreferences
  Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
  }
}
