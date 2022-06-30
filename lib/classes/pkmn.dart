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

  static Evolution? _addEvolution(Map<String, dynamic> jsonEvol, String name) {
    if (jsonEvol['evolves_to'].length == 0) {
      return null;
    } else if (jsonEvol['evolves_to'][0]['species']['name'] != name) {
      String nameEv = jsonEvol['evolves_to'][0]['species']['name'];
      int lvl = jsonEvol['evolves_to'][0]['evolution_details'][0]['min_level'];
      return Evolution(name: nameEv, levelToEvolve: lvl);
    } else {
      Map<String, dynamic> newJsonEvol = jsonEvol['evolves_to'][0];
      return _addEvolution(newJsonEvol, name);
    }
  }
}

