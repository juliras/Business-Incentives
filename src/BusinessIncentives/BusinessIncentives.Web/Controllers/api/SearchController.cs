using BusinessIncentives.Common;
using BusinessIncentives.Web.Models;
using BusinessIncentives.Web.Repositories;
using BusinessIncentives.Web.ViewModelMappers;
using BusinessIncentives.Web.ViewModels;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace BusinessIncentives.Web.Controllers
{
	public partial class SearchController : ApiController
	{
		[Route("api/search/assistance")]
		[HttpPost]
		public AssistanceResultViewModel Search(SearchModel searchModel)
		{
			// Remove unnecessary keywords
			var keywordCurator = new KeywordCurator();
			var curatedKeywords = keywordCurator.GetCuratedKeywords(searchModel.SplitKeywords);
			
			// Retrieve and filter data
			var opportunityRepo = new OpportunityRepository();
			var programRepo = new ProgramRepository();
			var customOpportunityRepo = new CustomOpportunityRepository();
			var fieldCodedValueRepo = new FieldCodedValueRepository();

			
			// Custom Opportunities
			var customOpportunityQuery = customOpportunityRepo.GetCustomOpportunitiesByKeywords(curatedKeywords); 	// Filter by keywords
			if(searchModel.AssistanceTypesNames.Count > 0) // Then filter by Assistance Type
			{
				// Retrieves the coded field names for Custom Opportunities
				var getFieldCodes = fieldCodedValueRepo.GetFieldCode(CodedFieldOrigin.BusinessIncentives, searchModel.AssistanceTypesNames).ToList();
				if (getFieldCodes != null && getFieldCodes.Count > 0)
				{
					customOpportunityQuery = customOpportunityRepo.GetCustomOpportunitiesByAssistanceType(getFieldCodes, customOpportunityQuery);
				}
			}

			if (!string.IsNullOrEmpty(searchModel.City))
			{
				customOpportunityQuery = customOpportunityQuery.Where(co => co.FundingLevelID > 1
																		 || co.FundingLevelID == 1 && co.FundingLevelDetails.ToLower().Contains(searchModel.City.ToLower()));
			}

			// Opportunities
			var opportunityQuery = opportunityRepo.GetOpportunitiesByKeywords(curatedKeywords); // Filter by keywords
			if (searchModel.AssistanceTypesNames.Count > 0) // Then filter by Assistance Type
			{
				// Retrieves the coded field names for Custom Opportunities
				var getFieldCodes = fieldCodedValueRepo.GetFieldCode(CodedFieldOrigin.GrantsGov, searchModel.AssistanceTypesNames).ToList();
				if(getFieldCodes != null && getFieldCodes.Count > 0)
				{
					opportunityQuery = opportunityRepo.GetOpportunitiesByAssistanceTypeName(getFieldCodes, opportunityQuery);
				}
				else
				{
					opportunityQuery = opportunityRepo.GetOpportunitiesByKeywords(searchModel.AssistanceTypesNames);
				}
			}

			// Programs
			if (searchModel.AssistanceTypesNames.Count > 0)
			{
				curatedKeywords.AddRange(searchModel.AssistanceTypesNames);
			}
			var programs = programRepo.GetProgramsByKeywords(curatedKeywords); // Filter by keywords

			// Create and populate viewmodels to return to the view
			var mapper = new AssistanceViewModelMapper(fieldCodedValueRepo);
			var assistanceResultViewModel = new AssistanceResultViewModel();
			var assistanceViewModels = new List<AssistanceViewModel>();
			assistanceResultViewModel.CustomOpportunities.AddRange(customOpportunityQuery.ToList().Select(co => mapper.GetFromCustomOpportunity(co)));
			assistanceResultViewModel.Opportunities.AddRange(opportunityQuery.ToList().Select(o => mapper.GetFromOpportunity(o)));
			assistanceResultViewModel.Programs.AddRange(programs.Select(p => mapper.GetFromProgram(p)));

			// Add Keywords
			assistanceResultViewModel.CustomOpportunities.ForEach(co => co.Tags = curatedKeywords);

			return assistanceResultViewModel;
		}
	}
}
