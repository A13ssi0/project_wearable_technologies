class Evolution {
  String name;
  int levelToEvolve;
  Evolution({required this.name, required this.levelToEvolve});
}

class Pkmn {
  final int id;
  final String name;
  final String sprite;
  final List<String> type;
  final int value = 0;
  final int level = 1;
  final String growRate;
  final Evolution? evolChain;
  final int exp = 0;
  final String expToLevel;

// _____________________ CONSTRUCTORS ______________________________________________________________

  Pkmn({
    required this.id,
    required this.name,
    required this.sprite,
    required this.type,
    required this.growRate,
    required this.evolChain,
    required this.expToLevel,
  });
  factory Pkmn.fromJson(Map<String, dynamic> jsonPkmn, Map<String, dynamic> jsonSpec, Map<String, dynamic> jsonEvol, String jsonLevel) {
    return jsonEvol.isEmpty
        ? Pkmn(
            id: 0,
            name: '',
            sprite: '',
            type: [],
            growRate: '',
            evolChain: null,
            expToLevel: '',
          )
        : Pkmn(
            id: jsonPkmn['id'],
            name: jsonSpec['name'],
            sprite: jsonPkmn['sprites']['front_default'],
            type: _extractTypes(jsonPkmn),
            growRate: jsonSpec['growth_rate']['name'],
            evolChain: _addEvolution(jsonEvol, jsonPkmn['name']),
            expToLevel: jsonLevel,
          );
  }

// _____________________ PRIVATE METHODS ___________________________________________________________
  static List<String> _extractTypes(json) {
    List<String> _type = [];
    for (int i = 0; i < json['types'].length; i++) {
      _type.add(json['types'][i]['type']['name']);
    }
    return _type;
  }

  static Evolution? _addEvolution(Map<String, dynamic> jsonEvol, String name, [int lvlAct = 1]) {
    if (jsonEvol['evolves_to'].length == 0) {
      return null;
    }
    Map<String, dynamic> jsonEvol1 = jsonEvol['evolves_to'][0];
    Map<String, dynamic>? jsonEvol2;
    if (jsonEvol1['evolves_to'].length > 0) {
      jsonEvol2 = jsonEvol1['evolves_to'][0];
    }
    int lvl;
    if (jsonEvol['species']['name'] == name) {
      String nameEv = jsonEvol1['species']['name'];
      jsonEvol1['evolution_details'][0]['min_level'] != null ? lvl = jsonEvol1['evolution_details'][0]['min_level'] : lvl = 21;
      return Evolution(name: nameEv, levelToEvolve: lvl);
    } else if (jsonEvol1['species']['name'] == name && jsonEvol2 != null) {
      String nameEv = jsonEvol2['species']['name'];
      jsonEvol2['evolution_details'][0]['min_level'] != null
          ? lvl = jsonEvol2['evolution_details'][0]['min_level']
          : jsonEvol1['evolution_details'][0]['min_level'] != null
              ? lvl = jsonEvol1['evolution_details'][0]['min_level'] * 2
              : lvl = 21 * 2;
      return Evolution(name: nameEv, levelToEvolve: lvl);
    }
    return null;
  }
}
