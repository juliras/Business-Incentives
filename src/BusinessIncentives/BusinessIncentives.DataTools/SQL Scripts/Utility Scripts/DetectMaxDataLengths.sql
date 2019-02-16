select 
	max(datalength([ProgramNumber])) ProgramNumber,
	max(datalength([ProgramTitle])) ProgramTitle,
	max(datalength([PopularName_020])) PopularName_020,
	max(datalength([FederalAgency_030])) FederalAgency_030,
	max(datalength([Authorization_040])) Authorization_040,
	max(datalength([Objectives_050])) Objectives_050,
	max(datalength([TypesOfAssistance_060])) TypesOfAssistance_060,
	max(datalength([UsesAndUseRestrictions_070])) UsesAndUseRestrictions_070,
	max(datalength([ApplicantEligibility_081])) ApplicantEligibility_081,
	max(datalength([BeneficiaryEligibility_082])) BeneficiaryEligibility_082,
	max(datalength([CredentialsDocumentation_083])) CredentialsDocumentation_083,
	max(datalength([PreapplicationCoordination_091])) PreapplicationCoordination_091,
	max(datalength([ApplicationProcedures_092])) ApplicationProcedures_092,
	max(datalength([AwardProcedure_093])) AwardProcedure_093,
	max(datalength([Deadlines_094])) Deadlines_094,
	max(datalength([RangeOfApprovalDisapprovalTime_095])) RangeOfApprovalDisapprovalTime_095,
	max(datalength([Appeals_096])) Appeals_096,
	max(datalength([Renewals_097])) Renewals_097,
	max(datalength([FormulaAndMatchingRequirements_101])) FormulaAndMatchingRequirements_101,
	max(datalength([LengthAndTimePhasingOfAssistance_102])) LengthAndTimePhasingOfAssistance_102,
	max(datalength([Reports_111])) Reports_111,
	max(datalength([Audits_112])) Audits_112,
	max(datalength([Records_113])) Records_113,
	max(datalength([AccountIdentification_121])) AccountIdentification_121,
	max(datalength([Obligations_122])) Obligations_122,
	max(datalength([RangeAndAverageOfFinancialAssistance_123])) RangeAndAverageOfFinancialAssistance_123,
	max(datalength([ProgramAccomplishments_130])) ProgramAccomplishments_130,
	max(datalength([RegulationsGuidelinesAndLiterature_140])) RegulationsGuidelinesAndLiterature_140,
	max(datalength([RegionalOrLocalOffice_151])) RegionalOrLocalOffice_151,
	max(datalength([HeadquartersOffice_152])) HeadquartersOffice_152,
	max(datalength([WebsiteAddress_153])) WebsiteAddress_153,
	max(datalength([RelatedPrograms_160])) RelatedPrograms_160,
	max(datalength([ExamplesOfFundedProjects_170])) ExamplesOfFundedProjects_170,
	max(datalength([CriteriaForSelectingProposals_180])) CriteriaForSelectingProposals_180,
	max(datalength([PublishedDate])) PublishedDate,
	max(datalength([ParentShortname])) ParentShortname,
	max(datalength([URL])) URL,
	max(datalength([Recovery])) Recovery,
	max(datalength([InsertedDate])) InsertedDate,
	max(datalength([UpdatedDate])) UpdatedDate
from Program

/*
Result as of 2018-05-18:
------------------------
ProgramNumber,ProgramTitle,PopularName_020,FederalAgency_030,Authorization_040,Objectives_050,TypesOfAssistance_060,UsesAndUseRestrictions_070,ApplicantEligibility_081,BeneficiaryEligibility_082,CredentialsDocumentation_083,PreapplicationCoordination_091,ApplicationProcedures_092,AwardProcedure_093,Deadlines_094,RangeOfApprovalDisapprovalTime_095,Appeals_096,Renewals_097,FormulaAndMatchingRequirements_101,LengthAndTimePhasingOfAssistance_102,Reports_111,Audits_112,Records_113,AccountIdentification_121,Obligations_122,RangeAndAverageOfFinancialAssistance_123,ProgramAccomplishments_130,RegulationsGuidelinesAndLiterature_140,RegionalOrLocalOffice_151,HeadquartersOffice_152,WebsiteAddress_153,RelatedPrograms_160,ExamplesOfFundedProjects_170,CriteriaForSelectingProposals_180,PublishedDate,ParentShortname,URL,Recovery,InsertedDate,UpdatedDate
12,478,3684,246,25234,27584,1928,62668,28102,12054,13674,21772,80312,13198,8860,8944,4258,8856,42518,10310,40450,4658,5924,514,7294,8304,35270,9584,8736,4354,392,2138,56126,23758,24,12,72,6,8,8
*/