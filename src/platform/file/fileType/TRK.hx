package platform.file.fileType;

/**
 * ...
 * @author Kaelan Evans
 * 
 * 	little endian
	strings are prefixed with an int16 denoting length, ASCII
	vlength-string strings are length encoded 7 bits at a time, this is because of an oopsie i made in the song info encoding.
	point64 is shorthand for two doubles, x and y. 
	enum LineType
	{
		Scenery=0,
		Blue=1,
		Red = 2,
	}
	CURRENT FEATURE STRINGS:REDMULTIPLIER;SCENERYWIDTH;6.1;SONGINFO;IGNORABLE_TRIGGER;
	MAGIC = TRK\xF2, as a hex int: 0xF24B5254

	[int32:MAGIC]
	[byte:version] // 1
	[string:features]//caps, seperated by semicolons. "REDMULTIPLIER;SONGINFO;SCENERYWIDTH" just for example. Always check every feature is supported before continuing to load. provided for future and backwards compatibility.

	if (feature_songinfo)
	{
		[vlength-string:song_info]//split by \r\n, should only be two strings as a result. one is the name, one is a float32 denoting start offset. data will be something like example.mp3\r\n10.5
	}
	[point64:start point]
	if (feature_6.1)
	{
		//set physics to 6.1 here
	}
	[int32: line count]
	{
		[int8:typeflags]=
		linetype = (typeflags & 0x1F),
		line_inv = (typeflags >> 7) != 0,//only matters if not scenery
		line_limit = (typeflags >> 5) & 0x3;//only matters if not scenery
 
		if (linetype == red)
		{
			if (feature_redmultiplier)
			{
				[int8:multiplier]
			}
		}
		if (linetype == blue || linetype == red)
		{
			if (feature_ignorabletrigger)
			{
				if ([bool:haszoomtrigger])
				{
					[float32:zoomtarget]
					[int16:zoomframes]
				}
			}
			[int32:line ID]
			if (lim != 0)
			{
				[int32:prev line ID]//if no prev line, -1
				[int32:next line ID]//if no next line, -1
			}
		}
		else if (linetype == scenery)
		{
			if (feature_scenerywidth)
			{
				[int8:(width*10)]// divide by 10 to get linewidth. didn't want to store a whole float
			}
		}
		[point64:line point 1]
		[point64:line point 2]
	}
	[EOF]
 */
class TRK extends FileBase 
{

	public function new() 
	{
		super();
	}
	
}