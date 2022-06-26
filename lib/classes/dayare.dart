import 'package:project_wearable_technologies/classes/pkmn.dart';

class Dayare {
  static List<Pkmn> deposit = [];
  static int money = 0;

  void addPkmn(Pkmn pkmn) {
    deposit.add(pkmn);
  }

  void sellPkmn(Pkmn pkmn) {
    money += pkmn.value;
    deposit.remove(pkmn);
  }

  static bool isBuyable(Pkmn pkmn) {
    if (money >= pkmn.value) {
      money -= pkmn.value;
      deposit.add(pkmn);
      return true;
    }
    return false;
  }

  int howManyPkmn() {
    return deposit.length;
  }
}
