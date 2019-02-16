using System;
using System.Collections.Generic;
using System.Linq;
using BusinessIncentives.Common.Models;

namespace BusinessIncentives.Web.Repositories
{
	public class OpportunityRepository : IOpportunityRepository, IDisposable
	{
		private BusinessIncentivesContext _context;

		public OpportunityRepository()
		{
			_context = new BusinessIncentivesContext();
		}

		public IQueryable<Opportunity> GetAllOpportunities()
		{
			return _context.Opportunities.Take(300).AsQueryable();
		}

		public IQueryable<Opportunity> GetOpportunitiesByKeywords(List<string> keywords)
		{
			if (keywords == null || keywords.Count == 0)
			{
				return GetAllOpportunities();
			}
			else
			{
				var opportunities = GetAllOpportunities();
				var result = opportunities.Where(o => keywords.Any(kw => o.Description.Contains(kw) || o.AdditionalInformationOnEligibility.Contains(kw)));
				return result;
			}
		}

		public IQueryable<Opportunity> GetOpportunitiesByAssistanceTypeName(List<string> codes, IQueryable<Opportunity> previousQuery)
		{
			IQueryable<Opportunity> opportunities = null;
			if (previousQuery != null)
			{
				opportunities = previousQuery.Where(o => codes.Contains(o.FundingInstrumentType));
			}
			else
			{
				opportunities = GetAllOpportunities().Where(o => codes.Contains(o.FundingInstrumentType));
			}

			return opportunities;
		}


		public void Dispose()
		{
			_context.Dispose();
		}
	}
}