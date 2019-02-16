using BusinessIncentives.Common.Models;
using BusinessIncentives.Web.ViewModels;
using BusinessIncentives.Common.Extensions;
using BusinessIncentives.Common.ReferenceData;
using BusinessIncentives.Web.Repositories;
using System.Collections.Generic;
using System.Linq;
using System;

namespace BusinessIncentives.Web.ViewModelMappers
{
	public class AssistanceViewModelMapper
	{
		private readonly IFieldCodedValueRepository _fieldCodedValueRepository;

		private readonly List<FieldCodedValue> _fieldCodedValues;

		private Dictionary<int, string> _fundingLevelNames;


	public AssistanceViewModelMapper(IFieldCodedValueRepository fieldCodedValueRepository)
		{
			_fieldCodedValueRepository = fieldCodedValueRepository;
			_fieldCodedValues = _fieldCodedValueRepository.GetAllFieldCodedValues().ToList();
			_fundingLevelNames = new Dictionary<int, string>() { { 1, "City"}, { 2, "State"}, { 3, "County"}, { 4, "Region"}, { 5, "Federal"} };
		}

		public AssistanceViewModel GetFromOpportunity(Opportunity opportunity)
		{
			return new AssistanceViewModel
			{
				AssistanceOrigin = StaticData.AssistanceOrigins[AssistanceOrigin.GrantsGov],
				AssistanceID = opportunity.OpportunityID,
				AssistanceType = _fieldCodedValues.SingleOrDefault(fcv => fcv.OriginID == (int)AssistanceOrigin.GrantsGov && fcv.Code == opportunity.FundingInstrumentType)?.Value,
				Title = opportunity.OpportunityTitle.Cleanup(),
				CreationDateLabel = opportunity.PostDate?.ToShortDateString() ?? "N/A",
				CloseDate = opportunity.CloseDate,
				CloseDateLabel = opportunity.CloseDate?.ToShortDateString() ?? "N/A",
				Deadline = opportunity.CloseDate,
				DescriptionLong = opportunity.Description.Cleanup(),
				DescriptionShort = opportunity.Description.LimitLengthTo(250, addDots: true).Cleanup()
			};
		}

		public AssistanceViewModel GetFromProgram(ProgramView program)
		{
			DateTime creationDate = DateTime.MinValue;

			DateTime.TryParse(program.PublishedDate, out creationDate);

			var creationDateLabel = creationDate == DateTime.MinValue ? null : creationDate.ToShortDateString();

			return new AssistanceViewModel
			{
				AssistanceOrigin = StaticData.AssistanceOrigins[AssistanceOrigin.SamGov],
				AssistanceID = program.ProgramNumber,
				AssistanceType = program.TypesOfAssistance_060.LimitLengthTo(20, true),
				Title = program.PopularName_020.Cleanup(),
				CreationDateLabel = creationDateLabel,
				CloseDate = program.ExtractedDeadline,
				CloseDateLabel = program.ExtractedDeadline?.ToShortDateString() ?? "N/A",
				DescriptionLong = program.Objectives_050.Cleanup(),
				DescriptionShort = program.Objectives_050.LimitLengthTo(250, addDots: true).Cleanup()
			};
		}

		public AssistanceViewModel GetFromCustomOpportunity(CustomOpportunity customOpportunity)
		{
			return new AssistanceViewModel
			{
				AssistanceOrigin = customOpportunity.Origin,
				AssistanceID = customOpportunity.ID.ToString(),
				AssistanceTypeID = customOpportunity.AssistanceTypeID,
				AssistanceType = customOpportunity.AssistanceType?.Name,
				FundingLevelID = customOpportunity.FundingLevelID ?? 0,
				FundingLevelLabel = GetFundingLevelNameByID(customOpportunity.FundingLevelID),
				Title = customOpportunity.Name.Cleanup(),
				CreationDate = customOpportunity.OpeningDate,
				CreationDateLabel = customOpportunity.OpeningDate?.ToShortDateString() ?? "N/A",
				CloseDate = customOpportunity.ClosingDate,
				CloseDateLabel = customOpportunity.ClosingDate?.ToShortDateString() ?? "N/A",
				Deadline = customOpportunity.ClosingDate,
				DescriptionLong = customOpportunity.Summary.Cleanup(),
				DescriptionShort = customOpportunity.Summary.LimitLengthTo(250, addDots: true).Cleanup()
			};
		}

		private string GetFundingLevelNameByID(int? fundingLevelID)
		{
			if (!fundingLevelID.HasValue) return "N/A";
			return _fundingLevelNames[fundingLevelID.Value];
		}
	}
}