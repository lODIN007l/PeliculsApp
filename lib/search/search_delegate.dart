import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/models/movie.dart';
import 'package:flutter_peliculas_app/providers/movies_proveedor.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar Pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('hola3');
  }

  Widget vacioInfo() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black45,
          size: 160,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return vacioInfo();
    }
    final peliPro = Provider.of<PeliculaProveedor>(context, listen: false);
    return FutureBuilder(
      future: peliPro.buscarPelicula(query),
      builder: (_, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (!snapshot.hasData) {
          return vacioInfo();
        }
        final moviess = snapshot.data!;
        return ListView.builder(
          itemCount: moviess.length,
          itemBuilder: (_, int index) {
            return _elemnteotoBuscado(moviess[index]);
          },
        );
      },
    );
  }
}

class _elemnteotoBuscado extends StatelessWidget {
  final Pelicula peli;

  const _elemnteotoBuscado(this.peli);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(peli.imagenDestacada)),
      title: Text(peli.title),
      subtitle: Text(peli.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: peli);
      },
    );
  }
}
