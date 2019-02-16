using BusinessIncentives.Common.Models;
using System;

namespace BusinessIncentives.Web.Models
{
	public class CustomOpportunityModel
	{
		public string Name { get; set; }
		public string Summary { get; set; }
		public short? FundingLevelID { get; set; }
		public int? AssistanceTypeID { get; set; }
		public string FundingLevelDetails { get; set; }
		public DateTime? OpeningDate { get; set; }
		public DateTime? ClosingDate { get; set; }
		public string WebLink { get; set; }
		public string PhoneNumber { get; set; }
		public string Email { get; set; }
		public string EligibilityKeywords { get; set; }
		public string Origin { get; set; }
		public DateTime InsertedDate { get; set; }
		public DateTime UpdatedDate { get; set; }

		public FundingLevel FundingLevel { get; set; }
	}
}
