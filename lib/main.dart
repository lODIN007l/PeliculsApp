import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/pantallas/screens.dart';
import 'package:flutter_peliculas_app/providers/movies_proveedor.dart';
import 'package:provider/provider.dart';

void main() => runApp(EstadodelaApp());

//widget para la peticion http con provider
class EstadodelaApp extends StatelessWidget {
  const EstadodelaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //cambiar la propiedad de lazy a false para que se pida la informacion apenas se ejecute
        ChangeNotifierProvider(
          create: (_) => PeliculaProveedor(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsPage(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: AppBarTheme(color: Colors.purpleAccent)),
    );
  }
}
