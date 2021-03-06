//@author Marcos Lacouture
/*findFoodCarnivore will find food for a carnivore (or eventually, omnivore) within the creature's perceptive range.
* The function takes in account the creature's aggressivity when determining whether the creature will hunt for food or scavenge, as well as 
* using aggressivity and the creature's traits to determine how bold it is in hunting larger creatures.
*/
 
var creature = argument[0];
var sightRange = argument[1];

closestCorpseFound = pointer_null; //Check for corpses first.
closestCorpseDistance = 99999999;


if (creature.aggressivity < 0.75) { //If the creature is very aggressive (0.75 or more), it will never scavenge. If it is not this aggressive, however, it will scavenge (try to find an already dead corpse) first before trying to hunt.
	
	for (var i = 0; i < ds_list_size(global.corpseList); i++) {
		var currentCorpse = ds_list_find_value(global.corpseList, i);
		var distanceFromCurrent = sqrt(sqr(creature.x - currentCorpse.x) + sqr(creature.y - currentCorpse.y));
		
		if (distanceFromCurrent <= sightRange) {
			if (distanceFromCurrent < closestCorpseDistance) { //Go for the closest corpse.
				if (point_in_rectangle(currentCorpse.x, currentCorpse.y, creature.creatureWidth/8 + 1.5, creature.creatureHeight/8 + 1.5, room_width - creature.creatureWidth/8 - 1.5, room_height - creature.creatureHeight/8 - 1.5) == true) { //Check the corpse is accessible
					closestCorpseFound = currentCorpse;
					closestCorpseDistance = distanceFromCurrent;
				}
			}
		}
		
	}
}

if (closestCorpseFound == pointer_null) { // If no corpses are found or the creature chooses not to look for any, have the creature consider hunting a living creature.
	
	mostViableCreature = pointer_null;
	highestViability = -9999999999; //"Viability" will determine whether or not a creature is a viable target for hunting.
	//This is determined by the creature and target's combat-relevant characteristics, as well as the creature's aggressivity, the amount of creatures in the other species, its distance away, etc.
	//Set to an extremely low number so that it will be overridden, a quick fix to avoid needing a fencepost fix.
	
	for (var i = 0; i < ds_list_size(global.speciesList); i++) { // For every species
	
		var currentSpecies = ds_list_find_value(global.speciesList, i);
	
		if (currentSpecies.name != creature.species) { //Don't hunt creatures of your own species
			var creatures = currentSpecies.creatures;
	
			for (var j = 0; j < ds_list_size(creatures); j++) { //For each creature in each species
				var targetCreature = ds_list_find_value(creatures, j);
		
				var distanceFromCreature = sqrt(sqr(creature.x - targetCreature.x) + sqr(creature.y - targetCreature.y));
	
				if (distanceFromCreature<= sightRange) { //if the creature can see the target
					if (targetCreature.x <  (room_width - (creature.creatureWidth/8))) and (targetCreature.x > (creature.creatureWidth/8)) {
				
						if (targetCreature.y < room_height - (creature.creatureHeight/8)) and (targetCreature.y > (creature.creatureHeight/8))  { //If the creature can access the target
							
							if (detectsCreature(creature, targetCreature) == true) { //If you successfully detect the target creature
								
								var targetViability = checkViability(creature, targetCreature); //checkViability will get how viable a target is for hunting based on a variety of factors.
							
								if (targetViability > highestViability) { //If you find a more viable target for hunting, set that target as priority.
									if (point_in_rectangle(targetCreature.x, targetCreature.y, creature.creatureWidth/8, creature.creatureHeight/8, room_width - creature.creatureWidth/8, room_height - creature.creatureHeight/8) == true) { //Check the target is accessible; if it is, make it the most viable.
										highestViability = targetViability;
										mostViableCreature = targetCreature;
									}
								}
								
							} else {
								//show_debug_message("Target creature " + targetCreature.species + " avoided detection.");	
							}
							
						}
				
					}
			
				}
			}
			
		}
	
	}
}

if (closestCorpseFound != pointer_null) {
	return closestCorpseFound;
} else {
	return mostViableCreature;
}