import 'package:flutter/material.dart';
import 'package:movies/src/models/pelicula_model.dart';
import 'package:movies/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Capitan America'
  ];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          //Código para limpiar los datos de la barra de búsqueda
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Ícono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder o instrucción que crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.lightBlueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
        future: peliculasProvider.buscarPeliculas(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if(snapshot.hasData){
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas.map((pelicula) {
                pelicula.uniqueId = '${pelicula.id}-search';
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-img.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    close(context, null);
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList(),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

/*
  * Widget buildSuggestions(BuildContext context) {
    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas.where(
            (element) => element.toLowerCase().startsWith(query.toLowerCase())
    ).toList();

    // Sugerencias que aparecen cuando la persona escribe
    return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[index]),
            onTap: () {
              seleccion = listaSugerida[index];
              showResults(context);
            },
          );
        });
  }
  *
  * */

}
