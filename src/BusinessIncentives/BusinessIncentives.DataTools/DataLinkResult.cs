using System.Collections.Generic;

namespace BusinessIncentives.DataTools
{
	public class DataLinkResult
	{
		public bool? IsSuccess { get; set; }
		public long CountOfRecordsLinked { get; set; }
		public List<string> ErrorMessages { get; set; }
	}
}