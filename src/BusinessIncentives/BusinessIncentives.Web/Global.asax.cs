using AutoMapper;
using System.Web;
using System.Web.Mvc;
using System.Web.Http;
using System.Web.Routing;
using System.Web.Optimization;
using System.Web.SessionState;
using BusinessIncentives.Common.Models;
using BusinessIncentives.Web.ViewModels;

namespace BusinessIncentives.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            Mapper.Initialize(cfg =>
                {
                    cfg.CreateMap<ColoradoBusiness, BusinessViewModel>();
                }
            );
        }

        protected void Application_BeginRequest()
        {
            if (Context.Request.Url.Host.Contains("coloradoincentives.com") && !Context.Request.IsSecureConnection)
            {
                Response.Redirect(Context.Request.Url.ToString().Replace("http:", "https:"));
            }
        }

        protected void Application_PostAuthorizeRequest()
        {
            if (IsWebApiRequest())
            {
                HttpContext.Current.SetSessionStateBehavior(SessionStateBehavior.Required);
            }
        }

        private bool IsWebApiRequest()
        {
            return HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.StartsWith(WebApiConfig.UrlPrefixRelative);
        }
    }

    internal class Session
    {
		private readonly HttpSessionState session;

		public Session()
		{
			 session = HttpContext.Current.Session;
		}

		public static Session GetCurrent()
		{
			return new Session();
		}

		public string GetUserName()
        {
            if (session["LoggedInUser"] == null)
                return null;

            return (string)session["LoggedInUser"];
        }

        public void SetUserName(string userName)
        {
            session["LoggedInUser"] = userName;
        }

        public void Clear()
        {
            session["LoggedInUser"] = null;
        }

        public bool IsValid(string userName)
        {
            if (userName == null)
                return false;

            return GetUserName() == userName;
        }
    }
}
