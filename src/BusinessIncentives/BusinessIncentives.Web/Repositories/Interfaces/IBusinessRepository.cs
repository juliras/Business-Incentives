using BusinessIncentives.Common.Models;
using System.Collections.Generic;

namespace BusinessIncentives.Web.Repositories
{
	public interface IBusinessRepository
	{
		List<ColoradoBusiness> GetAllBusinesses();
		List<string> GetBusinessNames(string SearchTerm);
		ColoradoBusiness GetBusinessByName(string BusinessName);
		List<ColoradoBusiness> GetBusinesses(string EntityId, string EntityName, string PrincipalAddress1, string PrincipalAddress2, string PrincipalCity, string PrincipalZipCode);
	}
}