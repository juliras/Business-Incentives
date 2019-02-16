using System;
using System.Collections.Generic;

namespace BusinessIncentives.Web.ViewModels
{
	public class AssistanceViewModel
	{
		public string AssistanceID { get; set; }
		public string AssistanceOrigin { get; set; }
		public int FundingLevelID { get; set; }
		public string FundingLevelLabel { get; set; }
		public int? AssistanceTypeID { get; set; }
		public string AssistanceType { get; set; }
		public string Title { get; set; }
		public DateTime? CreationDate { get; set; }
		public DateTime? Deadline { get; set; }
		public DateTime? CloseDate { get; set; }
		public string DescriptionShort { get; set; }
		public string DescriptionLong { get; set; }
		public List<string> Tags { get; set; }
		public string CreationDateLabel { get; internal set; }
		public string CloseDateLabel { get; internal set; }

		public AssistanceViewModel()
		{
			Tags = new List<string>();
		}

	}
}