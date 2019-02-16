using BusinessIncentives.Common.Models;

namespace BusinessIncentives.Web.Repositories
{
	public interface IUserRepository
    {
        User GetUser(int id);
		User GetUser(string username, byte[] hash);
	}
}