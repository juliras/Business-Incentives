use [BusinessIncentives]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*************************************************************************************************************/
/* This view pre-filters Programs that are currently available (deadline in the future or no deadline at all */
/*************************************************************************************************************/
CREATE VIEW [dbo].[ProgramView]
AS
select * from (
    -- Records with deadline
    select  
        1 as DeadlineDefined,
        case when patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) != 13 -- we have one date only at the beginning
                then convert(date, (substring(Deadlines_094, 1, 12))) 
             when patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) = 13 and /**/substring(Deadlines_094, 25, 1) = '2' /*<--prevent issue with [date] to [be determined]*/-- we have a range of dates
                then convert(date, (substring(Deadlines_094, 17, 12)))
        end [ExtractedDeadline],
        * 
    from Program 
    where (patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) != 13)
            or
          (patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) = 13 and substring(Deadlines_094, 25, 1) = '2') /*prevent issue with [date] to [be determined]*/ 
    UNION ALL
    -- Records with no deadline defined
    select 
        0 as DeadlineDefined,
        null as [ExtractedDeadline], 
        * 
    from Program where Deadlines_094 not like '%20%' 
) as t
where 
    DeadlineDefined = 1 and t.[ExtractedDeadline] > getdate() -- deadline defined and in the future
    or
    DeadlineDefined = 0 -- no deadline defined
GO

/******************************************************************************************************************************************/
/* This view pre-filters Opportunities that are currently available (based on analysis of CloseDate, ArchiveDate and CloseDateExplanation */
/******************************************************************************************************************************************/
CREATE VIEW [dbo].[OpportunityView]
AS
SELECT  
    OpportunityID, OpportunityTitle, OpportunityNumber, OpportunityCategory, OpportunityCategoryExplanation, FundingInstrumentType, CategoryOfFundingActivity, CategoryExplanation, CFDANumbers, EligibleApplicants, 
    AdditionalInformationOnEligibility, AgencyCode, AgencyName, PostDate, CloseDate, CloseDateExplanation, ExpectedNumberOfAwards, EstimatedTotalProgramFunding, AwardCeiling, AwardFloor, LastUpdatedDate, 
    EstimatedSynopsisPostDate, FiscalYear, EstimatedSynopsisCloseDate, EstimatedSynopsisCloseDateExplanation, EstimatedAwardDate, EstimatedProjectStartDate, ArchiveDate, Description, 
    CostSharingOrMatchingRequirement, AdditionalInformationText, AdditionalInformationURL, GrantorContactText, GrantorContactEmailDescription, GrantorContactEmail, GrantorContactName, GrantorContactPhoneNumber, Version, 
    InsertedDate, UpdatedDate
FROM dbo.Opportunity AS o
WHERE (CloseDate IS NULL OR
       CloseDate BETWEEN GETDATE() AND '2099-01-01') AND (ArchiveDate IS NULL OR
       ArchiveDate > GETDATE()) AND (CloseDateExplanation IS NULL OR
       CloseDateExplanation NOT LIKE '% not accept%' AND CloseDateExplanation NOT LIKE '% no applications%')
GO
 