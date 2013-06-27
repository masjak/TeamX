package assets
{
	public class AssetsManager
	{
		[Embed(source = "Knight_output.swf", mimeType = "application/octet-stream")]
		public static const KnightData:Class;
		
		[Embed(source = "Cyborg_output.swf", mimeType = "application/octet-stream")]
		public static const CyborgData:Class;
		
		[Embed(source = "DragonWithClothes.png",mimeType = "application/octet-stream")]
		public static const DragonData:Class;
		
		[Embed(source = "Zombie_output.png")]
		public static const ZombieData:Class;
		
		
		
		
	}
}