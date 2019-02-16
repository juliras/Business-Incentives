using System.Linq;
using System.Collections.Generic;
using BusinessIncentives.Common.Models;
using System;

namespace BusinessIncentives.Web.Repositories
{
	public class FieldCodedValueRepository : IFieldCodedValueRepository, IDisposable
    {
		private BusinessIncentivesContext _context;

		public FieldCodedValueRepository()
		{
			_context = new BusinessIncentivesContext();
		}

		public IQueryable<FieldCodedValue> GetAllFieldCodedValues()
		{
			var query = _context.FieldCodedValues.AsQueryable();
			return query;
		}

		public List<string> GetFieldCode(int originID, List<string> values)
		{
			var query = GetAllFieldCodedValues().Where(fcv => fcv.OriginID == originID && values.Contains(fcv.Value));

			var result = query.Select(fcv => fcv.Code).ToList();

			return result;
		}

		public void Dispose()
		{
			_context.Dispose();
		}

		
	}
}