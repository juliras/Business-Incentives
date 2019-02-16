using BusinessIncentives.Common.Models;
using System.Collections.Generic;

namespace BusinessIncentives.Web.Repositories
{
	public interface IProgramRepository
	{
		List<ProgramView> GetAllPrograms();
		List<ProgramView> GetProgramsByKeywords(List<string> keywords);
	}
}