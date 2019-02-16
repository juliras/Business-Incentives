using BusinessIncentives.Common.Models;
using System.Collections.Generic;
using System.Linq;

namespace BusinessIncentives.Web.Repositories
{
	public interface ICustomOpportunityRepository
	{
		IQueryable<CustomOpportunity> GetAllCustomOpportunities();
		IQueryable<CustomOpportunity> GetCustomOpportunitiesByKeywords(List<string> keywords);
		IQueryable<CustomOpportunity> GetCustomOpportunitiesByAssistanceType(List<string> assistanceTypeNames, IQueryable<CustomOpportunity> previousQuery);
	}
}