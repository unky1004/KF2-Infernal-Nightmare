class KFGameDifficulty_Nightmare extends KFGameDifficulty_Survival;

/** DifficultySettings struct for Nightmare difficulty level */
var(Nightmare) DifficultySettings Nightmare;

/** Great example here on why slaping private on stuff like this is pointless and uneccesary */
var DifficultySettings CurrentSettingsMod;
var float HealthMult, HeadHealthMult;

var KFGameDifficultyInfo OriginalDifficultyInfo;
var KFGameInfo GameOwner;

function SetDifficultySettings( float GameDifficulty )
{
	if( OriginalDifficultyInfo == None )
		OriginalDifficultyInfo = new(GameOwner) GameOwner.DifficultyInfoClass;
		
	if( GameDifficulty >= `DIFFICULTY_NIGHTMARE )
		OriginalDifficultyInfo.SetDifficultySettings(`DIFFICULTY_HELLONEARTH);
	else OriginalDifficultyInfo.SetDifficultySettings(GameDifficulty);
	
	switch ( GameDifficulty )
	{
	 	case `DIFFICULTY_NORMAL:         CurrentSettingsMod = Normal; break;
	 	case `DIFFICULTY_HARD:           CurrentSettingsMod = Hard; break;
	 	case `DIFFICULTY_SUICIDAL:       CurrentSettingsMod = Suicidal; break;
	 	case `DIFFICULTY_HELLONEARTH:    CurrentSettingsMod = HellOnEarth; break;
	 	case `DIFFICULTY_NIGHTMARE:    	 CurrentSettingsMod = Nightmare; break;

	 	default: CurrentSettingsMod = Normal; break;
	}
}

function float GetCharHealthModDifficulty( KFPawn_Monster P, float GameDifficulty )
{
	local float DefValue;
	
	DefValue = OriginalDifficultyInfo.GetCharHealthModDifficulty(P, GameDifficulty == `DIFFICULTY_NIGHTMARE ? `DIFFICULTY_HELLONEARTH : GameDifficulty);
	if( GameDifficulty == `DIFFICULTY_NIGHTMARE )
		DefValue *= HealthMult;
	
	return DefValue;
}

function float GetCharHeadHealthModDifficulty( KFPawn_Monster P, float GameDifficulty )
{
	local float DefValue;
	
	DefValue = OriginalDifficultyInfo.GetCharHeadHealthModDifficulty(P, GameDifficulty == `DIFFICULTY_NIGHTMARE ? `DIFFICULTY_HELLONEARTH : GameDifficulty);
	if( GameDifficulty == `DIFFICULTY_NIGHTMARE )
		DefValue *= HeadHealthMult;
	
	return DefValue;
}

function float GetCharSprintChanceByDifficulty( KFPawn_Monster P, float GameDifficulty )
{
	return OriginalDifficultyInfo.GetCharSprintChanceByDifficulty(P, GameDifficulty == `DIFFICULTY_NIGHTMARE ? `DIFFICULTY_HELLONEARTH : GameDifficulty);
}

function float GetCharSprintWhenDamagedChanceByDifficulty( KFPawn_Monster P, float GameDifficulty )
{
	return OriginalDifficultyInfo.GetCharSprintWhenDamagedChanceByDifficulty(P, GameDifficulty == `DIFFICULTY_NIGHTMARE ? `DIFFICULTY_HELLONEARTH : GameDifficulty);
}

function float GetAIDamageModifier(KFPawn_Monster P, float GameDifficulty, bool bSoloPlay)
{
	local float DefValue;
	
	DefValue = OriginalDifficultyInfo.GetAIDamageModifier(P, GameDifficulty == `DIFFICULTY_NIGHTMARE ? `DIFFICULTY_HELLONEARTH : GameDifficulty, bSoloPlay);
	if( GameDifficulty == `DIFFICULTY_NIGHTMARE )
		DefValue *= 1.32f;
	
	return DefValue;
}

function float GetAISpeedMod(KFPawn_Monster P, float GameDifficulty)
{
	local float DefValue;
	
	DefValue = OriginalDifficultyInfo.GetAISpeedMod(P, GameDifficulty == `DIFFICULTY_NIGHTMARE ? `DIFFICULTY_HELLONEARTH : GameDifficulty);
	if( GameDifficulty == `DIFFICULTY_NIGHTMARE )
		DefValue *= 1.1f;
	
	return DefValue;
}

function float GetGlobalHealthMod()
{
	return CurrentSettingsMod.GlobalHealthMod;
}

function float GetTraderTimeByDifficulty()
{
	return FMax(OriginalDifficultyInfo.GetTraderTimeByDifficulty() * 1, 10.f);
}

function float GetAIGroundSpeedMod()
{
	return CurrentSettingsMod.MovementSpeedMod;
}

function float GetDifficultyMaxAIModifier()
{
	return OriginalDifficultyInfo.GetDifficultyMaxAIModifier() * 1.00;
}

function float GetKillCashModifier()
{
	return CurrentSettingsMod.DoshKillMod;
}

function int GetAdjustedStartingCash()
{
	return CurrentSettingsMod.StartingDosh;
}

function int GetAdjustedRespawnCash()
{
	return CurrentSettingsMod.RespawnDosh;
}

function float GetItemPickupModifier()
{
	return CurrentSettingsMod.ItemPickupsMod;
}

function float GetAmmoPickupModifier()
{
	return CurrentSettingsMod.AmmoPickupsMod;
}

function float GetWeakAttackChance()
{
 	return CurrentSettingsMod.WeakAttackChance;
}

function float GetMediumAttackChance()
{
 	return CurrentSettingsMod.MediumAttackChance;
}

function float GetHardAttackChance()
{
 	return CurrentSettingsMod.HardAttackChance;
}

function float GetSelfInflictedDamageMod()
{
 	return CurrentSettingsMod.SelfInflictedDamageMod;
}

function float GetSpawnRateModifier()
{
	return OriginalDifficultyInfo.GetSpawnRateModifier() * 1;
}

function float GetPlayerNumMaxAIModifier( byte NumLivingPlayers )
{
	return OriginalDifficultyInfo.GetPlayerNumMaxAIModifier(NumLivingPlayers);
}

function float GetDamageResistanceModifier( byte NumLivingPlayers )
{
	return OriginalDifficultyInfo.GetDamageResistanceModifier( NumLivingPlayers );
}

function GetAIHealthModifier(KFPawn_Monster P, float ForGameDifficulty, byte NumLivingPlayers, out float HealthMod, out float HeadHealthMod, optional bool bApplyDifficultyScaling=true)
{
	OriginalDifficultyInfo.GetAIHealthModifier(P, ForGameDifficulty, NumLivingPlayers, HealthMod, HeadHealthMod, bApplyDifficultyScaling);
}

static function float GetDifficultyValue( byte DifficultyIndex )
{
	switch ( DifficultyIndex )
	{
	 	case 0:	return `DIFFICULTY_NORMAL;
	 	case 1:	return `DIFFICULTY_HARD;
	 	case 2:	return `DIFFICULTY_SUICIDAL;
	 	case 3:	return `DIFFICULTY_HELLONEARTH;
	 	case 4:	return `DIFFICULTY_NIGHTMARE;
	 	default: return `DIFFICULTY_NORMAL;
	}
}

static function byte GetDifficultyIndex( float GameDifficulty )
{
 	switch ( GameDifficulty )
	{
	 	case `DIFFICULTY_NORMAL:		return 0;
	 	case `DIFFICULTY_HARD:   		return 1;
	 	case `DIFFICULTY_SUICIDAL:		return 2;
	 	case `DIFFICULTY_HELLONEARTH:	return 3;
	 	case `DIFFICULTY_NIGHTMARE:	return 4;

	 	default: return 99;
	}
}

defaultproperties
{
	HealthMult=1.0
	HeadHealthMult=1.0
	
	Nightmare={(
		TraderTime=60,
		MovementSpeedMod=1.050000,
   		WaveCountMod=1.030000,
   		DoshKillMod=1.670000,
   		StartingDosh=5500,
   		AmmoPickupsMod=1.000000,
   		ItemPickupsMod=0.050000,
   		MediumAttackChance=1.500000,
        HardAttackChance=1.850000,
        SelfInflictedDamageMod=1.00000,
		SpawnRateModifier=0.35)}
}
