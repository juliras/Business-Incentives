
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- Variable for file data
Declare @fileData  XML

-- Import file contents into variable --> File retrieved from https://www.grants.gov/web/grants/xml-extract.html
select @fileData=BulkColumn from openrowset(bulk '{XmlFilePath}', single_blob) x; 
/*Keep this for manual runs */ --> select @fileData=BulkColumn from openrowset(bulk 'C:\datasets\GrantsDBExtract20180528v2.xml', single_blob) x; 

-- Insert [OpportunitySynopsisDetail_1_0] and [OpportunityForecastDetail_1_0] from @fileData into Opportunity table
;with xmlnamespaces(default 'http://apply.grants.gov/system/OpportunityDetail-V1.0')
insert into Opportunity (
	   OpportunityID
	  ,OpportunityTitle
	  ,OpportunityNumber
	  ,OpportunityCategory
	  ,OpportunityCategoryExplanation
	  ,FundingInstrumentType
	  ,CategoryOfFundingActivity
	  ,CategoryExplanation
	  ,CFDANumbers
	  ,EligibleApplicants
	  ,AdditionalInformationOnEligibility
	  ,AgencyCode
	  ,AgencyName
	  ,PostDate
	  ,CloseDate
	  ,CloseDateExplanation
	  ,ExpectedNumberOfAwards
	  ,EstimatedTotalProgramFunding
	  ,AwardCeiling
	  ,AwardFloor
	  ,LastUpdatedDate
	  ,EstimatedSynopsisPostDate
	  ,FiscalYear
	  ,EstimatedSynopsisCloseDate
	  ,EstimatedSynopsisCloseDateExplanation
	  ,EstimatedAwardDate
	  ,EstimatedProjectStartDate
	  ,ArchiveDate
	  ,Description
	  ,CostSharingOrMatchingRequirement
	  ,AdditionalInformationText
	  ,AdditionalInformationURL
	  ,GrantorContactText
	  ,GrantorContactEmailDescription
	  ,GrantorContactEmail
	  ,GrantorContactName
	  ,GrantorContactPhoneNumber
	  ,Version
)
 select
	[Table].[Column].value('OpportunityID[1]', 'nvarchar(30)') OpportunityID,
	[Table].[Column].value('OpportunityTitle[1]', 'nvarchar(300)') OpportunityTitle,
	[Table].[Column].value('OpportunityNumber[1]', 'nvarchar(50)') OpportunityNumber,
	[Table].[Column].value('OpportunityCategory[1]', 'nvarchar(4)') OpportunityCategory,
	[Table].[Column].value('OpportunityCategoryExplanation[1]', 'nvarchar(300)') OpportunityCategoryExplanation,
	[Table].[Column].value('FundingInstrumentType[1]', 'nvarchar(5)') FundingInstrumentType,
	[Table].[Column].query('for $i in CategoryOfFundingActivity return concat($i/text()[1], ",")').value('.', 'nvarchar(200)') CategoryOfFundingActivity,
	[Table].[Column].value('CategoryExplanation[1]', 'nvarchar(4000)') CategoryExplanation,
	[Table].[Column].query('for $i in CFDANumbers return concat($i/text()[1], ",")').value('.', 'nvarchar(200)') CFDANumbers,
	[Table].[Column].query('for $i in EligibleApplicants return concat($i/text()[1], ",")').value('.', 'nvarchar(200)') EligibleApplicants,
	[Table].[Column].value('AdditionalInformationOnEligibility[1]', 'nvarchar(4000)') AdditionalInformationOnEligibility,
	[Table].[Column].value('AgencyCode[1]', 'nvarchar(300)') AgencyCode,
	[Table].[Column].value('AgencyName[1]', 'nvarchar(300)') AgencyName,
	-- PostDate
	(case when [Table].[Column].value('PostDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('PostDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('PostDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('PostDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) PostDate,
	-- CloseDate
	(case when [Table].[Column].value('CloseDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('CloseDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('CloseDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('CloseDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) CloseDate,
	[Table].[Column].value('CloseDateExplanation[1]', 'nvarchar(4000)') CloseDateExplanation,
	[Table].[Column].value('ExpectedNumberOfAwards[1]', 'nvarchar(20)') ExpectedNumberOfAwards,
	[Table].[Column].value('EstimatedTotalProgramFunding[1]', 'nvarchar(20)') EstimatedTotalProgramFunding,
	[Table].[Column].value('AwardCeiling[1]', 'nvarchar(20)') AwardCeiling,
	[Table].[Column].value('AwardFloor[1]', 'nvarchar(20)') AwardFloor,
	-- LastUpdatedDate
	(case when [Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) LastUpdatedDate,
	[Table].[Column].value('EstimatedSynopsisPostDate[1]', 'nvarchar(8)') EstimatedSynopsisPostDate,
	[Table].[Column].value('FiscalYear[1]', 'nvarchar(4)') FiscalYear,
	[Table].[Column].value('EstimatedSynopsisCloseDate[1]', 'nvarchar(8)') EstimatedSynopsisCloseDate,
	[Table].[Column].value('EstimatedSynopsisCloseDateExplanation[1]', 'nvarchar(300)') EstimatedSynopsisCloseDateExplanation,
	[Table].[Column].value('EstimatedAwardDate[1]', 'nvarchar(8)') EstimatedAwardDate,
	[Table].[Column].value('EstimatedProjectStartDate[1]', 'nvarchar(8)') EstimatedProjectStartDate,
	-- ArchiveDate
	(case when [Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) ArchiveDate,
	[Table].[Column].value('Description[1]', 'nvarchar(max)') Description,
	[Table].[Column].value('CostSharingOrMatchingRequirement[1]', 'nvarchar(4)') CostSharingOrMatchingRequirement,
	[Table].[Column].value('AdditionalInformationText[1]', 'nvarchar(300)') AdditionalInformationText,
	[Table].[Column].value('AdditionalInformationURL[1]', 'nvarchar(300)') AdditionalInformationURL,
	[Table].[Column].value('GrantorContactText[1]', 'nvarchar(2500)') GrantorContactText,
	[Table].[Column].value('GrantorContactEmailDescription[1]', 'nvarchar(300)') GrantorContactEmailDescription,
	[Table].[Column].value('GrantorContactEmail[1]', 'nvarchar(300)') GrantorContactEmail,
	[Table].[Column].value('GrantorContactName[1]', 'nvarchar(2500)') GrantorContactName,
	[Table].[Column].value('GrantorContactPhoneNumber[1]', 'nvarchar(100)') GrantorContactPhoneNumber,
	[Table].[Column].value('Version[1]', 'nchar(10)') Version
from @fileData.nodes('/Grants/OpportunitySynopsisDetail_1_0') [Table]([Column])
union
select
	[Table].[Column].value('OpportunityID[1]', 'nvarchar(30)') OpportunityID,
	[Table].[Column].value('OpportunityTitle[1]', 'nvarchar(300)') OpportunityTitle,
	[Table].[Column].value('OpportunityNumber[1]', 'nvarchar(50)') OpportunityNumber,
	[Table].[Column].value('OpportunityCategory[1]', 'nvarchar(4)') OpportunityCategory,
	[Table].[Column].value('OpportunityCategoryExplanation[1]', 'nvarchar(300)') OpportunityCategoryExplanation,
	[Table].[Column].value('FundingInstrumentType[1]', 'nvarchar(5)') FundingInstrumentType,
	[Table].[Column].query('for $i in CategoryOfFundingActivity return concat($i/text()[1], ",")').value('.', 'nvarchar(200)') CategoryOfFundingActivity,
	[Table].[Column].value('CategoryExplanation[1]', 'nvarchar(4000)') CategoryExplanation,
	[Table].[Column].query('for $i in CFDANumbers return concat($i/text()[1], ",")').value('.', 'nvarchar(200)') CFDANumbers,
	[Table].[Column].query('for $i in EligibleApplicants return concat($i/text()[1], ",")').value('.', 'nvarchar(200)') EligibleApplicants,
	[Table].[Column].value('AdditionalInformationOnEligibility[1]', 'nvarchar(4000)') AdditionalInformationOnEligibility,
	[Table].[Column].value('AgencyCode[1]', 'nvarchar(300)') AgencyCode,
	[Table].[Column].value('AgencyName[1]', 'nvarchar(300)') AgencyName,
	-- PostDate
	(case when [Table].[Column].value('PostDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('PostDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('PostDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('PostDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) PostDate,
	-- CloseDate
	(case when [Table].[Column].value('CloseDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('CloseDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('CloseDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('CloseDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) CloseDate,
	[Table].[Column].value('CloseDateExplanation[1]', 'nvarchar(4000)') CloseDateExplanation,
	[Table].[Column].value('ExpectedNumberOfAwards[1]', 'nvarchar(20)') ExpectedNumberOfAwards,
	[Table].[Column].value('EstimatedTotalProgramFunding[1]', 'nvarchar(20)') EstimatedTotalProgramFunding,
	[Table].[Column].value('AwardCeiling[1]', 'nvarchar(20)') AwardCeiling,
	[Table].[Column].value('AwardFloor[1]', 'nvarchar(20)') AwardFloor,
	-- LastUpdatedDate
	(case when [Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('LastUpdatedDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) LastUpdatedDate,
	[Table].[Column].value('EstimatedSynopsisPostDate[1]', 'nvarchar(8)') EstimatedSynopsisPostDate,
	[Table].[Column].value('FiscalYear[1]', 'nvarchar(4)') FiscalYear,
	[Table].[Column].value('EstimatedSynopsisCloseDate[1]', 'nvarchar(8)') EstimatedSynopsisCloseDate,
	[Table].[Column].value('EstimatedSynopsisCloseDateExplanation[1]', 'nvarchar(300)') EstimatedSynopsisCloseDateExplanation,
	[Table].[Column].value('EstimatedAwardDate[1]', 'nvarchar(8)') EstimatedAwardDate,
	[Table].[Column].value('EstimatedProjectStartDate[1]', 'nvarchar(8)') EstimatedProjectStartDate,
	-- ArchiveDate
	(case when [Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)') is null
		then null
	 else 
		parse(concat(substring([Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)'),1,2) ,'-', 
		  			 substring([Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)'),3,2) ,'-', 
					 substring([Table].[Column].value('ArchiveDate[1]', 'nvarchar(8)'),5,4)) as datetime) 
	end) ArchiveDate,
	[Table].[Column].value('Description[1]', 'nvarchar(max)') Description,
	[Table].[Column].value('CostSharingOrMatchingRequirement[1]', 'nvarchar(4)') CostSharingOrMatchingRequirement,
	[Table].[Column].value('AdditionalInformationText[1]', 'nvarchar(300)') AdditionalInformationText,
	[Table].[Column].value('AdditionalInformationURL[1]', 'nvarchar(300)') AdditionalInformationURL,
	[Table].[Column].value('GrantorContactText[1]', 'nvarchar(2500)') GrantorContactText,
	[Table].[Column].value('GrantorContactEmailDescription[1]', 'nvarchar(300)') GrantorContactEmailDescription,
	[Table].[Column].value('GrantorContactEmail[1]', 'nvarchar(300)') GrantorContactEmail,
	[Table].[Column].value('GrantorContactName[1]', 'nvarchar(2500)') GrantorContactName,
	[Table].[Column].value('GrantorContactPhoneNumber[1]', 'nvarchar(100)') GrantorContactPhoneNumber,
	[Table].[Column].value('Version[1]', 'nchar(10)') Version
from @fileData.nodes('/Grants/OpportunityForecastDetail_1_0') [Table]([Column])
