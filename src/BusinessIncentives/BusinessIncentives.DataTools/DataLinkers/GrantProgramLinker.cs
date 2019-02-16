using System;
using System.Collections.Generic;
using BusinessIncentives.Common.Models;
using System.Linq;

namespace BusinessIncentives.DataTools.DataLinkers
{
    public class GrantProgramLinker
    {
        public DataLinkResult LinkData()
        {
            Console.CursorVisible = false;
            Console.WriteLine($"Creating cross reference data between Opportunities and Programs...");

            // Get the list of Opportunity record ID's to process
            var opportunityIDs = new List<string>();
            using (var context = new BusinessIncentivesContext())
            {
                // We get the IDs from OpportunityView instead of Opportunity,
                // which filters the opportunities still available only...
                opportunityIDs = context.OpportunityViews.Select(o => o.OpportunityID).ToList();
            }

            // Loop through 100 Opportunity records, and for
            // each get and attach the related programs
            var batchSize = 100;
            var counter = 0;
			var cursorTop = Console.CursorTop + 1;

			using (var context = new BusinessIncentivesContext())
            {
                foreach (var opportunityID in opportunityIDs)
                {
                    var opportunity = context.Opportunities.Single(o => o.OpportunityID == opportunityID);
                    var relatedPrograms = context.Programs.Where(p => opportunity.CFDANumbers.Contains(p.ProgramNumber));

                    string message = string.Empty;

                    var areProgramsAlreadyAttached = opportunity.Programs != null && opportunity.Programs.Count() > 0;

                    if (areProgramsAlreadyAttached)
                    {
                        message = $"Opportunity ID {opportunity.OpportunityID} has its related Programs already attached";
                    }
                    else
                    {
                        opportunity.Programs = relatedPrograms.ToList();
                        var programCount = relatedPrograms.Count();
                        message = $"Opportunity ID {opportunity.OpportunityID} has {programCount} related Program{(programCount > 1 ? "(s)" : "")}";
                    }

					Console.WriteLine(string.Join(" ", Enumerable.Range(0, 50).Select(i => " ")));
					Console.SetCursorPosition(0, cursorTop + 1);
					Console.WriteLine(message);

					counter++;

                    if (counter % batchSize == 0 || counter == opportunityIDs.Count)
                    {
                        // Persist batch
                        context.SaveChanges();
						Console.SetCursorPosition(0, cursorTop);
						Console.WriteLine($"Count of Opportunity records processed: {counter} / {opportunityIDs.Count}");

					}
                }

				Console.SetCursorPosition(0, cursorTop + 1);
			}

            return new DataLinkResult
            {
                CountOfRecordsLinked = counter,
                IsSuccess = true
            };
        }
    }
}
