/// @description Initialize the creature after setting its "fields" with another script.


//All individual subcharacteristics will be calculated below (things such as movement speed, size, etc.) based on the characteristics of the creature.


movementSpeed = dexerity/8; 

scaleFactor = stamina/45 + defense/35 + dexerity/65 + perception/100 + attack/45; //Certain characteristics have more weight in determining size than others.
creatureWidth *= scaleFactor;
creatureHeight *= scaleFactor;

creatureMaxHealth = defense * 10;
creatureHealth = creatureMaxHealth;

starvationSeconds *= (1 + (stamina/30)); //Creatures with higher stamina will starve slower

viewRange = perception * 25; //How far the creature can see, including perceiving threats and food.

maxHunger = scaleFactor* 200; //Hunger is based on size.
hunger = maxHunger; 

currentFood = maxHunger * 5; //One dead creature will be able to feed 5 of itself.

initialized = true;

/*
	Debugging code below (show all characteristics of each creature)
	*/
	show_debug_message("Creature of " + species + " species.");
	show_debug_message("--------------------");
	show_debug_message("Attack: " + string(attack));
	show_debug_message("Defense: " + string(defense));
	show_debug_message("Dexerity: " + string(dexerity));
	show_debug_message("Perception: " + string(perception));
	show_debug_message("Stamina: " + string(stamina));
	show_debug_message("Aggressivity: " + string(aggressivity));
	show_debug_message(" ");