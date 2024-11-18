import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String userIdKey = 'userId';
  static const String usuarioKey = 'usuario';
  // Guardar el ID del usuario en SharedPreferences
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  Future<void> saveUsuarioLocal(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(usuarioKey, json);
  }

  // Obtener el ID del usuario desde SharedPreferences
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(usuarioKey);
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

  Future<void> clearUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(usuarioKey);
  }
}
