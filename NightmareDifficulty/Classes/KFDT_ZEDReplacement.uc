class KFDT_ZEDReplacement extends KFDamageType
	abstract
	hidedropdown;

defaultproperties
{
	bNoPain=true
	bCanGib=false
	bCanObliterate=true
	bShouldSpawnBloodSplat=false
	bShouldSpawnPersistentBlood=false

	KnockdownPower=1
	StumblePower=1
	MaxObliterationGibs=1

	ObliterationHealthThreshold=0
	ObliterationDamageThreshold=1	
}
