/// @description Draw the creature based on its characteristics
//@author Marcos Lacouture

var headOffsetX = 0;
var headOffsetY = 0;
var headScaleX = 1; //Some heads need to be rescaled to fit their bodies.
var headScaleY = 1;

var armOffsetX = 0;
var armOffsetY = 0;
var armScaleX = 1;
var armScaleY = 1

var localScaleFactor = scaleFactor;
localScaleFactor *= facing; //Use a local scale factor so you can change direction if facing is -1.
//Local scale factor will only be applied to any X-scaling, as you only want to flip the sprite horizontally.

localSpriteColor = sprite_color; //Use a local sprite color so that you can paint the creature as red when it is damaged.

if (flashingRed == true) {
	localSpriteColor = c_red;
	if (!alarm[2]) {
		alarm[2] = 6; 	
	}
}


//Calculate offsets in these if statements below. All these values are manually calibrated so that each body part looks good. Don't worry about this code.


if (sprite_body == 0) { 
	sprite_arm = -1; //Failsafe: This body cannot have an arm as it is a quadripedal body.
		if (sprite_head == 0) { //Wolf head
			headOffsetX = 33;
			headOffsetY = -5;
		} else if (sprite_head == 1) { //Boar head
			headOffsetX = 32;
			headOffsetY = -5;
			headScaleX = 1;
			headScaleY = 0.75;
		} else if (sprite_head == 2) { //angry reptile head
			headOffsetX = 31;
			headOffsetY = 3;
			headScaleY = 1.2;
		} else if (sprite_head == 3) { //Bunny Head
			headScaleX = 1.15;
			headScaleY = 1.15;
			headOffsetX = 33;
			headOffsetY = -5;
		} else if (sprite_head == 4) { //T-rex head
			headOffsetX = 31;
			headOffsetY = 3;
			headScaleY = 1.1;
		} else if (sprite_head == 5) { // Deer head
			headScaleX = 1.2;
			headScaleY = 1.2;
			headOffsetX = 33;
			headOffsetY = -9;
		} else if (sprite_head == 6) { //Deer head (w/ antlers)
			headScaleX = 1.2;
			headScaleY = 1.2;
			headOffsetX = 33;
			headOffsetY = -13;
		}
} else if (sprite_body == 1) {
	sprite_arm = -1; //Failsafe: This body cannot have an arm as it is a quadripedal body.
	if (sprite_head == 0) {
			headScaleY= 1.5;
			headOffsetX = 25;
			headOffsetY = -5;
		} else if (sprite_head == 1) {
			headOffsetX = 25;
			headOffsetY = 2;
			headScaleX = 1;
			headScaleY = 1;
		} else if (sprite_head == 2) {
			headOffsetX = 20;
			headOffsetY = 0;
			headScaleY = 1.75;
			headScaleX = 1.5;
		} else if (sprite_head == 3) {
			headScaleY= 1.65;
			headScaleX = 1.15;
			headOffsetX = 25;
			headOffsetY = -5;
		} else if (sprite_head == 4) {
			headOffsetX = 24;
			headOffsetY = 0;
			headScaleY = 1.55;
			headScaleX = 1.5;
		} else if (sprite_head == 5) {
			headScaleY= 1.65;
			headScaleX = 1.80;
			headOffsetX = 25;
			headOffsetY = -5;
		} else if (sprite_head == 6) {
			headScaleY= 1.65;
			headScaleX = 1.80;
			headOffsetX = 25;
			headOffsetY = -9;
		}
} else if (sprite_body == 2) {
	if (sprite_head == 0) {
			headOffsetX = 5;
			headOffsetY = -22;
			headScaleX = 0.8;
			headScaleY = 0.9;
		} else if (sprite_head == 1) {
			headOffsetX = 9;
			headOffsetY = -25;
			headScaleX = 0.75;
			headScaleY = 0.6;
		} else if (sprite_head == 2) {
			headOffsetX = 6;
			headOffsetY = -25;
			headScaleX = 0.75;
			headScaleY = 1;
		} else if (sprite_head == 3) {
			headOffsetX = 7;
			headOffsetY = -28;
			headScaleX = 0.95;
			headScaleY = 1.25;
		} else if (sprite_head == 4) {
			headOffsetX = 8;
			headOffsetY = -20;
			headScaleX = 0.9;
		}  else if (sprite_head == 5) {
			headOffsetX = 6.5;
			headOffsetY = -28;
			headScaleX = 1.25;
			headScaleY = 1.1;
		} else if (sprite_head == 6) {
			headOffsetX = 6.5;
			headOffsetY = -32;
			headScaleX = 1.25;
			headScaleY = 1.1;
		}
		
		//Second if statements for drawing arms below
		if (sprite_arm == 0) {
			armScaleX = 1;
			armScaleY = 1;
			armOffsetY = 3;
		}
}

//Next, scale everything.
headOffsetX *= localScaleFactor;
headOffsetY *= scaleFactor;


//Finally, draw everything.

if (dead == false) { //If the creature is alive you have to draw it differently than if its dead.
	draw_sprite_ext(bodySprite, sprite_body, x, y, localScaleFactor, scaleFactor, 0, localSpriteColor, 1);
	draw_sprite_ext(headSprite, sprite_head, (x +headOffsetX), (y + headOffsetY), localScaleFactor * headScaleX, scaleFactor * headScaleY, 0, localSpriteColor, 1);

	if (sprite_arm != -1) {
		draw_sprite_ext(armSprite, sprite_arm, (x +armOffsetX), (y + armOffsetY), localScaleFactor * armScaleX, scaleFactor * armScaleY, 0, localSpriteColor, 1);
	}

	if (showPerceptionView == true) {
		draw_set_colour(c_red);
		draw_rectangle(x - viewRange, y - viewRange, x + viewRange, y + viewRange,true);
		draw_set_colour(c_white);
	}
		
} else { //If the creature's dead
	draw_sprite_ext(bodySprite, sprite_body, x, y, localScaleFactor, (scaleFactor*-1), 0, c_gray, 1);
	draw_sprite_ext(headSprite, sprite_head, (x +headOffsetX), (y - headOffsetY), localScaleFactor * headScaleX, (scaleFactor*-1) * headScaleY, 0, c_gray, 1);

	if (sprite_arm != -1) {
		draw_sprite_ext(armSprite, sprite_arm, (x +armOffsetX), (y - armOffsetY), localScaleFactor * armScaleX, (scaleFactor*-1) * armScaleY, 0, c_gray, 1);
	}
}