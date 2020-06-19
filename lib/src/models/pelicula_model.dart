
import 'package:http/http.dart';

class Peliculas{

  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.formJsonList(List<dynamic> jsonList){

    if(jsonList == null) return;

    for(var item in jsonList){
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }

  }

}

class Pelicula {

  String uniqueId;

  int id;
  int voteCount;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula(
      {this.id,
      this.voteCount,
      this.video,
      this.voteAverage,
      this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.backdropPath,
      this.adult,
      this.overview,
      this.releaseDate});

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    voteCount = json['vote_ount'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImg(){
    if(posterPath == null){
      return 'https://banner2.cleanpng.com/20180319/hke/kisspng-computer-icons-photography-img-landscape-photo-photography-picture-icon-5ab054dd97c503.7013351615215055016217.jpg';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg(){
    if(backdropPath == null){
      return 'https://banner2.cleanpng.com/20180319/hke/kisspng-computer-icons-photography-img-landscape-photo-photography-picture-icon-5ab054dd97c503.7013351615215055016217.jpg';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }

}
