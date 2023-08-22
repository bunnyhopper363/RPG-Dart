import 'package:exo2/modals/chara.dart';
import 'dart:math'; 

class Character {
  String name;
  int maxPV = 100;
  int currentPV = 100;
  int maxMana = 10; 
  int currentMana = 10; 
  bool canUseSpecialAttack = false;

  Character(this.name); 

  void takeDamage(int damage) {
    currentPV -= damage;
    if (currentPV < 0) {
      currentPV = 0; 
    }
  }

  void heal() {
    if (currentPV <= 0.3 * maxPV) {
     
      currentPV += (0.5 * maxPV).toInt(); 
      if (currentPV > maxPV) {
        currentPV = maxPV; 
      }
      currentMana = 0;
    }
  }

  void performSpecialAttack(Character enemy) {
    if (canUseSpecialAttack) {
      print('$name ATTAQUE SPÉCIAL!');
      attack(enemy);
      attack(enemy);
      canUseSpecialAttack = false; 
    }
  }

  void attack(Character enemy) {
    final random = Random();
    int damage = random.nextInt(10) + 1; 
    print('$name attaque de $damage dommage!');
    enemy.takeDamage(damage); 
  }

  void regainMana() {
    currentMana += 2; 
    if (currentMana > maxMana) {
      currentMana = maxMana; 
    }
  }

  bool isAlive() {
    return currentPV > 0;
  }
}

void main() {
  final player1 = Character('Player 1'); 
  final player2 = Character('Player 2'); 

  var round = 1; 

  while (player1.isAlive() && player2.isAlive()) {
    print('Round $round');
    player1.regainMana(); 
    player2.regainMana(); 

    if (round % 5 == 0) {
      player1.canUseSpecialAttack = true; 
      player2.canUseSpecialAttack = true; 
    }

    player1.performSpecialAttack(player2); 
    if (!player2.isAlive()) {
      print('${player2.name} a été terrasser!'); 
      break;
    }

    player2.performSpecialAttack(player1); 
    if (!player1.isAlive()) {
      print('${player1.name} a été terrasser!'); 
      break;
    }

    round++; 
  }

  print('Bataille terminée.'); 
}
