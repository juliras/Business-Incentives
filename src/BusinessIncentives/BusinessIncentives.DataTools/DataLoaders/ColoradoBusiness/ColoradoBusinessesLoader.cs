using Models = BusinessIncentives.Common.Models;
using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.IO;
using BusinessIncentives.Common.Models;

namespace BusinessIncentives.DataTools.DataLoaders
{
    public class ColoradoBusinessesLoader
    {
        public DataLoadResult LoadData(string csvFilePath)
        {
            Console.WriteLine($"Importing data from file: [{csvFilePath}]");

            List<Models.ColoradoBusiness> businesses = new List<Models.ColoradoBusiness>();

            Models.ColoradoBusiness coloradoBusiness = null;

            var batchSize = 100;
            var linesRead = 0;
            var recordsAdded = 0;

            // Prompt user for status filter
            Console.WriteLine("Import ONLY businesses in 'Good Standing'? y/[n]");
            var goodStandingOnly = Console.ReadKey(true).Key == ConsoleKey.Y;

			Console.WriteLine("Import ONLY coffee related businesses ? y/[n]");
			var coffeeShopsOnly = Console.ReadKey(true).Key == ConsoleKey.Y;

			Console.WriteLine("Starting imprt...");

            using (TextFieldParser parser = new TextFieldParser(new StreamReader(csvFilePath)))
            {
                parser.HasFieldsEnclosedInQuotes = true;
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");
                parser.TrimWhiteSpace = true;

                Dictionary<string, int> row = new Dictionary<string, int>();

                Console.WriteLine($"Lines processed: {linesRead}");
                Console.WriteLine($"Records added:   {recordsAdded}");

                while (!parser.EndOfData)
                {
                    coloradoBusiness = new Models.ColoradoBusiness();
                    
                    var fields = parser.ReadFields();
                    linesRead++;

                    if (fields[0] == "entityid")
                    {
                        for (int i = 0; i < fields.Length; i++)
                            row.Add(fields[i], i);

                        continue;
                    }

                    if (coffeeShopsOnly && !fields[row["entityname"]].ToLower().Contains("coffee"))
                        continue;

                    if (goodStandingOnly && !fields[row["entitystatus"]].Contains("Good"))
                        continue;
                    
                    coloradoBusiness.EntityId = long.Parse(fields[row["entityid"]]);
                    coloradoBusiness.EntityName = fields[row["entityname"]];
                    coloradoBusiness.PrincipalAddress1 = fields[row["principaladdress1"]];
                    coloradoBusiness.PrincipalAddress2 = fields[row["principaladdress2"]];
                    coloradoBusiness.PrincipalCity = fields[row["principalcity"]];
                    coloradoBusiness.PrincipalState = fields[row["principalstate"]];
                    coloradoBusiness.PrincipalZipCode = fields[row["principalzipcode"]];
                    coloradoBusiness.PrincipalCountry = fields[row["principalcountry"]];
                    coloradoBusiness.EntityStatus = fields[row["entitystatus"]];
                    coloradoBusiness.JurisdictionOfFormation = fields[row["jurisdictonofformation"]];
                    coloradoBusiness.EntityType = fields[row["entitytype"]];

                    // Convert string date to DateTime type
                    DateTime fd = new DateTime();
                    DateTime.TryParse(fields[row["entityformdate"]], out fd);

                    coloradoBusiness.EntityFormDate = fd;
                    coloradoBusiness.InsertedDate = DateTime.Now;

                    recordsAdded++;

                    businesses.Add(coloradoBusiness);

                    if (recordsAdded % batchSize == 0)
                    {
                        PersistRows(businesses, batchSize, ref recordsAdded);
                        businesses = new List<Models.ColoradoBusiness>();
                        Console.CursorLeft = 0;
                        Console.CursorTop -= 2;
                        Console.WriteLine($"Lines processed: {linesRead}");
                        Console.WriteLine($"Records added:   {recordsAdded}");
                    }
                }

                PersistRows(businesses, businesses.Count, ref recordsAdded);
                Console.CursorLeft = 0;
                Console.CursorTop -= 2;
                Console.WriteLine($"Lines processed: {linesRead}");
                Console.WriteLine($"Records added:   {recordsAdded}");
            }

            return new DataLoadResult
            {
                CountOfRecordsLoaded = recordsAdded,
                IsSuccess = true
            };
        }

        private static void PersistRows(List<Models.ColoradoBusiness> rows, int batchSize, ref int recordsAdded)
        {
            using (var context = new BusinessIncentivesContext())
            {
                try
                {
                    context.ColoradoBusinesses.AddRange(rows);
                    context.SaveChanges();
                }
                catch
                {
                    if (rows.Count == 1)
                    {
                        recordsAdded--;
                        return;
                    }

                    for (int i = 0; i < rows.Count; i++)
                    {
                        var temp = new List<Models.ColoradoBusiness>();
                        temp.Add(rows[i]);
                        PersistRows(temp, 1, ref recordsAdded);
                    }
                }
            }
        }
    }
}
