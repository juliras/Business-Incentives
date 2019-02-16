using System;
using System.Configuration;
using BusinessIncentives.DataTools.DataLoaders;
using BusinessIncentives.DataTools.DataLinkers;

namespace BusinessIncentives.DataTools
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                /*** Load Programs ***/
                Console.WriteLine("Load Programs? y/[n]");

                if (Console.ReadKey(true).Key == ConsoleKey.Y)
                {
                    var programsLoader = new ProgramsDataLoader();
					var result = programsLoader.LoadData(ConfigurationManager.AppSettings[Constants.ConfigurationKeys.ProgramDataFilePath]);

                    Console.WriteLine("Programs loaded!");
                    Console.WriteLine();
                }

                /*** Load Opportunities ***/
                Console.WriteLine("Load Opportunities? y/[n]");

                if (Console.ReadKey(true).Key == ConsoleKey.Y)
                {
                    var opportunitiesLoader = new OpportunitiesLoader();
                    opportunitiesLoader.LoadData(ConfigurationManager.AppSettings[Constants.ConfigurationKeys.GrantDataFilePath]);

                    Console.WriteLine("Opportunities loaded!");
                    Console.WriteLine();
                }

                /*** Load ColoradoBusinesses ***/
                Console.WriteLine("Load ColoradoBusinesses? y/[n]");

                if (Console.ReadKey(true).Key == ConsoleKey.Y)
                {
                    var coloradoBusinessesLoader = new ColoradoBusinessesLoader();
					var result = coloradoBusinessesLoader.LoadData(ConfigurationManager.AppSettings[Constants.ConfigurationKeys.ColoradoBusinessDataFilePath]);

                    Console.WriteLine("ColoradoBusinesses loaded!");
                    Console.WriteLine();
                }

				Console.WriteLine("Link Opportunity (grants.gov) & Program (cfda.gov) data? y/n");

				if (Console.ReadKey(true).Key == ConsoleKey.Y)
				{
					var linker = new GrantProgramLinker();
					var result = linker.LinkData();

					Console.WriteLine("Done!");
					Console.WriteLine();
				}


				Console.WriteLine("Press any key to exit...");
                Console.ReadKey(true);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: { ex.ToString() }");
                Console.ReadLine();
            }
            
        }
    }
}
