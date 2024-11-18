import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitamed/src/models/usuario.dart';

// import '../models/empresa_local.dart';

///VPS ID: 61830
// Main IP: 23.231.65.6
// Password: u38JZ.!rZaDb50

const String appName = 'Vitamed';

const ipLocal = '23.231.65.6';

const pathHost = 'jnp_real_state';
// 3u6Q!-D4WvXu7u Token
// LC!OU6)tJ0bbz
// kYxgib-nicfa0-sesnib
const double defaultPadding = 16.0;
// const String apiBaseUrl = 'https://api.myapp.com/';
const String logoApp = 'assets/icon/logo_vitamed.jpg';
// const String vertical = "imagen/vertical.png";
const double kwidth = 250;

String firmaLu = 'imagen/logo_lu.png';
Usuario? currentUsuario;
List<String> estadoPrestamo = ['pendiente', 'pagado', 'vencido'];
List<String> modoPagoPrestamo = ['semanal', 'quincenal', 'mensual'];

String textConfirmacion = '👉🏼Esta seguro realizar el pedido ? 👈🏼';
String eliminarMjs = '🥺Esta seguro de eliminar🥺';
// String ActionMjs = '👉🏼Esta seguro de confirmar el tiempo ?👈🏼';
String confirmarMjs =
    '👉🏼Esta seguro de confirmar el despacho de las facturas?👈🏼';
final kbuttonStyle = ButtonStyle(
    shape: MaterialStateProperty.resolveWith((states) =>
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))));

// EmpresaLocal currentEmpresa = EmpresaLocal(
//     adressEmpressa: 'Direccion N/A',
//     celularEmpresa: '(829)-338-6058',
//     nombreEmpresa: 'JNP REAL STATE',
//     oficinaEmpres: 'jnprealstate@gmail.com',
//     rncEmpresa: 'xxxxx-x',
//     telefonoEmpresa: '(829)-559-9788',
//     nCFEmpresa: 'A0100000001',
//     correoEmpresa: 'jnprealstate@gmail.com');

///token kYxgib-nicfa0-sesnib

const Color colorGrayLand = Color(0xff4d555d);

// const Color lightMintGreen = Color(0xffcff4e6);
const Color deepTeal = Color(0xff1b939b);
const Color mutedGrayGreen = Color(0xff839d9e);
const Color mediumGray = Color(0xff959596);
const Color aquaTeal = Color(0xff459496);
const Color softCyan = Color(0xff89dbdf);
const Color darkTeal = Color(0xff187d7b);
const Color oceanBlue = Color(0xff187c84);
const Color brightAqua = Color(0xff49b4b1);
const Color skyAqua = Color(0xff48acb4);
const Color skyAquaLight = Color.fromARGB(255, 122, 217, 223);
const Color lightMintGreen = Color(0xffaff0ba);

final fontTitle = GoogleFonts.archivoBlack();
final fontBody = GoogleFonts.baloo2();

// Available Animations
// FadeIn Animations
// FadeIn
// FadeInDown
// FadeInDownBig
// FadeInUp
// FadeInUpBig
// FadeInLeft
// FadeInLeftBig
// FadeInRight
// FadeInRightBig
// FadeOut Animations
// FadeOut
// FadeOutDown
// FadeOutDownBig
// FadeOutUp
// FadeOutUpBig
// FadeOutLeft
// FadeOutLeftBig
// FadeOutRight
// FadeOutRightBig
// BounceIn Animations
// BounceInDown
// BounceInUp
// BounceInLeft
// BounceInRight
// ElasticIn Animations
// ElasticIn
// ElasticInDown
// ElasticInUp
// ElasticInLeft
// ElasticInRight
// SlideIns Animations
// SlideInDown
// SlideInUp
// SlideInLeft
// SlideInRight
// FlipIn Animations
// FlipInX
// FlipInY
// Zooms
// ZoomIn
// ZoomOut
// SpecialIn Animations
// JelloIn
// Attention Seeker
// All of the following animations could be infinite with a property called infinite (type Bool)

// Bounce
// Dance
// Flash
// Pulse
// Roulette
// ShakeX
// ShakeY
// Spin
// SpinPerfect
// Swing
// Example: 01-Basic

final shadow =
    BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 10);

final decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: [shadow]);
