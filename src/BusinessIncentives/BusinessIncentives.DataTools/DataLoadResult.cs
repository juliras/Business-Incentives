using System.Collections.Generic;

namespace BusinessIncentives.DataTools
{
	public class DataLoadResult
	{
		public bool? IsSuccess { get; set; }
		public long CountOfRecordsLoaded { get; set; }
		public long CountOfRecordsIgnored { get; set; }
		public long CountOfRecordsInError { get; set; }
		public List<string> ErrorMessages { get; set; }
	}
}