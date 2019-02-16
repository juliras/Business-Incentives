using BusinessIncentives.Common.Models;
using System.Collections.Generic;
using System.Linq;

namespace BusinessIncentives.Web.Repositories
{
	public interface IFieldCodedValueRepository
	{
		IQueryable<FieldCodedValue> GetAllFieldCodedValues();
		List<string> GetFieldCode(int originID, List<string> values);
	}
}