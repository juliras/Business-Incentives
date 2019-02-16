using System.Collections.Generic;
using System.Linq;
using BusinessIncentives.Common.Models;

namespace BusinessIncentives.Web.Repositories
{
    /// <summary>
    /// Repositories are used to decouple the calling code from the underlying data access technology (so for example, 
    /// we can switch between Entity Framework and NHibernate later without breaking the calling code)
    /// </summary>
    public class BusinessRepository : IBusinessRepository
    {
        public BusinessRepository()
        {
        }

        public List<ColoradoBusiness> GetAllBusinesses()
        {
            using (var context = new BusinessIncentivesContext())
            {
                return context.ColoradoBusinesses.ToList();

            }
        }

        public List<string> GetBusinessNames(string searchTerm)
        {
            if (string.IsNullOrWhiteSpace(searchTerm))
            {
                return GetAllBusinesses().Select(b => b.EntityName).ToList(); ;
            }
            else
            {
                using (var context = new BusinessIncentivesContext())
                {
                    IQueryable<ColoradoBusiness> query;

                    // These are constructing the query...
                    query = context.ColoradoBusinesses.Where(o => string.IsNullOrEmpty(searchTerm) || o.EntityName.ToLower().Contains(searchTerm.ToLower()));

                    // This triggers the conversion to SQL + roundtrip to the DB, using the constructed query
                    var result = query.Select( b => b.EntityName).Take(200).ToList();

                    return result;
                }
            }
        }

        public ColoradoBusiness GetBusinessByName(string businessName)
        {
            using (var context = new BusinessIncentivesContext())
            {
                IQueryable<ColoradoBusiness> query;

                // These are constructing the query...
                query = context.ColoradoBusinesses.Where(o => o.EntityName.Equals(businessName));

                // This triggers the conversion to SQL + roundtrip to the DB, using the constructed query
                var result = query.Single();

                return result;
            }
        }

        public List<ColoradoBusiness> GetBusinesses(string EntityId, string EntityName, string PrincipalAddress1, string PrincipalAddress2, string PrincipalCity, string PrincipalZipCode)
        {
            if (string.IsNullOrWhiteSpace(EntityName) && string.IsNullOrWhiteSpace(PrincipalAddress1))
            {
                return GetAllBusinesses();
            }
            else
            {
                using (var context = new BusinessIncentivesContext())
                {
                    IQueryable<ColoradoBusiness> query;

                    // These are constructing the query...
                    query = context.ColoradoBusinesses.Where(o => string.IsNullOrEmpty(EntityName) || o.EntityName.ToLower().Contains(EntityName.ToLower()));

                    if (!string.IsNullOrEmpty(PrincipalAddress1))
                        query = query.Where(o => string.IsNullOrEmpty(PrincipalAddress1) || o.PrincipalAddress1.ToLower().Contains(PrincipalAddress1.ToLower()));

                    if (!string.IsNullOrEmpty(PrincipalAddress2))
                        query = query.Where(o => string.IsNullOrEmpty(PrincipalAddress2) || o.PrincipalAddress2.ToLower().Contains(PrincipalAddress2.ToLower()));

                    if (!string.IsNullOrEmpty(PrincipalCity))
                        query = query.Where(o => string.IsNullOrEmpty(PrincipalCity) || o.PrincipalCity.ToLower().Contains(PrincipalCity.ToLower()));

                    if (!string.IsNullOrEmpty(PrincipalZipCode))
                        query = query.Where(o => string.IsNullOrEmpty(PrincipalZipCode) || o.PrincipalZipCode.ToLower().Contains(PrincipalZipCode.ToLower()));

                    if (query.Count() < 1) return null;

                    // This triggers the conversion to SQL + roundtrip to the DB, using the constructed query
                    var result = query.ToList();

                    return result;
                }
            }
        }
    }
}