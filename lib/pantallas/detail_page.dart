import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_peliculas_app/models/movie.dart';
import 'package:flutter_peliculas_app/widgets/widgets.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula movie =
        ModalRoute.of(context)?.settings.arguments as Pelicula;

    //print(movie.title);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _Custombar(movie: movie),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosteryTitulo(movie),
          _OvervieContenedor(movie),
          CastinActores(movie.id),
        ])),
      ],
    ));
  }
}

class _Custombar extends StatelessWidget {
  final Pelicula movie;

  const _Custombar({required this.movie});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.imagenPortada),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosteryTitulo extends StatelessWidget {
  final Pelicula movie;

  const _PosteryTitulo(this.movie);

  @override
  Widget build(BuildContext context) {
    final temaTexto = Theme.of(context).textTheme;
    final tamanio = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.id,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.imagenDestacada),
                  height: 150,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: tamanio.width - 190),
                child: Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: temaTexto.headline5,
                ),
              ),
              Text(
                movie.originalTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: temaTexto.subtitle1,
              ),
              Row(
                children: [
                  Icon(Icons.star_outline, size: 25, color: Colors.amber),
                  Text(
                    movie.voteAverage.toString(),
                    style: temaTexto.caption,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OvervieContenedor extends StatelessWidget {
  final Pelicula movie;

  const _OvervieContenedor(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        style: TextStyle(fontSize: 17),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
