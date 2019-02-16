using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using Microsoft.VisualBasic.FileIO;
using System.Configuration;

namespace BusinessIncentives.DataTools.DataLoaders
{
    public class OpportunitiesLoader
    {
        public DataLoadResult LoadData(string xmlFilePath)
        {
            var counter = 0;

            var sqlCommandString = "";

            using (TextFieldParser tfp = new TextFieldParser(new StreamReader("./DataLoaders/Grants/Scripts/XmlDataBulkLoader.sql")))
            {
                sqlCommandString = tfp.ReadToEnd().Replace(@"{XmlFilePath}", xmlFilePath);
            };

            var connectionString = ConfigurationManager.ConnectionStrings["BusinessIncentivesConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                var sqlCommand = connection.CreateCommand();

                sqlCommand.CommandText = sqlCommandString;
                sqlCommand.CommandType = CommandType.Text;
                sqlCommand.CommandTimeout = 0;

                connection.Open();

                IAsyncResult result = sqlCommand.BeginExecuteNonQuery();
                var startTime = DateTime.Now;
                var elapsedTime = DateTime.Now - startTime;

                Console.WriteLine($"Importing data from file: [{xmlFilePath}]");
                Console.WriteLine("Elapsed time: {0}", TimeSpan.FromSeconds(elapsedTime.TotalSeconds).ToString(@"hh\:mm\:ss"));

                while (!result.IsCompleted)
                {
                    elapsedTime = DateTime.Now - startTime;

                    switch (counter % 4)
                    {
                        case 3:
                            Console.CursorTop -= 1;
                            Console.CursorLeft = 0;
                            Console.WriteLine("Elapsed time: {0}", TimeSpan.FromSeconds(elapsedTime.TotalSeconds).ToString(@"hh\:mm\:ss"));
                            break;
                        default:
                            break;
                    }

                    // Wait for 1/4 second, so the counter does not consume all available resources  on the main thread.
                    System.Threading.Thread.Sleep(250);
                    counter++;
                }

                Console.WriteLine();
                Console.WriteLine($"Import Complete!");
            }

            return new DataLoadResult
            {
                CountOfRecordsLoaded = counter,
                IsSuccess = true
            };
        }
    }
}
