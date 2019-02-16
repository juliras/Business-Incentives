using System.Collections.Generic;
using System.Linq;

namespace BusinessIncentives.Web.Models
{
	public class SearchModel
	{
		public string Keywords { get; set; }
		public List<string> SplitKeywords => Keywords?.Split(' ').ToList();
		public List<string> AssistanceTypesNames { get; set; }
		public string City { get; set; }
		public string ZipCode { get; set; }
		public string State { get; set; }
	}
}
