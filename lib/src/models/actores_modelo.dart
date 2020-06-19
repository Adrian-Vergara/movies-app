
import 'dart:convert';

class Actores{

  List<Actor> actores = new List();

  Actores.formJsonList(List<dynamic> jsonList){

    if(jsonList == null) return;


    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });

  }

}

class Actor {
  int id;
  int castId;
  String character;
  String creditId;
  int gender;
  String name;
  int order;
  String profilePath;

  Actor(
      {this.id,
      this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.name,
      this.order,
      this.profilePath});

  Actor.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getFoto(){
    if(profilePath == null){
      return 'https://www.iconexperience.com/_img/o_collection_png/green_dark_grey/512x512/plain/user.png';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}
