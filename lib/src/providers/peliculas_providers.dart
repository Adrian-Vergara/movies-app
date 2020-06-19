import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/actores_modelo.dart';
import 'package:movies/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apikey = '6a046a17ed3fa103f884349d416dd03e';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  //propiedad privada _
  int _popularesPage = 0;

  List<Pelicula> _populares = new List();
  bool _cargando = false;

  //crear stream
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  //Agregar peliculas al afluente de películas
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  //Escuchar Películas
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  //Método para cerrar stream
  void disposeStrems() {
    //si tiene el método close lo llama
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    final peliculas = new Peliculas.formJsonList(decodedData['results']);
    return peliculas.items;
  }


  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    //Paginación

    if(_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final response = await _procesarRespuesta(url);

    _populares.addAll(response);
    //Añadiendo información sink
    popularesSink(_populares);

    _cargando = false;
    return response;
  }

  Future<List<Actor>> getActores(String peliculaId) async{
    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key': _apikey,
      'language': _language
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final actores = new Actores.formJsonList(decodedData['cast']);
    return actores.actores;
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query
    });

    return await _procesarRespuesta(url);
  }

}