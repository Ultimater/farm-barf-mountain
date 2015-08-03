//predefine function signatures
script "farm-barf-mountain.ash";
notify Ultibot;

void main();
void meatEquipment();
void maintainBuffs();

void maintainBuffs()
{
	if(have_effect($effect[How to Scam Tourists])==0)
	{
		if(item_amount($item[How to Avoid Scams])>0)
		{
			cli_execute("up How to Scam Tourists");
		}else{
			abort('Please buy from the mall "How to Scam Tourists" and run this script again');
		}
	}

	if(have_effect($effect[Heavy Petting])==0)
	{
		if(item_amount($item[Knob Goblin pet-buffing spray])==0)
		{
			if(dispensary_available())
			{
				cli_execute("buy Knob Goblin pet-buffing spray");
			}else{
				abort("Please buy Knob Goblin pet-buffing spray from the mall, or unlock the dispensary.");
			}
		}
		if(item_amount($item[Knob Goblin pet-buffing spray])>0)
		{
			cli_execute("up Heavy Petting");
		}else{
			abort("Please buy Knob Goblin pet-buffing spray from the mall, or unlock the dispensary.");
		}
	}

	if(have_effect($effect[Wasabi Sinuses])==0)
	{
		if(item_amount($item[Knob Goblin nasal spray])==0)
		{
			if(dispensary_available())
			{
				cli_execute("buy Knob Goblin nasal spray");
			}else{
				abort("Please buy Knob Goblin pet-buffing spray from the mall, or unlock the dispensary.");
			}
		}
		if(item_amount($item[Knob Goblin nasal spray])>0)
		{
			cli_execute("up Wasabi Sinuses");
		}else{
			abort("Please buy Knob Goblin nasal spray from the mall, or unlock the dispensary.");
		}
	}

	if(have_effect($effect[Empathy])==0 || have_effect($effect[Polka of Plenty])==0)
	{
		if(have_effect($effect[Empathy])==0)
		{
			cli_execute("/msg Buffy empathy");
		}
		if(have_effect($effect[Polka of Plenty])==0)
		{
			cli_execute("/msg Buffy plenty");
		}
		print('waiting for Buffy (#1889009) to buff us with empathy and/or plenty','blue');
		wait(30);
	}

	if(have_effect($effect[Empathy])==0 || have_effect($effect[Polka of Plenty])==0)
	{
		abort("Don't have Empathy and/or Plenty, please get a buff bot to buff you then rerun this script.");
	}

	if(have_effect($effect[Leash of Linguini])==0 && have_skill($skill[Leash of Linguini]) )
	{
		print('casting Leash','blue');
		cli_execute("up Leash of Linguini");
	}
	
	if(equipped_item($slot[off-hand])==$item[Half a Purse])
	{
		if(have_effect($effect[Merry Smithsness])==0)
		{
			if(item_amount($item[Flaskfull of Hollow])>0)
			{
				cli_execute("up Merry Smithsness");
			}else{
				abort("please buy Flaskfull of Hollow from the mall");
			}
		}
	}
}

void meatEquipment()
{
	if(have_familiar($familiar[hobo monkey]))
	{
		use_familiar($familiar[hobo monkey]);
		cli_execute("maximize meat, +equip cheap sunglasses -tie");
		
	}else{
		cli_execute("maximize meat, +equip cheap sunglasses, switch Hobo Monkey, switch Grimstone Golem, switch Fist Turkey, switch Golden Monkey, switch Adventurous Spelunker, switch Unconscious Collective, switch Angry Jung Man, switch Leprechaun -tie");
	}	
}


boolean doTasks()
{
	print("maintaining our buffs");
	maintainBuffs();
	return true;
}

boolean mainLoop()
{
	while((my_adventures() > 1) && (my_inebriety() <= inebriety_limit()) && doTasks())
	{
		print("Burning a turn","blue");
		if(my_mp()<100)
		{
			print("Your MP is less than 100, please recharge manually...");
			abort("Your MP is "+to_string(my_mp())+" which is less than 100, aborting...");
		}
		if(have_effect($effect[Beaten Up])>0)
		{
			abort("You are currently beaten up, aborting...");
		}
		boolean retval = adv1($location[Barf Mountain], 1,'');
	}
	return true;	
}


void main()
{
	print("Making sure our pre-adventure and post-adventure settings are empty");
	set_property("afterAdventureScript", "");
	set_property("betweenAdventureScript", "");
	set_property("betweenBattleScript", "");
	print("Setting our combat handler to BarfMountain.ccs, edit the ccs/BarfMountain.ccs file to suit your combat needs");
	cli_execute("ccs BarfMountain");
	set_property("choiceAdventure1073", "1");
	if((my_adventures() > 1) && (my_inebriety() <= inebriety_limit()))
	{
		print("swapping our equipment");
		meatEquipment();
		print("Check if you like your current equipment. Press ESC to abort if you see something wrong","blue");
		print("About to enter the main loop for burning turns at Barf Mountain","blue");
		wait(3);
		mainLoop();
	}else{
		print("either too drunk or no adventures left.","red");
	}
	
}