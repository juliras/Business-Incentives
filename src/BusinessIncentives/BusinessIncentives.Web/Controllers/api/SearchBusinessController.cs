using AutoMapper;
using BusinessIncentives.Web.Models;
using BusinessIncentives.Web.Repositories;
using BusinessIncentives.Web.ViewModels;
using System.Collections.Generic;
using System.Web.Http;

namespace BusinessIncentives.Web.Controllers
{
	public partial class SearchBusinessController : ApiController
    {
        [Route("api/searchBusiness/coloradobusinessnames")]
        [HttpGet]
        public List<string> Search(string searchTerm)
        {
            BusinessRepository repo = new BusinessRepository(); // We instantiate our repository in charge of fetching the data

            var businessNames = repo.GetBusinessNames(searchTerm); // We fetch the data

            return businessNames;
        }

		[Route("api/searchBusiness/coloradobusiness")]
		[HttpGet]
		public BusinessViewModel GetBusinessByName(string businessName)
		{
			BusinessRepository repo = new BusinessRepository();

			var business = repo.GetBusinessByName(businessName);

			var businessViewModel = Mapper.Map<BusinessViewModel>(business);

			return businessViewModel;
		}

		[Route("api/searchBusiness/coloradobusinesses")]
		[HttpPost]
		public List<BusinessViewModel> Search(SearchBusinessModel searchModel)
		{
			BusinessRepository repo = new BusinessRepository();

			var businesses = repo.GetBusinesses(searchModel.EntityId, searchModel.EntityName, searchModel.PrincipalAddress2, searchModel.PrincipalAddress1, searchModel.PrincipalCity, searchModel.PrincipalZipCode);

			var businessViewModels = Mapper.Map<List<BusinessViewModel>>(businesses);

			return businessViewModels;
		}
	}
}
