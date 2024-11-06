import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vitamed/src/screens/folder_screen_main/home_screen.dart';

import '../routes.dart';
import '../utils/constants.dart';

class MenuDrop extends StatefulWidget {
  const MenuDrop({super.key, this.isMobile = false});
  final bool isMobile;

  @override
  State<MenuDrop> createState() => _MenuDropState();
}

class _MenuDropState extends State<MenuDrop> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = Theme.of(context).textTheme;
    // final userProvider = Provider.of<UserProvider>(context);
    return Container(
      color: Colors.white,
      height: size.height,
      width: 175,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isMobile
                ? BounceInDown(
                    child: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: Image.asset(logoApp, fit: BoxFit.cover),
                    ),
                  )
                : const SizedBox(height: 10),
            const SizedBox(height: 10),
            MyWidgetButton(
                icon: Icons.home_outlined,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'Vitamed')),
                      (route) => false);
                },
                textButton: 'Home'),
            const Divider(endIndent: 20, indent: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Gestiones Clientes',
                      textAlign: TextAlign.justify,
                      style: style.bodySmall?.copyWith(color: deepTeal)),
                ],
              ),
            ),

            // MyWidgetButton(
            //     icon: Icons.view_list_outlined,
            //     onPressed: () {},
            //     textButton: 'Agregar Marcas'),
            // Column(
            //   children: [
            //     MyWidgetButton(
            //         icon: Icons.person_add_alt_outlined,
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const AddClientes()));
            //         },
            //         textButton: 'Agregar Clientes'),
            //     MyWidgetButton(
            //         icon: Icons.person_4_outlined,
            //         onPressed: () async {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const ScreenListClient()));
            //         },
            //         textButton: 'Clientes'),
            //   ],
            // ),

            // MyWidgetButton(
            //     icon: Icons.add_circle_sharp,
            //     onPressed: () async {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const AddVehiculo()));
            //     },
            //     textButton: 'Agregar Vehiculos'),

            // MyWidgetButton(
            //     icon: Icons.list_alt_outlined,
            //     onPressed: () async {
            //       // await showDialog(
            //       //     context: context,
            //       //     builder: (context) {
            //       //       return const UserFormDialog();
            //       //     });
            //     },
            //     textButton: 'Proveedores'),
            // MyWidgetButton(
            //     icon: Icons.format_list_bulleted_add,
            //     onPressed: () async {
            //       await showDialog(
            //           context: context,
            //           builder: (context) {
            //             return const UserFormDialog();
            //           });
            //     },
            //     textButton: 'Mis Productos'),
            // const Divider(endIndent: 20, indent: 20),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20),
            //   child: Row(
            //     children: [
            //       Text('Gestiones Clientes',
            //           textAlign: TextAlign.justify,
            //           style: style.bodySmall?.copyWith(color: colorBlueOpacity))
            //     ],
            //   ),
            // ),

            // const Divider(endIndent: 20, indent: 20),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20),
            //   child: Row(
            //     children: [
            //       Text('Gestiones Prestamos',
            //           textAlign: TextAlign.justify,
            //           style: style.bodySmall?.copyWith(color: colorBlueOpacity))
            //     ],
            //   ),
            // ),

            // Column(
            //   children: [
            //     MyWidgetButton(
            //         icon: Icons.add_to_drive,
            //         onPressed: () {
            //           // AddSan
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => const AddSan()),
            //           );
            //           //AddPrestamos
            //         },
            //         textButton: 'Crear prestamos'),
            //     MyWidgetButton(
            //         icon: Icons.list,
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const ScreenPrestaSan()));
            //         },
            //         textButton: 'Prestamos'),
            //     MyWidgetButton(
            //         icon: Icons.monetization_on_outlined,
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       const ScreenGestionPagos()));
            //         },
            //         textButton: 'Registro pagos'),
            //   ],
            // ),
            // const Divider(endIndent: 20, indent: 20),
            const Divider(endIndent: 20, indent: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Gestiones Proyectos',
                      textAlign: TextAlign.justify,
                      style: style.bodySmall?.copyWith(color: deepTeal))
                ],
              ),
            ),
            Column(
              children: [
                MyWidgetButton(
                    icon: Icons.shopping_cart_outlined,
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ScreenMyProject()),
                      // );
                      //AddPrestamos
                    },
                    textButton: 'Mis Proyectos'),

                //     MyWidgetButton(
                //         icon: Icons.landscape_outlined,
                //         textButton: 'Mis Ventas',
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                     VentasTerrenosScreen()), // Pantalla 1
                //           );
                //         }),
                //     MyWidgetButton(
                //         icon: Icons.motion_photos_auto_outlined,
                //         textButton: 'Mis Cobros',
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                     PagosFinanciamientosScreen()), // Pantalla 1
                //           );
                //         }),
                //     MyWidgetButton(
                //         icon: Icons.real_estate_agent_outlined,
                //         textButton: 'Financiamientos',
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                     FinanciamientoTerrenosScreen()), // Pantalla 6
                //           );
                //         }),
                //     // MyWidgetButton(
                //     //     icon: Icons.monetization_on_outlined,
                //     //     textButton: 'Gestión de Gastos',
                //     //     onPressed: () {
                //     //       Navigator.push(
                //     //         context,
                //     //         MaterialPageRoute(
                //     //             builder: (context) =>
                //     //                 ScreenGastosMain()), // Pantalla 6
                //     //       );
                //     //     }),
                //     // MyWidgetButton(
                //     //     icon: Icons.add,
                //     //     textButton: 'Registrar Gastos',
                //     //     onPressed: () {
                //     //       Navigator.push(
                //     //         context,
                //     //         MaterialPageRoute(
                //     //             builder: (context) =>
                //     //                 AddExpenseScreen()), // Pantalla 6
                //     //       );
                //     //     }),
                //     //AddExpenseScreen
                //     Container(
                //         height: 35,
                //         color: Colors.grey.shade300,
                //         child: MyDropdownButtonMenu())

                //     //ScreenGastosMain
                //     // Ventas de Terrenos
                //   ],
                // ),

                // MyWidgetButton(
                //     icon: Icons.list_outlined,
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 const ScreenListVehiculosRented()),
                //       );
                //     },
                //     textButton: 'Lista Rentas'),
                // MyWidgetButton(
                //     icon: Icons.car_repair_outlined,
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const ScreenListVehiculos()),
                //       );
                //       // ScreenListVehiculos
                //     },
                //     textButton: 'Lista de Vehiculos'),
                // MyWidgetButton(
                //     icon: Icons.shopping_bag_outlined,
                //     onPressed: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => PreDespacho()));
                //     },
                //     textButton: 'Despachar Pedidos'),

                ///PreDespacho
                // MyWidgetButton(
                //     icon: Icons.inventory_outlined,
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => ScreenDespacharFactura()));
                //     },
                //     textButton: 'Facturar'),
                // MyWidgetButton(
                //     icon: Icons.view_list_sharp,
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   const AddMantenimientoVehiculo()));
                //     },
                //     textButton: 'Gastos Vehiculos'),
                // MyWidgetButton(
                //     icon: Icons.shopping_cart_outlined,
                //     onPressed: () {
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //         builder: (context) => const ScreenCompras()));
                //     },
                //     textButton: 'Compras'),

                ///ScreenCompras

                // ScreenCrearPedido

                const Divider(endIndent: 20, indent: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text('Ajustes',
                          textAlign: TextAlign.justify,
                          style: style.bodySmall?.copyWith(color: deepTeal)),
                    ],
                  ),
                ),
                MyWidgetButton(
                    icon: Icons.settings_outlined,
                    onPressed: () {},
                    textButton: 'Cuenta'),

                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: MyWidgetButton(
                      icon: Icons.output_outlined,
                      onPressed: () async {
                        // Borrar preferencia de usuario
                        // userProvider.logout();
                        Navigator.pushNamedAndRemoveUntil(context,
                            Routes.splashScreen, ModalRoute.withName('/'));
                      },
                      textButton: 'Sign Out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidgetButton extends StatelessWidget {
  const MyWidgetButton(
      {super.key, this.onPressed, this.textButton, this.icon = Icons.person});
  final Function()? onPressed;
  final String? textButton;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                (states) => const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              // backgroundColor: MaterialStateProperty.resolveWith(
              //     (states) => Colors.grey.shade200),
            ),
            onPressed: onPressed,
            icon: Icon(icon,
                size: Theme.of(context).textTheme.bodySmall?.fontSize,
                color: Theme.of(context).textTheme.bodySmall?.color),
            label: Text(textButton ?? 'N/A',
                style: Theme.of(context).textTheme.bodySmall?.copyWith())),
      ),
    );
  }
}
