package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_setofont_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_pangolin_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_bangers_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"aoy4:pathy42:assets%2Fsongs%2FLoveBirds%2Fdialogue.jsony4:sizei1087y4:typey4:TEXTy2:idR1y7:preloadtgoR0y39:assets%2Fsongs%2FLoveBirds%2Fchart.jsonR2i5965R3R4R5R7R6tgoR2i2597675R3y5:MUSICR5y37:assets%2Fsongs%2FLoveBirds%2FInst.oggy9:pathGroupaR9hR6tgoR2i1365958R3R8R5y38:assets%2Fsongs%2FLoveBirds%2FVoice.oggR10aR11hR6tgoR2i2597798R3R8R5y42:assets%2Fsongs%2FLoveBirds%2FLoveBirds.oggR10aR12hR6tgoR0y30:assets%2Fsongs%2FsongList.jsonR2i47R3R4R5R13R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R14R6tgoR0y26:assets%2Fimages%2Ffade.pngR2i494941R3y5:IMAGER5R15R6tgoR0y39:assets%2Fimages%2FblackScreen_holed.pngR2i11470R3R16R5R17R6tgoR0y45:assets%2Fimages%2Fdialogue%2Fdialogue_box.xmlR2i1361R3R4R5R18R6tgoR0y45:assets%2Fimages%2Fdialogue%2Fdialogue_box.pngR2i601852R3R16R5R19R6tgoR0y46:assets%2Fimages%2Fdialogue%2Fbob_portraits.xmlR2i18501R3R4R5R20R6tgoR0y46:assets%2Fimages%2Fdialogue%2Fbob_portraits.pngR2i672558R3R16R5R21R6tgoR0y48:assets%2Fimages%2Fdialogue%2Fbosip_portraits.xmlR2i18947R3R4R5R22R6tgoR0y48:assets%2Fimages%2Fdialogue%2Fbosip_portraits.pngR2i610480R3R16R5R23R6tgoR0y33:assets%2Fimages%2FwhiteScreen.pngR2i5328R3R16R5R24R6tgoR0y31:assets%2Fimages%2FhealthBar.pngR2i307R3R16R5R25R6tgoR0y30:assets%2Fimages%2Falphabet.xmlR2i52093R3R4R5R26R6tgoR0y30:assets%2Fimages%2Falphabet.pngR2i187033R3R16R5R27R6tgoR0y39:assets%2Fimages%2Fbreadcrumb_assets.xmlR2i3442R3R4R5R28R6tgoR0y39:assets%2Fimages%2Fbreadcrumb_assets.pngR2i15352R3R16R5R29R6tgoR0y33:assets%2Fimages%2FblackScreen.pngR2i5328R3R16R5R30R6tgoR0y39:assets%2Fimages%2Fbg%2Fsunset%2Fbg1.pngR2i370147R3R16R5R31R6tgoR0y39:assets%2Fimages%2Fbg%2Fsunset%2Fbg3.pngR2i708399R3R16R5R32R6tgoR0y39:assets%2Fimages%2Fbg%2Fsunset%2Fbg2.pngR2i78309R3R16R5R33R6tgoR0y59:assets%2Fimages%2Fbg%2Fdetailed%20bg%20sketch%20labeled.pngR2i622143R3R16R5R34R6tgoR0y36:assets%2Fimages%2Fbg%2Fday%2Fbg1.pngR2i227901R3R16R5R35R6tgoR0y36:assets%2Fimages%2Fbg%2Fday%2Fbg3.pngR2i628616R3R16R5R36R6tgoR0y36:assets%2Fimages%2Fbg%2Fday%2Fbg2.pngR2i73924R3R16R5R37R6tgoR0y38:assets%2Fimages%2Fbg%2Fnight%2Fbg1.pngR2i259730R3R16R5R38R6tgoR0y38:assets%2Fimages%2Fbg%2Fnight%2Fbg3.pngR2i945138R3R16R5R39R6tgoR0y38:assets%2Fimages%2Fbg%2Fnight%2Fbg2.pngR2i195531R3R16R5R40R6tgoR0y36:assets%2Fimages%2Fscoring%2Fgood.pngR2i11923R3R16R5R41R6tgoR0y36:assets%2Fimages%2Fscoring%2Fshit.pngR2i15319R3R16R5R42R6tgoR0y36:assets%2Fimages%2Fscoring%2Fsick.pngR2i19249R3R16R5R43R6tgoR0y35:assets%2Fimages%2Fscoring%2Fbad.pngR2i11727R3R16R5R44R6tgoR0y42:assets%2Fimages%2Fmenus%2FmenuBGPurple.pngR2i779993R3R16R5R45R6tgoR0y42:assets%2Fimages%2Fmenus%2Fmenu_options.pngR2i27299R3R16R5R46R6tgoR0y42:assets%2Fimages%2Fmenus%2Fmenu_options.xmlR2i1247R3R4R5R47R6tgoR0y36:assets%2Fimages%2Fmenus%2FmenuBG.pngR2i794905R3R16R5R48R6tgoR0y42:assets%2Fimages%2Fmenus%2Fmenu_credits.pngR2i28734R3R16R5R49R6tgoR0y42:assets%2Fimages%2Fmenus%2Fmenu_credits.xmlR2i1300R3R4R5R50R6tgoR0y45:assets%2Fimages%2Fmenus%2Fmenu_story_mode.xmlR2i1323R3R4R5R51R6tgoR0y45:assets%2Fimages%2Fmenus%2Fmenu_story_mode.pngR2i54659R3R16R5R52R6tgoR0y47:assets%2Fimages%2Fmenus%2Fstorymode%2Ftitle.pngR2i23597R3R16R5R53R6tgoR0y48:assets%2Fimages%2Fmenus%2Fstorymode%2Fbanner.pngR2i230083R3R16R5R54R6tgoR0y41:assets%2Fimages%2Fmenus%2FmenuBGDesat.pngR2i440359R3R16R5R55R6tgoR0y43:assets%2Fimages%2Fmenus%2FmenuBGMagenta.pngR2i732400R3R16R5R56R6tgoR0y40:assets%2Fimages%2Fmenus%2FmenuBGBlue.pngR2i772188R3R16R5R57R6tgoR0y43:assets%2Fimages%2Fmenus%2Fmenu_freeplay.pngR2i30316R3R16R5R58R6tgoR0y43:assets%2Fimages%2Fmenus%2Fmenu_freeplay.xmlR2i1302R3R4R5R59R6tgoR0y44:assets%2Fimages%2Fstart%20screen%2Fbench.pngR2i15874R3R16R5R60R6tgoR0y60:assets%2Fimages%2Fstart%20screen%2Fbob_bosip_dance_title.pngR2i2106729R3R16R5R61R6tgoR0y60:assets%2Fimages%2Fstart%20screen%2Fbob_bosip_dance_title.xmlR2i4498R3R4R5R62R6tgoR0y42:assets%2Fimages%2Fstart%20screen%2Fsky.pngR2i10883R3R16R5R63R6tgoR0y49:assets%2Fimages%2Fstart%20screen%2FlogoBumpin.pngR2i1074323R3R16R5R64R6tgoR0y49:assets%2Fimages%2Fstart%20screen%2FlogoBumpin.xmlR2i2178R3R4R5R65R6tgoR0y45:assets%2Fimages%2Fstart%20screen%2Fbushes.pngR2i82642R3R16R5R66R6tgoR0y49:assets%2Fimages%2Fstart%20screen%2FtitleEnter.xmlR2i5044R3R4R5R67R6tgoR0y49:assets%2Fimages%2Fstart%20screen%2FtitleEnter.pngR2i478585R3R16R5R68R6tgoR0y54:assets%2Fimages%2Fdistractions%2Fbasket_ball_alert.pngR2i145167R3R16R5R69R6tgoR0y54:assets%2Fimages%2Fdistractions%2Fbasket_ball_alert.xmlR2i3770R3R4R5R70R6tgoR0y49:assets%2Fimages%2Fdistractions%2Fphone_assets.xmlR2i1647R3R4R5R71R6tgoR0y49:assets%2Fimages%2Fdistractions%2Fphone_assets.pngR2i88744R3R16R5R72R6tgoR0y54:assets%2Fimages%2Fdistractions%2Fbasketball_assets.xmlR2i5778R3R4R5R73R6tgoR0y54:assets%2Fimages%2Fdistractions%2Fbasketball_assets.pngR2i180855R3R16R5R74R6tgoR0y48:assets%2Fimages%2Fdistractions%2Fbird_assets.xmlR2i6132R3R4R5R75R6tgoR0y48:assets%2Fimages%2Fdistractions%2Fbird_assets.pngR2i168388R3R16R5R76R6tgoR0y56:assets%2Fimages%2Fdistractions%2Ftwitter_bird_assets.xmlR2i6484R3R4R5R77R6tgoR0y56:assets%2Fimages%2Fdistractions%2Ftwitter_bird_assets.pngR2i165124R3R16R5R78R6tgoR0y47:assets%2Fimages%2Fcharacters%2Fbosip_assets.xmlR2i26371R3R4R5R79R6tgoR0y47:assets%2Fimages%2Fcharacters%2Fbosip_assets.pngR2i4803729R3R16R5R80R6tgoR0y45:assets%2Fimages%2Fcharacters%2Fbob_assets.xmlR2i22693R3R4R5R81R6tgoR0y45:assets%2Fimages%2Fcharacters%2Fbob_assets.pngR2i4059900R3R16R5R82R6tgoR0y29:assets%2Fimages%2F123%2F4.pngR2i55775R3R16R5R83R6tgoR0y29:assets%2Fimages%2F123%2F2.pngR2i30040R3R16R5R84R6tgoR0y29:assets%2Fimages%2F123%2F3.pngR2i28007R3R16R5R85R6tgoR0y29:assets%2Fimages%2F123%2F1.pngR2i25564R3R16R5R86R6tgoR0y37:assets%2Fimages%2Flovebirds_icons.xmlR2i1293R3R4R5R87R6tgoR0y37:assets%2Fimages%2Flovebirds_icons.pngR2i35502R3R16R5R88R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R89R6tgoR2i100094R3y5:SOUNDR5y26:assets%2Fsounds%2Ftoss.wavR10aR91hR6tgoR2i13399R3R90R5y39:assets%2Fsounds%2F123Go%2Fbosip%2F2.oggR10aR92hR6tgoR2i13406R3R90R5y39:assets%2Fsounds%2F123Go%2Fbosip%2F3.oggR10aR93hR6tgoR2i13467R3R90R5y39:assets%2Fsounds%2F123Go%2Fbosip%2F1.oggR10aR94hR6tgoR2i12592R3R90R5y39:assets%2Fsounds%2F123Go%2Fbosip%2F4.oggR10aR95hR6tgoR2i100094R3R90R5y27:assets%2Fsounds%2Fswoop.wavR10aR96hR6tgoR2i17762R3R8R5y39:assets%2Fsounds%2Fmenu%2FcancelMenu.mp3R10aR97y39:assets%2Fsounds%2Fmenu%2FcancelMenu.ogghR6tgoR2i69071R3R90R5y40:assets%2Fsounds%2Fmenu%2FsecretSound.oggR10aR99y40:assets%2Fsounds%2Fmenu%2FsecretSound.mp3hR6tgoR2i9103R3R90R5y39:assets%2Fsounds%2Fmenu%2FscrollMenu.oggR10aR101y39:assets%2Fsounds%2Fmenu%2FscrollMenu.mp3hR6tgoR2i91950R3R8R5y40:assets%2Fsounds%2Fmenu%2FconfirmMenu.mp3R10aR103y40:assets%2Fsounds%2Fmenu%2FconfirmMenu.ogghR6tgoR2i11419R3R90R5R98R10aR97R98hgoR2i1863817R3R90R5y54:assets%2Fsounds%2Fmenu%2Fneg_bnb_menu_music_maybe_.wavR10aR105hR6tgoR2i17762R3R8R5R102R10aR101R102hgoR2i31599R3R90R5R104R10aR103R104hgoR2i42970R3R8R5R100R10aR99R100hgoR2i100094R3R90R5y28:assets%2Fsounds%2Fcromch.wavR10aR106hR6tgoR2i6531R3R90R5y30:assets%2Fsounds%2Fdialogue.oggR10aR107hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R108R6tgoR2i13053768R3y4:FONTy9:classNamey34:__ASSET__assets_fonts_setofont_ttfR5y29:assets%2Ffonts%2Fsetofont.ttfR6tgoR2i589884R3R109R110y42:__ASSET__assets_fonts_pangolin_regular_ttfR5y37:assets%2Ffonts%2FPangolin-Regular.ttfR6tgoR2i96116R3R109R110y41:__ASSET__assets_fonts_bangers_regular_ttfR5y36:assets%2Ffonts%2FBangers-Regular.ttfR6tgoR0y34:assets%2Fdata%2Fdata-goes-here.txtR2zR3R4R5R117R6tgoR0y43:assets%2Fdata%2Ficons%2Fbob-sleep-icon.jsonR2i797R3R4R5R118R6tgoR0y39:assets%2Fdata%2Ficons%2Fbosip-icon.jsonR2i785R3R4R5R119R6tgoR0y37:assets%2Fdata%2Ficons%2Fbob-icon.jsonR2i797R3R4R5R120R6tgoR0y47:assets%2Fdata%2Fstart%20screen%2FawwCouple.jsonR2i336R3R4R5R121R6tgoR0y48:assets%2Fdata%2Fstart%20screen%2FpressEnter.jsonR2i579R3R4R5R122R6tgoR0y48:assets%2Fdata%2Fstart%20screen%2FlogoBumpin.jsonR2i318R3R4R5R123R6tgoR0y39:assets%2Fdata%2Fcharacters%2Fbosip.jsonR2i2130R3R4R5R124R6tgoR0y46:assets%2Fdata%2Fcharacters%2Ftwitter-bird.jsonR2i1367R3R4R5R125R6tgoR0y38:assets%2Fdata%2Fcharacters%2Fbird.jsonR2i1318R3R4R5R126R6tgoR0y37:assets%2Fdata%2Fcharacters%2Fbob.jsonR2i1336R3R4R5R127R6tgoR2i39706R3R8R5y28:flixel%2Fsounds%2Fflixel.mp3R10aR128y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i8220R3R8R5y26:flixel%2Fsounds%2Fbeep.mp3R10aR130y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i6840R3R90R5R131R10aR130R131hgoR2i33629R3R90R5R129R10aR128R129hgoR2i15744R3R109R110y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R109R110y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i248R3R16R5R136R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i505R3R16R5R137R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_dialogue_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_chart_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_inst_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_voice_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_lovebirds_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_songs_songlist_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_fade_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_blackscreen_holed_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_dialogue_box_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_dialogue_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bob_portraits_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bob_portraits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bosip_portraits_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bosip_portraits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_whitescreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_healthbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_breadcrumb_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_breadcrumb_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_blackscreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_sunset_bg1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_sunset_bg3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_sunset_bg2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_detailed_bg_sketch_labeled_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_day_bg1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_day_bg3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_day_bg2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_night_bg1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_night_bg3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bg_night_bg2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_scoring_good_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_scoring_shit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_scoring_sick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_scoring_bad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgpurple_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_options_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_options_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_credits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_credits_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_story_mode_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_story_mode_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_storymode_title_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_storymode_banner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgdesat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgmagenta_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgblue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_freeplay_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_freeplay_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bench_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bob_bosip_dance_title_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bob_bosip_dance_title_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_sky_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_logobumpin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_logobumpin_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bushes_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_titleenter_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_titleenter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basket_ball_alert_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basket_ball_alert_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_phone_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_phone_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basketball_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basketball_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_bird_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_bird_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_twitter_bird_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_distractions_twitter_bird_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_bosip_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_bosip_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_bob_assets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_characters_bob_assets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_123_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_123_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_123_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_123_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_lovebirds_icons_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_lovebirds_icons_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_toss_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_2_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_3_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_1_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_4_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_swoop_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_cancelmenu_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_secretsound_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_scrollmenu_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_confirmmenu_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_cancelmenu_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_neg_bnb_menu_music_maybe__wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_scrollmenu_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_confirmmenu_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_secretsound_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_cromch_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_dialogue_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_setofont_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_pangolin_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_bangers_regular_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_icons_bob_sleep_icon_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_icons_bosip_icon_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_icons_bob_icon_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_start_screen_awwcouple_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_start_screen_pressenter_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_start_screen_logobumpin_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_characters_bosip_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_characters_twitter_bird_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_characters_bird_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_characters_bob_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/songs/LoveBirds/dialogue.json") @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_dialogue_json extends haxe.io.Bytes {}
@:keep @:file("assets/songs/LoveBirds/chart.json") @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_chart_json extends haxe.io.Bytes {}
@:keep @:file("assets/songs/LoveBirds/Inst.ogg") @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_inst_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/songs/LoveBirds/Voice.ogg") @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_voice_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/songs/LoveBirds/LoveBirds.ogg") @:noCompletion #if display private #end class __ASSET__assets_songs_lovebirds_lovebirds_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/songs/songList.json") @:noCompletion #if display private #end class __ASSET__assets_songs_songlist_json extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/fade.png") @:noCompletion #if display private #end class __ASSET__assets_images_fade_png extends lime.graphics.Image {}
@:keep @:image("assets/images/blackScreen_holed.png") @:noCompletion #if display private #end class __ASSET__assets_images_blackscreen_holed_png extends lime.graphics.Image {}
@:keep @:file("assets/images/dialogue/dialogue_box.xml") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_dialogue_box_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/dialogue/dialogue_box.png") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_dialogue_box_png extends lime.graphics.Image {}
@:keep @:file("assets/images/dialogue/bob_portraits.xml") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bob_portraits_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/dialogue/bob_portraits.png") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bob_portraits_png extends lime.graphics.Image {}
@:keep @:file("assets/images/dialogue/bosip_portraits.xml") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bosip_portraits_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/dialogue/bosip_portraits.png") @:noCompletion #if display private #end class __ASSET__assets_images_dialogue_bosip_portraits_png extends lime.graphics.Image {}
@:keep @:image("assets/images/whiteScreen.png") @:noCompletion #if display private #end class __ASSET__assets_images_whitescreen_png extends lime.graphics.Image {}
@:keep @:image("assets/images/healthBar.png") @:noCompletion #if display private #end class __ASSET__assets_images_healthbar_png extends lime.graphics.Image {}
@:keep @:file("assets/images/alphabet.xml") @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/alphabet.png") @:noCompletion #if display private #end class __ASSET__assets_images_alphabet_png extends lime.graphics.Image {}
@:keep @:file("assets/images/breadcrumb_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_breadcrumb_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/breadcrumb_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_breadcrumb_assets_png extends lime.graphics.Image {}
@:keep @:image("assets/images/blackScreen.png") @:noCompletion #if display private #end class __ASSET__assets_images_blackscreen_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/sunset/bg1.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_sunset_bg1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/sunset/bg3.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_sunset_bg3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/sunset/bg2.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_sunset_bg2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/detailed bg sketch labeled.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_detailed_bg_sketch_labeled_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/day/bg1.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_day_bg1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/day/bg3.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_day_bg3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/day/bg2.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_day_bg2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/night/bg1.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_night_bg1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/night/bg3.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_night_bg3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg/night/bg2.png") @:noCompletion #if display private #end class __ASSET__assets_images_bg_night_bg2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/scoring/good.png") @:noCompletion #if display private #end class __ASSET__assets_images_scoring_good_png extends lime.graphics.Image {}
@:keep @:image("assets/images/scoring/shit.png") @:noCompletion #if display private #end class __ASSET__assets_images_scoring_shit_png extends lime.graphics.Image {}
@:keep @:image("assets/images/scoring/sick.png") @:noCompletion #if display private #end class __ASSET__assets_images_scoring_sick_png extends lime.graphics.Image {}
@:keep @:image("assets/images/scoring/bad.png") @:noCompletion #if display private #end class __ASSET__assets_images_scoring_bad_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/menuBGPurple.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgpurple_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/menu_options.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_options_png extends lime.graphics.Image {}
@:keep @:file("assets/images/menus/menu_options.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_options_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/menus/menuBG.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/menu_credits.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_credits_png extends lime.graphics.Image {}
@:keep @:file("assets/images/menus/menu_credits.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_credits_xml extends haxe.io.Bytes {}
@:keep @:file("assets/images/menus/menu_story_mode.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_story_mode_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/menus/menu_story_mode.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_story_mode_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/storymode/title.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_storymode_title_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/storymode/banner.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_storymode_banner_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/menuBGDesat.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgdesat_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/menuBGMagenta.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgmagenta_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/menuBGBlue.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menubgblue_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menus/menu_freeplay.png") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_freeplay_png extends lime.graphics.Image {}
@:keep @:file("assets/images/menus/menu_freeplay.xml") @:noCompletion #if display private #end class __ASSET__assets_images_menus_menu_freeplay_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/start screen/bench.png") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bench_png extends lime.graphics.Image {}
@:keep @:image("assets/images/start screen/bob_bosip_dance_title.png") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bob_bosip_dance_title_png extends lime.graphics.Image {}
@:keep @:file("assets/images/start screen/bob_bosip_dance_title.xml") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bob_bosip_dance_title_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/start screen/sky.png") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_sky_png extends lime.graphics.Image {}
@:keep @:image("assets/images/start screen/logoBumpin.png") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_logobumpin_png extends lime.graphics.Image {}
@:keep @:file("assets/images/start screen/logoBumpin.xml") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_logobumpin_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/start screen/bushes.png") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_bushes_png extends lime.graphics.Image {}
@:keep @:file("assets/images/start screen/titleEnter.xml") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_titleenter_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/start screen/titleEnter.png") @:noCompletion #if display private #end class __ASSET__assets_images_start_screen_titleenter_png extends lime.graphics.Image {}
@:keep @:image("assets/images/distractions/basket_ball_alert.png") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basket_ball_alert_png extends lime.graphics.Image {}
@:keep @:file("assets/images/distractions/basket_ball_alert.xml") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basket_ball_alert_xml extends haxe.io.Bytes {}
@:keep @:file("assets/images/distractions/phone_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_phone_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/distractions/phone_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_phone_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/images/distractions/basketball_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basketball_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/distractions/basketball_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_basketball_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/images/distractions/bird_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_bird_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/distractions/bird_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_bird_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/images/distractions/twitter_bird_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_twitter_bird_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/distractions/twitter_bird_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_distractions_twitter_bird_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/images/characters/bosip_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_characters_bosip_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/characters/bosip_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_characters_bosip_assets_png extends lime.graphics.Image {}
@:keep @:file("assets/images/characters/bob_assets.xml") @:noCompletion #if display private #end class __ASSET__assets_images_characters_bob_assets_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/characters/bob_assets.png") @:noCompletion #if display private #end class __ASSET__assets_images_characters_bob_assets_png extends lime.graphics.Image {}
@:keep @:image("assets/images/123/4.png") @:noCompletion #if display private #end class __ASSET__assets_images_123_4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/123/2.png") @:noCompletion #if display private #end class __ASSET__assets_images_123_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/123/3.png") @:noCompletion #if display private #end class __ASSET__assets_images_123_3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/123/1.png") @:noCompletion #if display private #end class __ASSET__assets_images_123_1_png extends lime.graphics.Image {}
@:keep @:file("assets/images/lovebirds_icons.xml") @:noCompletion #if display private #end class __ASSET__assets_images_lovebirds_icons_xml extends haxe.io.Bytes {}
@:keep @:image("assets/images/lovebirds_icons.png") @:noCompletion #if display private #end class __ASSET__assets_images_lovebirds_icons_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/toss.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_toss_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/123Go/bosip/2.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_2_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/123Go/bosip/3.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_3_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/123Go/bosip/1.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_1_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/123Go/bosip/4.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_123go_bosip_4_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/swoop.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_swoop_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/cancelMenu.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_cancelmenu_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/secretSound.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_secretsound_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/scrollMenu.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_scrollmenu_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/confirmMenu.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_confirmmenu_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/cancelMenu.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_cancelmenu_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/neg_bnb_menu_music_maybe_.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_neg_bnb_menu_music_maybe__wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/scrollMenu.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_scrollmenu_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/confirmMenu.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_confirmmenu_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/menu/secretSound.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_menu_secretsound_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/cromch.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_cromch_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/dialogue.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_dialogue_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/setofont.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_setofont_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/Pangolin-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_pangolin_regular_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/Bangers-Regular.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_bangers_regular_ttf extends lime.text.Font {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/data/icons/bob-sleep-icon.json") @:noCompletion #if display private #end class __ASSET__assets_data_icons_bob_sleep_icon_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/icons/bosip-icon.json") @:noCompletion #if display private #end class __ASSET__assets_data_icons_bosip_icon_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/icons/bob-icon.json") @:noCompletion #if display private #end class __ASSET__assets_data_icons_bob_icon_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/start screen/awwCouple.json") @:noCompletion #if display private #end class __ASSET__assets_data_start_screen_awwcouple_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/start screen/pressEnter.json") @:noCompletion #if display private #end class __ASSET__assets_data_start_screen_pressenter_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/start screen/logoBumpin.json") @:noCompletion #if display private #end class __ASSET__assets_data_start_screen_logobumpin_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/characters/bosip.json") @:noCompletion #if display private #end class __ASSET__assets_data_characters_bosip_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/characters/twitter-bird.json") @:noCompletion #if display private #end class __ASSET__assets_data_characters_twitter_bird_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/characters/bird.json") @:noCompletion #if display private #end class __ASSET__assets_data_characters_bird_json extends haxe.io.Bytes {}
@:keep @:file("assets/data/characters/bob.json") @:noCompletion #if display private #end class __ASSET__assets_data_characters_bob_json extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/5,5,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/5,5,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/5,5,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/5,5,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/usr/local/lib/haxe/lib/flixel/5,5,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/usr/local/lib/haxe/lib/flixel/5,5,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_setofont_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_setofont_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/setofont"; #else ascender = 880; descender = -144; height = 1024; numGlyphs = 57620; underlinePosition = -120; underlineThickness = 48; unitsPerEM = 1024; #end name = "SetoFont"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_pangolin_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_pangolin_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Pangolin-Regular"; #else ascender = 937; descender = -312; height = 1249; numGlyphs = 874; underlinePosition = -100; underlineThickness = 50; unitsPerEM = 1000; #end name = "Pangolin Regular"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_bangers_regular_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_bangers_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Bangers-Regular"; #else ascender = 883; descender = -181; height = 1064; numGlyphs = 586; underlinePosition = 0; underlineThickness = 0; unitsPerEM = 1000; #end name = "Bangers Regular"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_setofont_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_setofont_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_setofont_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_pangolin_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_pangolin_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_pangolin_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_bangers_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_bangers_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_bangers_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_setofont_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_setofont_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_setofont_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_pangolin_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_pangolin_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_pangolin_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_bangers_regular_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_bangers_regular_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_bangers_regular_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end