--music.lua
local F = {}
audio.reserveChannels( 6 )
local total = audio.totalChannels
local fishSound
local carSound
local pullUpSFX
local hyperAttack1
local hyperAttack2
local hyperAttack3
local hyperAttack4
local hyperAttack5
local hyperAttack6
-----------------
local hyperReload1
local hyperReload2
local hyperReload3
local hyperReload4
local hyperReload5
local hyperReload6
local levelprog1SFX
local dialog1SFX
local dialog2SFX
local pauseCallSFX
local healthIncSFX
local unpauseCallSFX
local playerHitSFX1
local playerChargeSFX1
local expUp
local moneyPickUp
local levelClearSFX
local levelCompleteSFX
local playerDiedSFX
local incorrect1
local select1
local shot2
local fire2
local inventSound = false
F.gameplay1MusicSound = {}
F.gameplay2MusicSound = {}
F.gameplay3MusicSound = {}
F.titleMusicSound = {}
F.menuMusicSound = {}

local function vibeHitOn()
	if SavedGameOneSettings.VibeOn == true then
		system.vibrate()
	elseif SavedGameOneSettings.VibeOn == false then
		return false
	end
end

local function titleMusic()
	if SavedGameOneSettings.MusicOn == false then
		return true
	else
titleMusicChannel = audio.play( F.titleMusicSound, { channel=1, loops=-1 }  )  
end
end

local function menuMusic()
	if SavedGameOneSettings.MusicOn == false then
		return true
	else
menuMusicChannel = audio.play( F.menuMusicSound, { channel=5, loops=-1}  )  
end
end

function F.gameplay1Music()
	if SavedGameOneSettings.MusicOn == false then
		return true
	else
gameplay1MusicChannel = audio.play( F.gameplay1MusicSound, { channel=2, loops=-1}  )  
end
end

local function loadAllMusic()
F.titleMusicSound = audio.loadSound("media/music/planetrise.mp3")
F.gameplay1MusicSound = audio.loadStream("media/music/brokenreality.mp3")
--F.gameplay2MusicSound = audio.loadStream("media/music/steelrods.mp3")
end

local function removeAllMusic()
audio.dispose(F.titleMusicSound)
audio.dispose(F.gameplay1MusicSound) 
audio.dispose(F.gameplay2MusicSound) 
end

local function removeTitleMusic()
audio.dispose(titleMusic)
end
local function removeMenuMusic()
audio.dispose(menuMusic)
end
local function removeGameplay1Music()
audio.dispose(gameplay1Music) 
end
local function removeGameplay2Music()
audio.dispose(gameplay2Music)
end
local function removeGameplay3Music()
audio.dispose(gameplay3Music)
end
local function loadPoisonSound()
pullUpSFX = audio.loadSound("media/sfx/vending4.wav")
end

local function loadCar1HitSound()
carSound = audio.loadSound("media/sfx/carhorn2.wav")
end

local function loadBoughtItem1Sound()
boughtItem1 = audio.loadSound("media/sfx/purchase7.wav")
end

local function boughtItem1Sound()
boughtItem1SoundChannel = audio.play( boughtItem1 )  
vibeHitOn()
end

local function loadGlockReload1Sound()
hyperReload1 = audio.loadSound("media/sfx/glockreload.mp3")
end

local function loadShotgunReload1Sound()
hyperReload2 = audio.loadSound("media/sfx/shotgunreload.mp3")
end

local function loadMachinegunReload1Sound()
hyperReload3 = audio.loadSound("media/sfx/machinegunreload.mp3")
end

local function loadSniperReload1Sound()
hyperReload4 = audio.loadSound("media/sfx/sniperreload.mp3")
end

local function loadGrenadeLauncherReload1Sound()
hyperReload5 = audio.loadSound("media/sfx/grenadereload.mp3")
end

local function loadRocketReload1Sound()
hyperReload6 = audio.loadSound("media/sfx/rocketreload1a.mp3")
end

local function loadGlockAttack1Sound()
hyperAttack1 = audio.loadSound("media/sfx/glockshot.mp3")
end

local function loadShotgunAttack1Sound()
hyperAttack2 = audio.loadSound("media/sfx/shotgunshot.mp3")
end

local function loadMachinegunAttack1Sound()
hyperAttack3 = audio.loadSound("media/sfx/machinegunshot1a.mp3")
end

local function loadSniperAttack1Sound()
hyperAttack4 = audio.loadSound("media/sfx/glockshot1a.mp3")
end

local function loadGrenadeLauncherAttack1Sound()
hyperAttack5 = audio.loadSound("media/sfx/grenadeshot.mp3")
end

local function loadRocketAttack1Sound()
hyperAttack6 = audio.loadSound("media/sfx/rocketshot1a.mp3")
end

local function loadlevelprog1Sound()
levelprog1SFX = audio.loadSound("media/sfx/levelprog2.wav")
end

local function loadDialog1Sound()
dialog1SFX = audio.loadSound("media/sfx/male2.wav")
end

local function loadDialog2Sound()
dialog2SFX = audio.loadSound("media/sfx/male6.wav")
end

local function loadPause2Sound()
pauseCallSFX = audio.loadSound("media/sfx/pause2.wav")
end

local function loadHealthIncSound()
healthIncSFX = audio.loadSound("media/sfx/healthin3.wav")
end

local function loadUnpauseCall2Sound()
unpauseCallSFX = audio.loadSound("media/sfx/pause3.wav")
end

local function loadMineProxSound()
mineSFX1 = audio.loadSound("media/sfx/minecount.mp3")
end

local function loadPlayer1ChargeSound()
playerChargeSFX1 = audio.loadSound("media/sfx/chargehit7.wav")
end

local function loadExpUpSound()
expUp = audio.loadSound("media/sfx/expin4.wav")
end

local function loadMoneyPickUpSound()
moneyPickUp = audio.loadSound("media/sfx/money13.wav")
end

local function loadLevelClearSound()
levelClearSFX = audio.loadSound("media/sfx/success13.mp3")
end

local function loadLevelCompletedSound()
levelCompleteSFX = audio.loadSound("media/sfx/levelcomplete3.mp3")
end

local function loadplayerDiedSound()
playerDiedSFX = audio.loadSound("media/sfx/gameover.mp3")
end

local function loadIncorrect1Sound()
incorrect1 = audio.loadSound("media/sfx/incorrect2.wav")
end

local function loadSelect1Sound()
select1 = audio.loadSound("media/sfx/select2d.mp3")
end

local function loadShot2Sound()
shot2 = audio.loadSound("media/sfx/shot2.wav")
end

local function loadexplosionSound()
explosionSound = audio.loadSound("media/sfx/explosion1a.mp3")
end

function F.explosionSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
explosionSoundChannel = audio.play( explosionSound )  

	end
end

local function loadrachetSound()
rachetSound = audio.loadSound("media/sfx/ratchet1a.mp3")
end

function F.rachetSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
rachetSoundChannel = audio.play( rachetSound )  

	end
end

function F.rachetInventSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
		if inventSound == false then
			rachetSoundChannel = audio.play( rachetSound ) 
			inventSound = true
			timer.performWithDelay(85, function()
				inventSound = false
			end, 1)
		end
 
	end
end

local function loadplayerSuitupSound()
playerSuitupSound = audio.loadSound("media/sfx/suitup.mp3")
end

function F.playerSuitupSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
playerSuitupSoundChannel = audio.play( playerSuitupSound )  
vibeHitOn()
	end
end

local function loadplayerHurtSound()
playerHurtSound = audio.loadSound("media/sfx/hurt1a.mp3")
end

function F.playerHurtSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
playerHurtSoundChannel = audio.play( playerHurtSound )  
vibeHitOn()
	end
end

local function loadjumpSoundSound()
jumpSoundSound = audio.loadSound("media/sfx/land1c.mp3")
end

function F.jumpSoundSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
jumpSoundSoundChannel = audio.play( jumpSoundSound )  
vibeHitOn()
	end
end

local function loadenemyProxSound()
enemyProxSound = audio.loadSound("media/sfx/enemyprox1a.mp3")
end

function F.enemyProxSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
enemyProxSoundChannel = audio.play( enemyProxSound )  
vibeHitOn()
	end
end

local function loadenemySonarSound()
enemySonarSound = audio.loadSound("media/sfx/enemysonar2a.mp3")
end

function F.enemySonarSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
enemySonarSoundChannel = audio.play( enemySonarSound )  
vibeHitOn()
	end
end

local function loadenemyAttSound()
enemyAttSound = audio.loadSound("media/sfx/enemyshot.mp3")
end

function F.enemyAttSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
enemyAttSoundChannel = audio.play( enemyAttSound )  
vibeHitOn()
	end
end

function F.enemyFirePlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
enemyFireSoundChannel = audio.play( hyperAttack1 )  
vibeHitOn()
	end
end

function F.enemyGrenPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
enemyFireSoundChannel = audio.play( hyperAttack5 )  
vibeHitOn()
	end
end

local function loadCollectSound()
collectSound = audio.loadSound("media/sfx/emptyfire1b.mp3")
end

function F.collectSoundPlay()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
unholserSoundChannel = audio.play( collectSound )  
vibeHitOn()
	end
end

local function loadUnholsterSound()
unholserSound = audio.loadSound("media/sfx/unholster.mp3")
end

function F.unholsterSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
unholserSoundChannel = audio.play( unholserSound )  
vibeHitOn()
	end
end

function F.mine1Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
mineSoundChannel = audio.play( mineSFX1 )  
vibeHitOn()
	end
end

local function dialog1Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
dialog1SoundChannel = audio.play( dialog1SFX )  
vibeHitOn()
	end
end

local function loadFire2Sound()
fire2 = audio.loadSound("media/sfx/fire3.wav")
end

local function fire2Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
fire2SoundChannel = audio.play( fire2 )  
end
end

local function enemy1HitSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
fishSoundChannel = audio.play( fishSound )  
vibeHitOn()
end
end

local function car1HitSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
carSoundChannel = audio.play( carSound )  
vibeHitOn()
end
end

local function dialog2Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
dialog2SoundChannel = audio.play( dialog2SFX )  
vibeHitOn()
end
end

local function pauseCallSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
pauseCallSoundChannel = audio.play( pauseCallSFX )  
vibeHitOn()
end
end

local function pullUpSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
pullUpSoundChannel = audio.play( pullUpSFX )  
vibeHitOn()
end
end

local function healthIncSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
healthIncSoundChannel = audio.play( healthIncSFX )  
end
end

local function unpauseCallSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
unpauseCallSoundChannel = audio.play( unpauseCallSFX )  
vibeHitOn()
end
end

function F.gunSound1()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
		if SavedGameOneSettings.mainWeapon == "glock" then 
			local playerHitSound1Channel = audio.play( hyperAttack1 )
		end
		if SavedGameOneSettings.mainWeapon == "shotgun" then 
			local playerHitSound1Channel = audio.play( hyperAttack2 )
		end
		if SavedGameOneSettings.mainWeapon == "machinegun" then 
			local playerHitSound1Channel = audio.play( hyperAttack3 )
		end
		if SavedGameOneSettings.mainWeapon == "sniper" then 
			local playerHitSound1Channel = audio.play( hyperAttack4 )
		end
		if SavedGameOneSettings.mainWeapon == "grenadelauncher" then 
			local playerHitSound1Channel = audio.play( hyperAttack5 )
		end
		if SavedGameOneSettings.mainWeapon == "rocket" then 
			local playerHitSound1Channel = audio.play( hyperAttack6 )
		end
	vibeHitOn()
	end
end

function F.reloadSound1()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
		if SavedGameOneSettings.mainWeapon == "glock" then 
			local playerHitSound1Channel = audio.play( hyperReload1 )
		end
		if SavedGameOneSettings.mainWeapon == "shotgun" then 
			local playerHitSound1Channel = audio.play( hyperReload2 )
		end
		if SavedGameOneSettings.mainWeapon == "machinegun" then 
			local playerHitSound1Channel = audio.play( hyperReload3 )
		end
		if SavedGameOneSettings.mainWeapon == "sniper" then 
			local playerHitSound1Channel = audio.play( hyperReload4 )
		end
		if SavedGameOneSettings.mainWeapon == "grenadelauncher" then 
			local playerHitSound1Channel = audio.play( hyperReload5 )
		end
		if SavedGameOneSettings.mainWeapon == "rocket" then 
			local playerHitSound1Channel = audio.play( hyperReload6 )
		end
	vibeHitOn()
	end
end

local function expUpSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
expUpSoundChannel = audio.play( expUp )  
vibeHitOn()
end
end

local function moneyPickUpSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
moneyPickUpSoundChannel = audio.play( moneyPickUp )  
vibeHitOn()
end
end

local function levelClearSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
levelClearedSoundChannel = audio.play( levelClearSFX )  
end
end

local function levelCompleteSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
levelCompleteSoundChannel = audio.play( levelCompleteSFX )  
end
end

local function playerDiedSound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
playerDiedSoundChannel = audio.play( playerDiedSFX )  
end
end

local function incorrect1Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
		incorrect1SoundChannel = audio.play(  incorrect1 )  
	end
end

local function select1Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
select1SoundChannel = audio.play(  select1 )  
end
end

local function shot2Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
		shot2SoundChannel = audio.play(  shot2 )  
	end
end

local function hyperAttack1Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
hyperAttack1Channel = audio.play( hyperAttack1 )  
vibeHitOn()
end
end

local function levelprog1Sound()
	if SavedGameOneSettings.SoundOn == false then
		return true
	else
levelprog1SoundChannel = audio.play( levelprog1SFX )  
end
end

local function loadAllSFX()
loadMineProxSound()
loadGlockAttack1Sound()
loadShotgunAttack1Sound()
loadMachinegunAttack1Sound()
loadSniperAttack1Sound()
loadGrenadeLauncherAttack1Sound()
loadRocketAttack1Sound()
loadGlockReload1Sound()
loadShotgunReload1Sound()
loadMachinegunReload1Sound()
loadSniperReload1Sound()
loadGrenadeLauncherReload1Sound()
loadHealthIncSound()
loadRocketReload1Sound()
loadPoisonSound()
loadUnholsterSound()
loadExpUpSound()
loadIncorrect1Sound()
loadLevelClearSound()
loadenemySonarSound()
loadplayerSuitupSound()
loadenemyAttSound()
loadplayerHurtSound()
loadenemyProxSound()
loadjumpSoundSound()
loadCollectSound()
loadexplosionSound()
loadMoneyPickUpSound()
loadrachetSound()
loadSelect1Sound()
end
local function removeAllSFX()
audio.dispose(dialog1SFX)
audio.dispose(dloadDialog2SFX)
audio.dispose(loadPause2SFX)
audio.dispose(loadPauseCall2SFX)
audio.dispose(loadHealthIncSFX)
audio.dispose(loadUnpauseCall2SFX)
audio.dispose(loadPlayer1HitSFX)
audio.dispose(loadLevelArrowTouch)
audio.dispose(loadLevelUpSFX)
audio.dispose(loadExpUpSFX)
audio.dispose(loadMoneyPickUpSFX)
audio.dispose(loadLevelClearSFX)
audio.dispose(loadBoughtItem1SFX)
audio.dispose(loadIncorrect1SFX)
audio.dispose(loadUnholsterSound)
end

local function turnOffEffects()
for i=1, 25 do
if SavedGameOneSettings.SoundOn == false then
audio.setVolume( 0, { channel=6+(i*1) } )
		end
	end
end

local function turnOnEffects()
for i=1, 25 do
if SavedGameOneSettings.SoundOn == true then
audio.setVolume( .5, { channel=6+(i*1) } )
		end
	end
end

local function turnOffMusic()
for i=1, 6 do
if SavedGameOneSettings.MusicOn == false then
audio.setVolume( 0, { channel=0+(i*1) } )
		end
	end
end

local function turnOnMusic()
for i=1, 6 do
if SavedGameOneSettings.MusicOn == true then
audio.setVolume( .2, { channel=0+(i*1) } )
		end
	end
end


F.titleMusic = titleMusic
F.gameplay2Music = gameplay2Music
F.gameplay3Music = gameplay3Music
F.pauseMusic = pauseMusic
F.winMusic = winMusic
F.menuMusic = menuMusic
F.enemy1HitSound = enemy1HitSound
F.hyperAttack1Sound = hyperAttack1Sound
F.pickupSound = pickupSound
F.stunSound = stunSound
F.playerHitSound1 = playerHitSound1
F.playerChargeSound1 = playerChargeSound1
F.knockSound = knockSound
F.healthIncSound = healthIncSound
F.burnSound = burnSound
F.levelprog1Sound = levelprog1Sound
F.pullUpSound = pullUpSound
F.pauseCallSound = pauseCallSound
F.unpauseCallSound = unpauseCallSound
F.expUpSound = expUpSound
F.levelClearSound = levelClearSound
F.levelCompleteSound = levelCompleteSound
F.playerDiedSound = playerDiedSound
F.select1Sound = select1Sound
F.shot2Sound = shot2Sound
F.fire2Sound = fire2Sound
F.car1HitSound = car1HitSound
F.boughtItem1Sound = boughtItem1Sound
F.moneyPickUpSound = moneyPickUpSound
F.movement1Sound = movement1Sound
F.dialog1Sound = dialog1Sound
F.dialog2Sound = dialog2Sound
F.incorrect1Sound = incorrect1Sound
F.turnOffEffects = turnOffEffects
F.turnOffMusic = turnOffMusic
F.turnOnEffects = turnOnEffects
F.turnOnMusic = turnOnMusic
F.loadAllMusic = loadAllMusic
F.removeAllMusic = removeAllMusic
F.removeTitleMusic = removeTitleMusic
F.removeMenuMusic = removeMenuMusic
F.removeGameplay1Music = removeGameplay1Music
F.removeGameplay2Music = removeGameplay2Music
F.loadAllSFX = loadAllSFX
F.removeAllSFX = removeAllSFX
F.loadDialog1Sound = loadDialog1Sound

return F