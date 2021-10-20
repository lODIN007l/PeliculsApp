import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_peliculas_app/models/credits_response.dart';
import 'package:flutter_peliculas_app/models/movie.dart';
import 'package:flutter_peliculas_app/providers/movies_proveedor.dart';
import 'package:provider/provider.dart';

class CastinActores extends StatelessWidget {
  final int movieID;

  const CastinActores(this.movieID);

  @override
  Widget build(BuildContext context) {
    final provPeliculas =
        Provider.of<PeliculaProveedor>(context, listen: false);
    return FutureBuilder(
      future: provPeliculas.getMovieCast(movieID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastActores(cast[index]),
          ),
        );
      },
    );
  }
}

class _CastActores extends StatelessWidget {
  final Cast actor;

  const _CastActores(this.actor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
