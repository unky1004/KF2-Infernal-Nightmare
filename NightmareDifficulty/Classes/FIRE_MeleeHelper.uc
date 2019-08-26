Class FIRE_MeleeHelper extends KFMeleeHelperAI;

simulated function PlayMeleeHitEffects(Actor Target, vector HitLocation, vector HitDirection, optional bool bShakeInstigatorCamera=true)
{
	Super.PlayMeleeHitEffects(Target,HitLocation,HitDirection,bShakeInstigatorCamera);
	if( WorldInfo.NetMode!=NM_Client && KFPawn(Target)!=None && KFPawn(Target).Health>0 && KFPawn(Target).AfflictionHandler!=display )
		KFPawn(Target).AfflictionHandler.AccrueAffliction(AF_FirePanic,4.f);
}

defaultproperties
{
	MyDamageType=Class'KFDT_ZedFire'
}
