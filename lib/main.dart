import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/business/router/app_routes.dart';
import 'package:micros_user_app/data/services/services.dart';

void main() {
  runApp(
    // ! Declaro los Bloc que se pueden usar en toda la app
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(
            create: (context) =>
                MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => BusBloc(busService: BusService())),
      ],
      child: const MyApp(),
    ),
  );
}

// // ! Aqui declaro los providers para que esten lo mas alto del arbol de widgets

// class AppState extends StatelessWidget {
//   const AppState({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => No),
//       ],
//       child: const MyApp(),
//     );
//   }
// }

// ! Aqui declaro las routas usando el archivo app_routes y la llave de mensajeria

// * El tema de la app lo puse estatico con Light, si alguin quiere se da el tiempo y hace un personalizado

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Micros Online',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData.light(),
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
