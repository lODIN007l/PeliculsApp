import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/providers/movies_proveedor.dart';
import 'package:flutter_peliculas_app/search/search_delegate.dart';
import 'package:flutter_peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final peliculasPro = Provider.of<PeliculaProveedor>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Películas en cines'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Tarjetas principales
              CardSwiper(movies: peliculasPro.destacadosPeliculas),

              // Slider de películas
              MovieSlider(
                movies: peliculasPro.peliculasPopulares, // populares,
                title: 'Populares', // opcional

                //onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
