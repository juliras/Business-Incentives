using System;
using System.Web.Http;
using BusinessIncentives.Common.Models;
using BusinessIncentives.Web.Models;
using BusinessIncentives.Web.Repositories;

namespace BusinessIncentives.Web.Controllers
{
    public partial class CustomOpportunityController : ApiController
    {
        [Route("api/customopportunity")]
        [HttpPost]
        public CreateCustomOpportunityResultModel Submit(CustomOpportunityModel opportunityModel)
        {
            var result = new CreateCustomOpportunityResultModel();
            var repo = new CustomOpportunityRepository();

            CustomOpportunity opportunity = new CustomOpportunity()
            {
                Name = opportunityModel.Name,
                AssistanceTypeID = opportunityModel.AssistanceTypeID,
                FundingLevelID = opportunityModel.FundingLevelID,
                FundingLevelDetails = opportunityModel.FundingLevelDetails,
                Summary = opportunityModel.Summary,
                WebLink = opportunityModel.WebLink,
                Origin = opportunityModel.Origin,
                PhoneNumber = opportunityModel.PhoneNumber,
                Email = opportunityModel.Email,
                EligibilityKeywords = opportunityModel.EligibilityKeywords,
                OpeningDate = opportunityModel.OpeningDate,
                ClosingDate = opportunityModel.ClosingDate
            };

            try
            {
                result.OpportunityID = repo.AddCustomOpportunity(opportunity);
                result.IsSuccess = result.OpportunityID != null;
                result.ErrorCode = result.IsSuccess ? dbError.NO_ERROR : dbError.ENTRY_EXISTS;
            }
            catch(Exception ex)
            {
                result.IsSuccess = false;
                result.ErrorMessage = ex.Message;
                result.ErrorCode = dbError.INVALID_ENTRY;
            }

            return result;
        }
    }

    public enum dbError
    {
        NO_ERROR,
        ENTRY_EXISTS,
        INVALID_ENTRY,
        INCORRECT_FORMAT
    }
}
