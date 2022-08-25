
class Kelime {

  late double kelime_id;
  late String kelime_ing;
  late String kelime_turkce;

  Kelime({required this.kelime_id, required this.kelime_ing, required this.kelime_turkce});

  factory Kelime.fromJson(Map<String,dynamic> json){
    return Kelime(kelime_id: json["kelime_id"], kelime_ing: json["kelime_ing"], kelime_turkce: json["kelime_turkce"]);
  }
}