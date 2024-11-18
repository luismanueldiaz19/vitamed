import 'package:permission_handler/permission_handler.dart';

class PermissionMethonds {
  askPermissionNotificacion() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      } else {
        print('YA TIENE PERMISO PARA RECIBIR NOTIFICACIONES');
      }
    });
  }
}
