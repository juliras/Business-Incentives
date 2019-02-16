using System.Web.Optimization;

namespace BusinessIncentives.Web
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            // Angular & Extensions
            bundles.Add(new ScriptBundle("~/bundles/angular").Include(
                "~/bower_components/angular/angular.js",
                "~/bower_components/angular-route/angular-route.js",
                "~/bower_components/angular-animate/angular-animate.js",
                "~/bower_components/angular-sanitize/angular-sanitize.js",
                "~/bower_components/angularjs-dropdown-multiselect/src/angularjs-dropdown-multiselect.js"
            ));

            // jQuery
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                "~/bower_components/jquery/dist/jquery.js"
            ));

            // Bootstrap (JS Only)
            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                "~/bower_components/bootstrap/dist/bootstrap.js",
                "~/bower_components/bootstrap/js/alert.js",
                "~/bower_components/bootstrap/js/button.js",
                "~/bower_components/bootstrap/js/carousel.js",
                "~/bower_components/bootstrap/js/collapse.js",
                "~/bower_components/bootstrap/js/dropdown.js",
                "~/bower_components/bootstrap/js/modal.js",
                "~/bower_components/bootstrap/js/tooltip.js",
                "~/bower_components/bootstrap/js/popover.js",
                "~/bower_components/bootstrap/js/scrollspy.js",
                "~/bower_components/bootstrap/js/tab.js",
                "~/bower_components/bootstrap/js/transition.js",
                "~/bower_components/angular-bootstrap/ui-bootstrap-tpls.js"));

            // Utilities
            bundles.Add(new ScriptBundle("~/bundles/utils").Include(
                "~/Scripts/app/utils.js",
                "~/bower_components/underscore/underscore.js"
            ));

            // *** App Specific ***
            bundles.Add(new ScriptBundle("~/bundles/app").Include(
                "~/Scripts/app/app.js",
                "~/Scripts/app/app.route.js",
                "~/Scripts/app/home/homeController.js",
                "~/Scripts/app/about/aboutController.js",
                "~/Scripts/app/contact/contactController.js",
                "~/Scripts/app/search/searchController.js",
                "~/Scripts/app/submitOpportunity/submitOpportunityController.js",
                "~/Scripts/app/services/*.js",
                "~/Scripts/app/shared/footer/footerDirective.js",
                "~/Scripts/app/shared/background/backgroundDirective.js",
                "~/Scripts/app/shared/loader/loaderDirective.js",
                "~/Scripts/app/shared/loader/paCOLoaderDirective.js",
                "~/Scripts/app/shared/topBar/topBarDirective.js",
                "~/Scripts/app/shared/maps/mapLegendDirective.js",
                "~/Scripts/app/shared/rootController.js",
                "~/Scripts/app/shared/user/userModalController.js",
                "~/Scripts/app/shared/legal/tosController.js",
                "~/Scripts/app/shared/legal/privacyPolicyController.js"
            ));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                // Themed bootstrap
                "~/Content/css/bootstrap-flatly/bootstrap.css",
                "~/bower_components/angular-bootstrap/ui-bootstrap-csp.css",
                "~/Content/css/site.css",
                "~/Content/css/paco-loader.css"
            ));
        }
    }
}
