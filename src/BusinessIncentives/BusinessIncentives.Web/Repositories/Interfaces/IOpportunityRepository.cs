using BusinessIncentives.Common.Models;
using System.Collections.Generic;
using System.Linq;

namespace BusinessIncentives.Web.Repositories
{
	public interface IOpportunityRepository
	{
		IQueryable<Opportunity> GetAllOpportunities();
		IQueryable<Opportunity> GetOpportunitiesByKeywords(List<string> keywords);
		IQueryable<Opportunity> GetOpportunitiesByAssistanceTypeName(List<string> assistanceTypeNames, IQueryable<Opportunity> previousQuery);
	}
}