using System;
using System.Linq;
using System.Security.Cryptography;
using BusinessIncentives.Web.Models;
using BusinessIncentives.Common.Models;
using static BusinessIncentives.Common.ReferenceData.Constants;

namespace BusinessIncentives.Web.Repositories
{
    public class UserRepository : IUserRepository
    {
        public User GetUser(int Id)
        {
            using (var context = new BusinessIncentivesContext())
            {
                var result = context.Users.Where(o => o.ID == Id).Single();

                return result;
            }
        }

        public string GetUserFirstName(string username)
        {
            using (var context = new BusinessIncentivesContext())
            {
                if (username == null || Session.GetCurrent().GetUserName() != username)
                    return null;

                var result = context.Users.Where(o => o.Username == username).Single();

                return result.FirstName;
            }
        }

        public short? GetUserPermission(string username)
        {
            using (var context = new BusinessIncentivesContext())
            {
                if (username == null || Session.GetCurrent().GetUserName() != username)
                    return short.MaxValue;

                var result = context.Users.Where(o => o.Username == username).Single();

                return result.PermissionLevelID;
            }
        }

        public User GetUser(string username, byte[] hash)
        {
            if (string.IsNullOrWhiteSpace(username) || hash.Length == 0)
            {
                return null;
            }
            else
            {
                using (var context = new BusinessIncentivesContext())
                {
                    IQueryable<User> query = context.Users.Where(o => o.Username == username && o.Password == hash);
                    
                    // Returns either the single user object or null (which is a default value)
                    var result = query.SingleOrDefault(); 

                    return result;
                }
            }
        }
        
        public byte[] HashAndSaltPwd(string password, byte[] salt)
        {
            // Salt the password and store in byte array buffer
            var hash = new Rfc2898DeriveBytes(password, salt, 10000).GetBytes(20);
            var hashBytes = new byte[hash.Length + salt.Length];

            Array.Copy(salt, 0, hashBytes, 0, salt.Length);
            Array.Copy(hash, 0, hashBytes, salt.Length, hash.Length);

            return hashBytes;
        }

        public UserCreationResult CreateUser(UserModel userModel, byte[] hash, byte[] salt)
        {
            var result = new UserCreationResult();

            if (userModel == null) throw new ArgumentNullException("userModel");
            if (hash.Length == 0) throw new ArgumentException("Hash can't be empty");

            try
            {
                using (var context = new BusinessIncentivesContext())
                {
                    IQueryable<User> existingUser = context.Users.Where(o => o.Username == userModel.Username || o.Email == userModel.Email);

                    if (existingUser.Count() > 0)
                    {
                        result.IsSuccess = false;
                        result.ErrorMessage = "User already exists!";
                    }
                    else
                    {
                        var user = new User()
                        {
                            Username = userModel.Username,
                            Password = hash,
                            Email = userModel.Email,
                            FirstName = userModel.FirstName,
                            LastName = userModel.LastName,
                            Salt = salt,
                            PermissionLevelID = (short)PermissionLevels.OpportunityCreator
                        };

                        user = context.Users.Add(user);
                        context.SaveChanges();

                        result.UserCreated = user;
                        result.IsSuccess = true;
                    }
                }
            }
            catch (Exception ex)
            {
                result.IsSuccess = false;
                result.ErrorMessage = ex.ToString();
            }
            
            return result;
        }

        public byte[] GetSalt(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
                return null;
            else
            {
                using (var context = new BusinessIncentivesContext())
                {
                    IQueryable<User> query = context.Users.Where(o => o.Username == username);

                    if (query.Count() == 0)
                        return null;

                    var result = query.Select(b => b.Salt).Single();

                    return result;
                }
            }
        }

        public byte[] GenerateSalt(int length = 32)
        {
            byte[] salt;
            new RNGCryptoServiceProvider().GetBytes(salt = new byte[length]);

            return salt;
        }
    }

    public class UserCreationResult
    {
        public bool IsSuccess { get; set; }
        public User UserCreated { get; set; }
        public string ErrorMessage { get; set; }
    }
}