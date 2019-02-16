using System.Collections.Generic;
using System.Linq;
using BusinessIncentives.Common.ReferenceData;

namespace BusinessIncentives.Web.ViewModels
{
	public class AssistanceResultViewModel
	{
		public List<AssistanceViewModel> Opportunities { get; set; }
		public List<AssistanceViewModel> Programs { get; set; }
		public List<AssistanceViewModel> CustomOpportunities { get; set; }

		public List<AssistanceViewModel> FederalOpportunities => Opportunities
																	.Union(Programs)
																	.Union(CustomOpportunities.Where(binco => binco.FundingLevelID == (int)FundingLevel.Federal)).ToList();

		public List<AssistanceViewModel> RegionOpportunities => CustomOpportunities.Where(binco => binco.FundingLevelID == (int)FundingLevel.Region).ToList();
		public List<AssistanceViewModel> StateOpportunities => CustomOpportunities.Where(binco => binco.FundingLevelID == (int)FundingLevel.State).ToList();
		public List<AssistanceViewModel> CountyOpportunities => CustomOpportunities.Where(binco => binco.FundingLevelID == (int)FundingLevel.County).ToList();
		public List<AssistanceViewModel> CityOpportunities => CustomOpportunities.Where(binco => binco.FundingLevelID == (int)FundingLevel.City).ToList();

		public int CountOfOpportunities => Opportunities.Count;
		public int CountOfPrograms => Programs.Count;
		public int CountOfCustomOpportunities => CustomOpportunities.Count;
		public int CountOfFederalLevelAssistance => FederalOpportunities.Count();
		public int CountOfRegionLevelAssistance => RegionOpportunities.Count();
		public int CountOfStateLevelAssistance => StateOpportunities.Count();
		public int CountOfCountyLevelAssistance => CountyOpportunities.Count();
		public int CountOfCityLevelAssistance => CityOpportunities.Count();

		public int CountOfAllOpportunities => CountOfOpportunities + CountOfPrograms + CountOfCustomOpportunities;

		public AssistanceResultViewModel()
		{
			Opportunities = new List<AssistanceViewModel>();
			Programs = new List<AssistanceViewModel>();
			CustomOpportunities = new List<AssistanceViewModel>();
		}
	}
}