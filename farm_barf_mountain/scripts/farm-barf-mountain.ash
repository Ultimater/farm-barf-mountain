//script info
script "farm-barf-mountain.ash";
notify Ultibot;
import <EatDrink.ash>;
record _FarmBarfMountainSettings_
{
	string version;
	string lastModified;
	boolean eatDrink;
} farmBarfMountainSettings;
farmBarfMountainSettings.version="1.2";
farmBarfMountainSettings.lastModified="Aug 26th 2015";
farmBarfMountainSettings.eatDrink=false;//this is a default which our user_confirm will override later...

//predefine function signatures so we can define our functions in any order
void main();
void meatEquipment();
void maintainBuffs();
void maintainEquipment();
int min(int a,int b,int c);
int min(int a,int b,int c,int d,int e,int f);

//This part is reserved for a later version...
/*
void manageAgenda()
{
	int myAdventuresRemaining=my_adventures();
	int myDrunkness=my_inebriety();
	int myDrunknessLimit=inebriety_limit();
	int puttySheetsMade=get_property("spookyPuttyCopiesMade").to_int();
	int blackBoxesMade=get_property("_raindohCopiesMade").to_int();
	boolean photocopyUsed=get_property('_photocopyUsed').to_boolean();
	boolean camerasUsed=get_property('camerasUsed').to_boolean();
	boolean demonSummoned=get_property('demonSummoned').to_boolean();
	boolean expressCardUsed=get_property('expressCardUsed').to_boolean();
	int feastUsed=get_property('_feastUsed').to_int();
	boolean madTeaParty=get_property('_madTeaParty').to_boolean();
	int poolGames=get_property('_poolGames').to_int();
	boolean concertVisited=get_property('concertVisited').to_boolean();


	if(!madTeaParty)
	{
		item backupHat=equipped_item($slot[hat]);
		equip($item[filthy knitted dread sack]);
		if(have_effect($effect[Down the Rabbit Hole]) == 0)
		{
			if(item_amount($item[&quot;DRINK ME&quot; potion]) == 0)
			{
				buy(1, $item[&quot;DRINK ME&quot; potion]);
			}	
			use(1, $item[&quot;DRINK ME&quot; potion]);
		}
		visit_url("place.php?whichplace=rabbithole&action=rabbithole_teaparty");
		visit_url("choice.php?pwd&whichchoice=441&option=1");
		equip(backupHat);
	}
	int drunknessLeft=max(0,inebriety_limit()-my_inebriety());
	int fullnessLeft=max(0,fullness_limit()-my_fullness());
	int spleenLeft=max(0,spleen_limit()-my_spleen_use());
	if(drunknessLeft>0||fullnessLeft>0||spleenLeft>0)
	{
		eatdrink(fullnessLeft,drunknessLeft,spleenLeft,false,3000,0,0,50000,false);	
	}
}



void embezzlerFights()
{
	cli_execute('faxbot embezzler');//get our embezzler
	int puttySheetsMade=get_property("spookyPuttyCopiesMade").to_int();
	int blackBoxesMade=get_property("_raindohCopiesMade").to_int();
}

*/

//define our functions
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
				abort("Please buy Knob Goblin nasal spray from the mall, or unlock the dispensary.");
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
		boolean waitingForEmpathy=false;
		boolean waitingForPlenty=false;
		if(have_effect($effect[Empathy])==0)
		{
			print('Don\'t have empathy...','blue');
			chat_private("Buffy", "empathy");
			print('waiting for Buffy (#1889009) to buff us with empathy','blue');
			waitingForEmpathy=true;
		}
		if(have_effect($effect[Polka of Plenty])==0)
		{
			print('Don\'t have Plenty...','blue');
			if(waitingForEmpathy)
			{
				print('waiting one second between PMs to Buffy','blue');
				wait(1);
			}
			chat_private("Buffy", "plenty");
			print('waiting for Buffy (#1889009) to buff us with plenty','blue');
			waitingForPlenty=true;
		}
		int loops=0;
		while(waitingForEmpathy||waitingForPlenty)
		{
			if(loops<10){
				wait(1);
			}else{
				wait(10);
			}
			if(have_effect($effect[Empathy])>0){waitingForEmpathy=false;}
			if(have_effect($effect[Polka of Plenty])>0){waitingForPlenty=false;}
			if(waitingForEmpathy&&waitingForPlenty)
			{
				print('Still waiting on plenty and Empathy','blue');
			}else{
				if(waitingForEmpathy){
					print('Still waiting on Empathy','blue');
				}
				if(waitingForPlenty){
					print('Still waiting on Plenty','blue');
				}
			}
			loops=loops+1;
			if(loops>100){break;}
		}
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
	
	if(have_effect($effect[Disco Leer])==0 && have_skill($skill[Disco Leer]) )
	{
		print('casting Disco Leer','blue');
		cli_execute("up Disco Leer");
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


int min(int a,int b,int c)
{
	return min(min(a,b),c);
}
int min(int a,int b,int c,int d,int e,int f)
{
	return min(min(a,b),min(c,d),min(e,f));
}

void burnExtraMP()
{
	boolean burningMPNoticeShown=false;
	void showBurningMPNotice()
	{
		if(!burningMPNoticeShown)
		{
			print("MP is currently "+to_string(my_mp())+"/"+to_string(my_maxmp())+".",'blue');
			print("Burning some MP...",'blue');
			burningMPNoticeShown=true;
		}
	}

//See the following thread for the properties corresponding skill castings:
//http://kolmafia.us/showthread.php?9154-Daily-Activities
	switch(my_mp()>300)
	{
		case true:
		if(have_skill($skill[Summon Smithsness]))
		{
			int smithsnessSummonsUsed=get_property('_smithsnessSummons').to_int();
			if(smithsnessSummonsUsed < 3)
			{
				int smithsnessSummonsLeft= max(3-smithsnessSummonsUsed,0);
				showBurningMPNotice();
				print('casting smithsness '+to_string(smithsnessSummonsLeft)+" time(s)...",'blue');
				try{
					use_skill(smithsnessSummonsLeft, $skill[Summon Smithsness]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Stickers]))
		{
			int stickersSummoned=get_property('_stickerSummons').to_int();
			if(stickersSummoned < 3)
			{
				int stickerSummonsLeft=max(3-stickersSummoned,0);
				showBurningMPNotice();
				print('summoning some stickers '+to_string(stickerSummonsLeft)+" time(s)...",'blue');
				try{
					use_skill(stickerSummonsLeft, $skill[Summon Stickers]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Sugar Sheets]))
		{
			int sugarSheetsSummoned=get_property('_sugarSummons').to_int();
			if(sugarSheetsSummoned < 3)
			{
				int sugarSheetSummonsLeft=max(3-sugarSheetsSummoned,0);
				showBurningMPNotice();
				print('summoning some sugar sheets '+to_string(sugarSheetSummonsLeft)+" time(s)...",'blue');
				try{
					use_skill(sugarSheetSummonsLeft, $skill[Summon Sugar Sheets]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Clip Art]))
		{
			int clipartSummoned=get_property('_clipartSummons').to_int();
			if(clipartSummoned < 3)
			{
				int clipartSummonsLeft=max(3-clipartSummoned,0);
				showBurningMPNotice();
				print('summoning some clip art '+to_string(clipartSummonsLeft)+" time(s)...",'blue');
				try{
					create(clipartSummonsLeft,$item[bucket of wine]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Hilarious Objects]))
		{
			int hilariousObjectsSummoned=get_property('grimoire1Summons').to_int();
			if(hilariousObjectsSummoned < 1)
			{
				showBurningMPNotice();
				print('summoning some hilarious objects...','blue');
				try{
					use_skill(1,$skill[Summon Hilarious Objects]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Tasteful Items]))
		{
			int tastefulItemsSummoned=get_property('grimoire2Summons').to_int();
			if(tastefulItemsSummoned < 1)
			{
				showBurningMPNotice();
				print('summoning some tasteful items...','blue');
				try{
					use_skill(1,$skill[Summon Tasteful Items]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Alice's Army Cards]))
		{
			int aacardsSummoned=get_property('grimoire3Summons').to_int();
			if(aacardsSummoned < 1)
			{
				showBurningMPNotice();
				print('summoning some Alice\'s Army Cards...','blue');
				try{
					use_skill(1,$skill[Summon Alice's Army Cards]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Confiscated Things]))
		{
			int confiscatedThingsSummoned=get_property('_grimoireConfiscatorSummons').to_int();
			if(confiscatedThingsSummoned < 1)
			{
				showBurningMPNotice();
				print('summoning some confiscated things...','blue');
				try{
					use_skill(1,$skill[Summon Confiscated Things]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Summon Geeky Gifts]))
		{
			int geekyGiftsSummoned=get_property('_grimoireGeekySummons').to_int();
			if(geekyGiftsSummoned < 1)
			{
				showBurningMPNotice();
				print('summoning some geeky gifts...','blue');
				try{
					use_skill(1,$skill[Summon Geeky Gifts]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Grab a Cold One]))
		{
			boolean coldOneSummoned=get_property('_coldOne').to_boolean();
			if(!coldOneSummoned)
			{
				showBurningMPNotice();
				print('grabbing a cold one...','blue');
				try{
					use_skill(1,$skill[Grab a Cold One]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Pastamastery]))
		{
			int noodlesSummoned=get_property('noodleSummons').to_int();
			if(noodlesSummoned < 1)
			{
				showBurningMPNotice();
				print('casting pastamastery','blue');
				try{
					use_skill(1,$skill[Pastamastery]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Advanced Saucecrafting]))
		{
			int reagentsSummoned=get_property('reagentSummons').to_int();
			if(reagentsSummoned < 1)
			{
				try{
					if(my_mp()-mp_cost($skill[Advanced Saucecrafting])>=200)
					{
						showBurningMPNotice();
						print('casting advanced saucecrafting','blue');
						use_skill(1,$skill[Advanced Saucecrafting]);
					}
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Advanced Cocktailcrafting]))
		{
			int cocktailsSummoned=get_property('cocktailSummons').to_int();
			if(cocktailsSummoned < 1)
			{
				showBurningMPNotice();
				print('casting advanced cocktailcrafting...','blue');
				try{
					use_skill(1,$skill[Advanced Cocktailcrafting]);
				}finally{}
			}
		}
		if(my_mp()<=200){break;}
		if(have_skill($skill[Rainbow Gravitation]))
		{
			int prismaticWadsSummoned=get_property('prismaticSummons').to_int();
			int prismaticWadSummonsLeft=max(3-prismaticWadsSummoned,0);
			if(prismaticWadSummonsLeft > 0)
			{
				int coldWads=item_amount($item[cold wad]);
				int hotWads=item_amount($item[hot wad]);
				int sleazeWads=item_amount($item[sleaze wad]);
				int spookyWads=item_amount($item[spooky wad]);
				int stenchWads=item_amount($item[stench wad]);
				int twinklyWads=item_amount($item[twinkly wad]);
				int wadsAvailable=min(min(min(coldWads,hotWads),min(sleazeWads,spookyWads)),min(stenchWads,twinklyWads));
				int castsWeCanManage=min(prismaticWadSummonsLeft,wadsAvailable);
				if(mp_cost($skill[Rainbow Gravitation])>0)//Perhaps by some sort of +mp to use skills idk...
				{
					castsWeCanManage=min(castsWeCanManage,floor(max(my_mp()-200,0)/max(mp_cost($skill[Rainbow Gravitation]),1)));
				}
				try{
					if(castsWeCanManage>1)
					{
						showBurningMPNotice();
						print('making '+to_string(castsWeCanManage)+' prismatic wad(s)','blue');
						use_skill(castsWeCanManage,$skill[Rainbow Gravitation]);
					}
				}finally{}
			}
		}


	}//switch
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

void maintainEquipment()
{
	boolean checkForBetterEquipment=false;
	if(equipped_item($slot[familiar])==$item[Snow Suit])
	{
		float snowsuitCombats=get_property("_snowSuitCount").to_int();
		int snowsuitFamilarWeightReduction=snowsuitCombats/5;
		if(snowsuitFamilarWeightReduction>15){snowsuitFamilarWeightReduction=5;}
		int snowsuitFamilarWeightBonus=20-snowsuitFamilarWeightReduction;
		print("Currently have Snow suit equipped giving us +"+to_string(snowsuitFamilarWeightBonus)+" to familar weight. We have completed "+to_string(to_int(snowsuitCombats))+" combats with it",'blue');
		if(snowsuitCombats > 50) //check to maximize every 5 turns after we're at +10 familiar weight
		{
			if(snowsuitCombats % 5 == 0)
			{
				print("Snow suit is now at +"+to_string(snowsuitFamilarWeightBonus)+" familiar weight. checking for better equipment",'blue');
				checkForBetterEquipment=true;
			}
		}
	}
	if(equipped_item($slot[familiar])==$item[none])
	{
		print("Our familiar equipment slot is empty. Checking for better equipment",'blue');
		checkForBetterEquipment=true;
	}
	if(checkForBetterEquipment){
		meatEquipment();
	}
	if(equipped_item($slot[familiar])==$item[none])
	{
		print("Our familiar equipment slot is still empty. Aborting....",'red');
		abort("Familar equipment slot is empty, please fix this manually.");
	}
		
}

void fillStomachLiverSpleen()
{
	int drunknessLeft=max(0,inebriety_limit()-my_inebriety());
	int fullnessLeft=max(0,fullness_limit()-my_fullness());
	int spleenLeft=max(0,spleen_limit()-my_spleen_use());
	if(drunknessLeft>0||fullnessLeft>0||spleenLeft>0)
	{
		eatdrink(fullness_limit(),inebriety_limit(),spleen_limit(),false,3000,0,0,50000,false);	
	}
}

boolean doTasks()
{
	print("maintaining our buffs",'blue');
	maintainBuffs();
	maintainEquipment();
	if(farmBarfMountainSettings.eatDrink)
	{
		fillStomachLiverSpleen();
	}
	return true;
}

boolean mainLoop()
{
	while((my_adventures() > 1) && (my_inebriety() <= inebriety_limit()) && doTasks())
	{
		if(my_mp()>300)
		{
			burnExtraMP();
		}
		print("Burning a turn","blue");
		if(my_mp()<100)
		{

			print("Your MP is less than 100, please recharge manually...",'red');
			abort("Your MP is "+to_string(my_mp())+"/"+to_string(my_maxmp())+" which is less than 100, aborting...");
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
	string welcomeText="Welcome to Ultibot's farm-barf-mountain.ash v"+farmBarfMountainSettings.version+" ("+farmBarfMountainSettings.lastModified+")";
	print(welcomeText,'green');
	print('Checking if you have the latest version....');
	string latestVersion=visit_url('https://raw.githubusercontent.com/Ultimater/farm-barf-mountain/master/version.txt');
	if(latestVersion==farmBarfMountainSettings.version)
	{
		print('Good, you are running the latest version.','green');
	}else{
		print('Latest version is: '+latestVersion,'orange');
		float yourVersionNumber=to_float(farmBarfMountainSettings.version);
		float latestVersionNumber=to_float(latestVersion);
		if(latestVersionNumber<=0)
		{
			print('Could not convert latest version to a number... skipping script updater...','red');
		}else if(yourVersionNumber<=0){
			print('Could not convert your script version to a number, skipping script updater...','red');
		}else if(yourVersionNumber>latestVersionNumber){
			print('You are running a script version newer than the latest version, skipping script updater...','green');
		}else if(yourVersionNumber<latestVersionNumber){
			print('You are NOT running the latest version of this script.','red');
			if(user_confirm('You are NOT running the latest version of this farm-barf-mountain.ash.\n\nWould you like the script to update itself now?'))
			{
				print('Preparing to update to the latest farm-barf-mountain.ash......','blue');
				cli_execute('svn delete Ultimater-farm-barf-mountain-branches-master-farm_barf_mountain');
				cli_execute('svn checkout https://github.com/Ultimater/farm-barf-mountain/branches/master/farm_barf_mountain');
				print('Update Complete!','green');
				print('Please re-run farm-barf-mountain.ash','#8f00ff');
				exit;
			}else{
				print('Continuing to run your old version of the script... you can always update manually.','orange');
			}
		}
	}
	if(user_confirm(welcomeText+"\n\nWould you like farm-barf-mountain.ash to utilize EatDrink.ash to manage your stomach, liver, and spleen for you?"))
	{
		farmBarfMountainSettings.eatDrink=true;
	}else{
		farmBarfMountainSettings.eatDrink=false;
	}
	if(farmBarfMountainSettings.eatDrink)
	{
		print("As requested, we will be using EatDrink.ash to fill your stomach,liver, and spleen...",'#8f00ff');
	}else{
		print("As requested, we will allow you to manage your own stomach,liver, and spleen...",'#8f00ff');
	}
	print("Making sure our pre-adventure and post-adventure settings are empty",'blue');
	set_property("afterAdventureScript", "");
	set_property("betweenAdventureScript", "");
	set_property("betweenBattleScript", "");
	print("Setting our combat handler to BarfMountain.ccs, edit the ccs/BarfMountain.ccs file to suit your combat needs",'blue');
	cli_execute("ccs BarfMountain");
	set_property("choiceAdventure1073", "1");
	if((my_adventures() > 1) && (my_inebriety() <= inebriety_limit()))
	{
		print("swapping our equipment",'blue');
		meatEquipment();
		print("Check if you like your current equipment. Press ESC to abort if you see something wrong","blue");
		print("About to enter the main loop for burning turns at Barf Mountain","blue");
		wait(3);
		mainLoop();
	}else{
		print("either too drunk or no adventures left.","red");
	}
	
}//end main()