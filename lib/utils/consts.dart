class Constants {
  static const String boardTileEntrance = 'Entrance';
  static const String boardTileGarden = 'Garden';
  static const String boardTileRooftop = 'Rooftop';
  static const String boardTileMeetingRoom = 'Meeting Room';
  static const String boardTileCopyRoom = 'Copy Room';
  static const String boardTileArmory = 'Armory';
  static const String boardTileLobby = 'Lobby';
  static const String boardTileRestRoom = 'Rest Room';
  static const String boardTileITRoom = 'IT Room';
  static const String boardTileReception = 'Reception';
  static const String boardTileSecurityRoom = 'Security Room';
  static const String boardTileLogistics = 'Logistics';
  static const String boardTileVault = 'Vault';
  static const String boardTileManagerOffice = 'Manager Office';
  static const String boardTileFirstAidRoom = 'First Aid Room';
  static const String boardTileKitchen = 'Kitchen';
  static const String boardWall = 'Wall';
  static const String boardEmpty = 'Empty';

  static const Map<String, String> cardsText = {
    'Disaster-1': "Disaster Card: Someone clogged the toilets! Player's can't enter the Rest Room for 2 rounds. Use Randomizers to move Guards.",
    'Disaster-2': "Disaster Card: It started to rain! Player's can't enter the Garden for 3 rounds. Players can still exit the room.",
    'Disaster-3': "Disaster Card: Due to a bloody accident, the First Aid Room is out of healing items! Player's can't heal in the room for 2 (extra) rounds.",
    'Disaster-4': "Disaster Card: The Armory is empty! Someone used up all the ammo! Player's cant recharge bullets for 2 (extra) rounds.",
    'Disaster-5': "Disaster Card: The Kitchen is on fire! The room is full of smoke. If a Player enters it in the next 3 rounds, they will lose 1 HP.",
    'Disaster-6': "Disaster Card: A sudden loud noise can be heard from outside! All deactivated Guards lose one round of unconsciousness",
    'Disaster-7': "Disaster Card: Time to reinforce security! Add 1 Guard to the three rooms with the lowers number of Guards.",
    'Disaster-8': "Disaster Card: Printer Explosion! You can't enter the Copy Room for 3 rounds. Use randomizer to move Guards. Lose 1 HP if you are in the room.",
    'Move-1': "Move Card: Nature calls! Move 1 Guard from the Lobby into the Rest Room.",
    'Move-2': "Move Card: Time for a break! The Guards are getting hungry. Move all Guards from adjacent rooms with direct access to the Kitchen, into Kitchen.",
    'Move-3': "Move Card: The manager has some questions! Move one Guard from the Reception into the Manager's office.",
    'Move-4': "Move Card: Break time is over! Time to get back to work! Move 3 Guards from the Kitchen into the Lobby.",
    'Move-5': "Move Card: There is a loud argument at the Reception! Move 1 Guard from the Logistics to the Reception.",
    'Move-6': "Move Card: Some updates need to be implemented! Move all Guards from the Meeting Room into the I.T Room.",
    'Move-7': "Move Card: The meeting starts! Move all Guards from the Lobby into the Meeting Room.",
    'Move-8': "Move Card: Time to do some moving! Move 2 Guards from the Rest Room into Logistics.",
    'Move-9': "Move Card: No calls right now. Time for a short break! Move 3 Guards from the Reception into the Rest Room.",
    'Move-10': "Move Card: The manager leaves early today! Manager's Office can't be entered for 5 rounds. Use randomizer to move Guards.",
    'Move-11': "Move Card: Let's deliver the necessary papers! Move 2 Guards from the Copy Room into Logistics.",
    'Move-12': "Move Card: There are some technical issues at the Lobby. Move 1 Guard from I.T Room into the Lobby.",
    'Reinforcement-1': 'Reinforcement Card: Move 2 Guards from Security Room to the I.T Room.',
    'Reinforcement-2': "Reinforcement Card: Move 2 Guards from Security Room to the Manager's Office.",
    'Reinforcement-3': "Reinforcement Card: Move 2 Guards from Security Room to the Meeting Room.",
    'Reinforcement-4': "Reinforcement Card: Move 2 Guards from Security Room to the Copy Room.",
    'Reinforcement-5': "Reinforcement Card: Move 2 Guards from Security Room to the Rest Room.",
    'Reinforcement-6': "Reinforcement Card: Move 2 Guards from Security Room to the Lobby.",
    'Reinforcement-7': "Reinforcement Card: Move 2 Guards from Security Room to the Kitchen.",
    'Reinforcement-8': "Reinforcement Card: Move 2 Guards from Security Room to the Reception.",
    'Reinforcement-9': "Reinforcement Card: Move 2 Guards from Security Room to the First Aid Room.",
    'Reinforcement-10': "Reinforcement Card: Move 2 Guards from Security Room to the Logistics.",
    'Reinforcement-11': "Reinforcement Card: Move 2 Guards from Security Room to the Armory.",
    'Relief-1': 'Relief Card: It is a pretty calm day! Players have nothing to fear this round. There won\'t be a new guard in Security Room.',
    'Relief-2': 'Relief Card: Time to go home! Remove 5 Guards from the board. Alternate between the rooms with the most Guards.',
    'Skill-1': 'Skill Card: Cheater: Passive: Player holding this card can re-roll 1 dice per round',
    'Skill-2': 'Skill Card: Cleaner: Active: Player holding this card can remove 1 dead body per Action from the room they are in.',
    'Skill-3': 'Skill Card: Convincer: Active: Player holding this card can turn disabled Guards into friendly companions.',
    'Skill-4': 'Skill Card: Doctor: Active: Player holding this card can revive dead teammate for a total of 2 times.',
    'Skill-5': 'Skill Card: Dodger: Active: Player holding this card can evade the Guards without having to throw a dice for a total of 4 times.',
    'Skill-6': 'Skill Card: Expert: Passive: Player holding this card can prevent alarms from spawning reinforcements for a total of 3 times.',
    'Skill-7': 'Skill Card: Fast Hand: Passive: Player holding this card can shoot the first two guards with a dice of 2, third with a 4, and fourth with a 6.',
    'Skill-8': 'Skill Card: Ghost: Passive: Player holding this card can move through a room without being noticed as their first action for a total of 2 times.',
    'Skill-10': 'Skill Card: Lucky Guy: Passive: Player holding this card has to reach 1 less number for every dice than necessary.',
    'Skill-11': 'Skill Card: One Man Army: Passive: Player holding this card can hold 1 extra destructive and 1 extra disruptive bullet.',
    'Skill-12': 'Skill Card: Medic: Active: Player holding this card can heal up to 4HP of themself or of their teammate for a total of 3 times',
    'Skill-13': 'Skill Card: Ninja: Active: Player holding this card can move to the Rooftop from any room during an Action for a total of 3 times.',
    'Skill-14': 'Skill Card: Power Punch: Passive: Player holding this card can disable Guards for 4 rounds when using disruptive bullets,',
    'Skill-15': 'Skill Card: Runner: Passive: Player holding this card has 1 extra Action per turn',
    'Skill-16': 'Skill Card: Scavenger: Active: Player holding this card can search dead bodies. Throw a dice. If you got 6, get 2 bullets of your choice.',
    'Skill-17': 'Skill Card: Silent Killer: Passive: Player holding this card can destroy a guard on arrival to a room for a total of 3 times. Afterwards, enter combat as normal.',
    'Skill-18': 'Skill Card: Tank: Passive: Player holding this card can have 1 extra HP. Active: You can heal yourself once upto 4HP.',
    'Skill-19': 'Skill Card: Technician: Active: Player holding this card can move one Guard from any room to another one for a total of 2 times.',
    'Skill-20': 'Skill Card: Wall Breaker: Active: Player holding this card can break down 2 walls in total.',
  };
}