using System.Linq;
using System.Collections.Generic;
using BusinessIncentives.Common.Models;
using System;

namespace BusinessIncentives.Web.Repositories
{
	public class CustomOpportunityRepository : ICustomOpportunityRepository, IDisposable
    {
		private BusinessIncentivesContext _context;

		public CustomOpportunityRepository()
		{
			_context = new BusinessIncentivesContext();
		}

		public IQueryable<CustomOpportunity> GetAllCustomOpportunities()
        {
			return _context.CustomOpportunities.AsQueryable();
        }

		public IQueryable<CustomOpportunity> GetCustomOpportunitiesByKeywords(List<string> keywords)
		{
			if (keywords == null || keywords.Count == 0)
			{
				return GetAllCustomOpportunities();
			}
			else
			{
				var customOpportunities = GetAllCustomOpportunities();
				var result = customOpportunities.Where(o => keywords.Any(kw => o.EligibilityKeywords.Contains(kw) || o.Summary.Contains(kw)));
				return result;
			}
		}
		public IQueryable<CustomOpportunity> GetCustomOpportunitiesByAssistanceType(List<string> codes, IQueryable<CustomOpportunity> previousQuery)
		{
			if (codes == null || codes.Count == 0)
			{
				return GetAllCustomOpportunities();
			}
			else
			{
				IQueryable<CustomOpportunity> customOpportunities = null;
				if (previousQuery != null)
				{
					customOpportunities = previousQuery.Where(o => codes.Contains(o.AssistanceTypeID.ToString()));
				}
				else
				{
					customOpportunities = GetAllCustomOpportunities().Where(o => codes.Contains(o.AssistanceType.Name));
				}

				return customOpportunities;
			}
		}
        public long? AddCustomOpportunity(CustomOpportunity customOpportunity)
        {
            using (var context = new BusinessIncentivesContext())
            {
                IQueryable<CustomOpportunity> query = context.CustomOpportunities.Where(o => o.Name == customOpportunity.Name);

                var result = query?.ToList();

                if (result?.Count > 0)
                    return null;

                context.CustomOpportunities.Add(customOpportunity);
                context.SaveChanges();

                query = context.CustomOpportunities.Where(o => o.Name == customOpportunity.Name);

                result = query?.ToList();

                return result[0]?.ID;
            }
        }

		public void Dispose()
		{
			_context.Dispose();
		}
	}
}