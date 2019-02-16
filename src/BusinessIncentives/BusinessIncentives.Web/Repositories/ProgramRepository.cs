using System.Collections.Generic;
using System.Linq;
using BusinessIncentives.Common.Models;

namespace BusinessIncentives.Web.Repositories
{
	public class ProgramRepository : IProgramRepository
	{
		public List<ProgramView> GetAllPrograms()
		{
			using (var context = new BusinessIncentivesContext())
			{
				return context.ProgramViews.Take(300).ToList();

			}
		}

		/// <summary>
		/// Searches by keywords within the following fields: ProgramTitle, Objectives
		/// </summary>
		/// <param name="keywords"></param>
		/// <returns></returns>
		public List<ProgramView> GetProgramsByKeywords(List<string> keywords)
		{
			if (keywords == null || keywords.Count == 0)
			{
				return GetAllPrograms();
			}
			else
			{
				using (var context = new BusinessIncentivesContext())
				{
					IQueryable<ProgramView> query;

					query = context.ProgramViews.Take(300).Where(p => keywords.Any(kw => p.ProgramTitle.Contains(kw) || p.Objectives_050.Contains(kw) || p.BeneficiaryEligibility_082.Contains(kw)));

					var result = query.ToList();

					return result;
				}
			}
		}
	}
}