using BusinessIncentives.Web.Controllers;

namespace BusinessIncentives.Web.Models
{
    public class LoginResultModel
    {
        public bool IsSuccess { get; set; }
        public int UserID { get; set; }
        public string UserFirstName { get; set; }
        public short? PermissionLevelID { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class CreateUserResultModel
    {
        public bool IsSuccess { get; set; }
        public string ErrorMessage { get; set; }
        public string CreatedUserName { get; set; }
    }

    public class CreateCustomOpportunityResultModel
    {
        public bool IsSuccess { get; set; }
        public long? OpportunityID { get; set; }
        public dbError ErrorCode { get; set; }
        public string ErrorMessage { get; set; }
    }

    public class GetSessionResultModel
    {
        public bool IsSuccess { get; set; }
        public string UserName { get; set; }
        public string UserFirstName { get; set; }
        public short? PermissionLevelID { get; set; }
        public string ErrorMessage { get; set; }
    }
}
