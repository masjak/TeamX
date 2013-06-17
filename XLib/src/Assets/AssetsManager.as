package Assets
{
	public class AssetsManager
	{
		[Embed(source = "Knight_output.swf", mimeType = "application/octet-stream")]
		public static const KnightData:Class;
		
		[Embed(source = "Cyborg_output.swf", mimeType = "application/octet-stream")]
		public static const CyborgData:Class;
		
		[Embed(source = "../assets/DragonWithClothes.png",mimeType = "application/octet-stream")]
		public static const ResourcesData:Class;
	}
}