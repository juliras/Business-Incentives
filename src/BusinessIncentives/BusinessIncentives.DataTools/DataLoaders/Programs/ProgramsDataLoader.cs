using Models = BusinessIncentives.Common.Models;
using Microsoft.VisualBasic.FileIO;
using System;
using System.Collections.Generic;
using System.IO;
using BusinessIncentives.Common.Models;

namespace BusinessIncentives.DataTools.DataLoaders
{
    public class ProgramsDataLoader
    {
        public DataLoadResult LoadData(string csvFilePath)
        {
            Console.WriteLine($"Importing data from file: [{csvFilePath}]");
            Console.WriteLine();

            List <Models.Program> programs = new List<Models.Program>();

            Models.Program program = null;

            var batchSize = 100;
            var counter = 0;
            
            using (TextFieldParser parser = new TextFieldParser(new StreamReader(csvFilePath)))
            {
                parser.HasFieldsEnclosedInQuotes = true;
                parser.SetDelimiters(",");

                while (!parser.EndOfData)
                {
                    program = new Models.Program();

                    var fields = parser.ReadFields();

                    if(fields[0] == "Program Title")
                    {
                        continue;
                    }

                    var index = 0;

                    program.ProgramTitle = fields[index++];
                    program.ProgramNumber = fields[index++];
                    program.PopularName_020 = fields[index++];
                    program.FederalAgency_030 = fields[index++];
                    program.Authorization_040 = fields[index++];
                    program.Objectives_050 = fields[index++];
                    program.TypesOfAssistance_060 = fields[index++];
                    program.UsesAndUseRestrictions_070 = fields[index++];
                    program.ApplicantEligibility_081 = fields[index++];
                    program.BeneficiaryEligibility_082 = fields[index++];
                    program.CredentialsDocumentation_083 = fields[index++];
                    program.PreapplicationCoordination_091 = fields[index++];
                    program.ApplicationProcedures_092 = fields[index++];
                    program.AwardProcedure_093 = fields[index++];
                    program.Deadlines_094 = fields[index++];
                    program.RangeOfApprovalDisapprovalTime_095 = fields[index++];
                    program.Appeals_096 = fields[index++];
                    program.Renewals_097 = fields[index++];
                    program.FormulaAndMatchingRequirements_101 = fields[index++];
                    program.LengthAndTimePhasingOfAssistance_102 = fields[index++];
                    program.Reports_111 = fields[index++];
                    program.Audits_112 = fields[index++];
                    program.Records_113 = fields[index++];
                    program.AccountIdentification_121 = fields[index++];
                    program.Obligations_122 = fields[index++];
                    program.RangeAndAverageOfFinancialAssistance_123 = fields[index++];
                    program.ProgramAccomplishments_130 = fields[index++];
                    program.RegulationsGuidelinesAndLiterature_140 = fields[index++];
                    program.RegionalOrLocalOffice_151 = fields[index++];
                    program.HeadquartersOffice_152 = fields[index++];
                    program.WebsiteAddress_153 = fields[index++];
                    program.RelatedPrograms_160 = fields[index++];
                    program.ExamplesOfFundedProjects_170 = fields[index++];
                    program.CriteriaForSelectingProposals_180 = fields[index++];
                    program.PublishedDate = fields[index++];
                    program.ParentShortname = fields[index++];
                    program.URL = fields[index++];
                    program.Recovery = fields[index++];

                    counter++;

                    programs.Add(program);

                    if(counter % batchSize == 0)
                    {
                        PersistPrograms(programs, batchSize);
                        programs = new List<Models.Program>();
                    }

                    Console.CursorLeft = 0;
                    Console.CursorTop -= 1;
                    Console.WriteLine($"Count of lines processed: {counter}");
                }

                PersistPrograms(programs, batchSize);
            }

            return new DataLoadResult
            {
                CountOfRecordsLoaded = counter,
                IsSuccess = true
            };
        }

        private static void PersistPrograms(List<Models.Program> programs, int batchSize)
        {
            using (var context = new BusinessIncentivesContext())
            {
                context.Programs.AddRange(programs);
                context.SaveChanges();
            }
        }
    }
}
