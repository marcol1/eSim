// Author: Marcos
/// @description Checks for keyboard input and updates which button is selected accordingly.

// GML Note: "step" events are events checked with every 'step' of the game.

menu_move = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up); //Returns 0 if nothing is being pressed (or both are pressed), 1 if vk_down is pressed, -1 if vk up is pressed

//Code for moving between butons below

menuIndex += menu_move;

if (menuIndex != lastSelected) { //If the button was moved
	playSound(1);
}

if (menuIndex < 0) {
	menuIndex = buttonCount - 1; //If it goes out of the array in the negative direction, put it at the end.
} else if (menuIndex == buttonCount) {
	menuIndex = 0; //If it goes out of the array in the positive direction, move it to the top
}

lastSelected = menuIndex;

//Code for shifting slider below

if (button[lastSelected] == "Slider:Music Volume") { //If currently on the slider, execute the slider's function. The slider's visual will automatically adjust.
	var slider_move = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left); //If right is pressed returns 1. If left is pressed, return -1. Otherwise, return 0. 
	var volume = inst_MUSICLOOPER.musicVolume;
	
	if (slider_move != 0) { //If the slider was moved
		playSound(1);
		if (volume + (10*slider_move)) >= 0 and (volume + (10*slider_move)) <= 100 {
			inst_MUSICLOOPER.musicVolume += 10*slider_move;
		}
	}
} else if (button[lastSelected] == "Slider:Sound Effects Volume") { //If currently on the slider, execute the slider's function. The slider's visual will automatically adjust.
	var slider_move = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left); //If right is pressed returns 1. If left is pressed, return -1. Otherwise, return 0. 
	var volume = inst_SFXPLAYER.SFXVolume;
	
	if (slider_move != 0) { //If the slider was moved
		playSound(1);
		if (volume + (10*slider_move)) >= 0 and (volume + (10*slider_move)) <= 100 {
			inst_SFXPLAYER.SFXVolume += 10*slider_move;
		}
	}
}