import 'package:project_wearable_technologies/classes/pkmn.dart';

class DayCare {
  List<Pkmn> deposit = [];
  int money = 0;

  void sell(Pkmn pkmn){
      money += pkmn.value;
      deposit.remove(pkmn);
  }

  bool buy(Pkmn pkmn){
    if (money>=pkmn.value){
      money -= pkmn.value;
      deposit.add(pkmn);
      return true;
    }
    return false;    
  }
}