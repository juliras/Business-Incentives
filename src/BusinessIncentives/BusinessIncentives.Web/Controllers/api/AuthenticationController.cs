using System.Web.Http;
using System.Web.SessionState;
using System.Security.Cryptography;
using BusinessIncentives.Web.Models;
using BusinessIncentives.Web.Repositories;

namespace BusinessIncentives.Web.Controllers
{
    public partial class AuthenticationController : ApiController, IRequiresSessionState
    {
        public static SHA512Cng Algorithm { get; private set; }

        // This is the error we return to the client. It has to be vague so we don't give 
        // any indication of anything to potential hackers, like "User not found" or "Incorrect passord"...
        private const string GenericErrorMessage = "Username or Password invalid"; 

        [Route("api/login")]
        [HttpPost]
        public LoginResultModel Login(UserModel userModel)
        {
            var result = new LoginResultModel();

            // We instantiate our repository in charge of fetching the data
            UserRepository repo = new UserRepository(); 
 
            // Search the user database for username and return salt and hash
            byte[] salt = repo.GetSalt(userModel.Username);

            if(salt != null)
            {
                byte[] hashBytes = repo.HashAndSaltPwd(userModel.Password, salt);

                // We fetch the data
                var existingUser = repo.GetUser(userModel.Username, hashBytes);

                if (existingUser == null)
                {
                    result.IsSuccess = false;
                    result.ErrorMessage = GenericErrorMessage;
                    Session.GetCurrent().Clear();
                }
                else
                {
                    // Now anywhere in the web app for subsequent request we can check the value of the login cookie
                    // If it's not null or expired, the user is authenticated
                    Session.GetCurrent().SetUserName(existingUser.Username);
                    
                    result.IsSuccess = true;
                    result.UserFirstName = existingUser.FirstName;
                    result.UserID = existingUser.ID;
                    result.PermissionLevelID = existingUser.PermissionLevelID;
                }
            }
            else
            {
                result.IsSuccess = false;
                result.ErrorMessage = GenericErrorMessage;
                Session.GetCurrent().Clear();
            }

            return result;
        }

        [Route("api/logout")]
        [HttpPost]
        public bool Logout(UserModel userModel)
        {
            Session.GetCurrent().Clear();
            return true;
        }

        [Route("api/createUser")]
        [HttpPost]
        public CreateUserResultModel CreateUser(UserModel userModel)
        {
            var result = new CreateUserResultModel();

            UserRepository repo = new UserRepository();

            var salt = repo.GenerateSalt();
            var hash = repo.HashAndSaltPwd(userModel.Password, salt);

            var userCreationResult = repo.CreateUser(userModel, hash, salt);

            if(userCreationResult.IsSuccess)
            {
                result.IsSuccess = userCreationResult.IsSuccess;
                result.CreatedUserName = userCreationResult.UserCreated.Username;
            }
            else
            {
                result.IsSuccess = false;
                result.ErrorMessage = userCreationResult.ErrorMessage; 
            }

            return result;
        }

        [Route("api/getSession")]
        [HttpPost]
        public GetSessionResultModel GetSession()
        {
            var result = new GetSessionResultModel();

            UserRepository repo = new UserRepository();

            
            result.UserName = Session.GetCurrent().GetUserName();
            result.IsSuccess = Session.GetCurrent().IsValid(result.UserName);
            result.UserFirstName = repo.GetUserFirstName(result.UserName);
            result.PermissionLevelID = repo.GetUserPermission(result.UserName);
            
            return result;
        }
    }
}
