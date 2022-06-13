class Evolution {
  String name;
  int? levelToEvolve;
  Evolution({required this.name, levelToEvolve});
}

class Pkmn {
  int? id;
  String name = '';
  String sprite = '';
  List<String> type = [];
  int value = 0;
  int level = 1;
  int? captRate;
  String? growRate;
  bool mythical = false;
  bool legendary = false;
  List<Evolution>? evolChain;
  int exp = 0;
  List expToLevel = [];

// _____________________ CONSTRUCTORS ______________________________________________________________

  Pkmn({
    required this.id,
    required this.name,
    required this.sprite,
    required this.type,
    required this.captRate,
    required this.growRate,
    required this.legendary,
    required this.mythical,
    required this.evolChain,
    required this.expToLevel,
  });

  Pkmn.nothing();

  factory Pkmn.fromJson(Map<String, dynamic> jsonPkmn, Map<String, dynamic> jsonSpec, Map<String, dynamic> jsonEvol, Map<String, dynamic> jsonLevel) {
    return jsonEvol.isEmpty
        ? Pkmn.nothing()
        : Pkmn(
            id: jsonPkmn['id'],
            name: jsonPkmn['name'],
            sprite: jsonPkmn['sprites']['front_default'],
            type: _extractTypes(jsonPkmn),
            captRate: jsonSpec['capture_rate'],
            growRate: jsonSpec['growth_rate']['name'],
            legendary: jsonSpec['is_legendary'],
            mythical: jsonSpec['is_mythical'],
            evolChain: _extractChainEvolutions(jsonEvol, jsonPkmn['name']),
            expToLevel: jsonLevel['levels'],
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

  static List<Evolution> _extractChainEvolutions(jsonEvol, name) {
    List<Evolution> chain = [];
    _addChainEvolutions(jsonEvol, name, chain);
    return chain;
  }

  static void _addChainEvolutions(jsonEvol, name, chain, [bool alreadyPassed = false]) {
    bool existNext = jsonEvol['evolves_to'].length > 0;
    Evolution actualEv = _extractEvolution(jsonEvol, existNext);
    alreadyPassed = actualEv.name == name;

    alreadyPassed == true ? chain.add(actualEv) : null;
    existNext == true ? _addChainEvolutions(jsonEvol['evolves_to'][0], name, chain) : null;
  }

  static Evolution _extractEvolution(jsonEvol, existNext) {
    String _jsonName = jsonEvol['species']['name'];
    int? _jsonLevel;
    if (existNext) {
      _jsonLevel = jsonEvol['evolves_to'][0]['evolution_details'][0]['min_level'];
    }
    return Evolution(name: _jsonName, levelToEvolve: _jsonLevel);
  }

// _____________________ PUBLIC METHODS ____________________________________________________________

  bool isMithical() => mythical;
  bool isLegendary() => legendary;

  //int calcExpLevel (int actualLevel){
//growRate == 'fast'
//? return 1
  //  : return 8
  // }
}
