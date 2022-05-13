class Pkmn{
  int id = -1;
  String name = '';
  int height = -1;
  int weight = -1;
  String sprite = '';
  List<String> type = [];
  int value = 0;

  Pkmn({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.sprite,
    required this.type,
  });

  Pkmn.nothing();

  factory Pkmn.fromJson(Map<String, dynamic> json) {
    return Pkmn(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      sprite: json['sprites']['front_default'],
      type: extractTypes(json),
    );
  }//Pokemon.fromJson

  static List<String> extractTypes(json){
    List<String> pop = [];
    for (int i=0; i<json['types'].length; i++){
      pop.add(json['types'][i]['type']['name']);
    }
    return pop;
  }
  
}//Pokemon