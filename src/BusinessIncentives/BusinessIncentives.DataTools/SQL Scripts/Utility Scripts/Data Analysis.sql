use BusinessIncentives

/**************************/
/* Opportunities (Grants) */
/**************************/
-- Total count of Opportunities
select count(*) from Opportunity --> 48,674

-- Opportunities still available 
select OpportunityNumber, PostDate, CloseDate, CloseDateExplanation, ArchiveDate, o.CFDANumbers, o.EstimatedTotalProgramFunding
from Opportunity o
	where (o.CloseDate is null or o.CloseDate between getdate() and '2099-01-01') -- CloseDate empty or in the future
	 and (o.ArchiveDate is null or o.ArchiveDate > getdate()) -- and ArchiveDate empty or in the future
	 and (o.CloseDateExplanation is null or o.CloseDateExplanation not like '% not accept%' and o.CloseDateExplanation not like '% no applications%') -- 
order by 3 desc --> 2362

-- Opportunities not available anymore
select OpportunityNumber, PostDate, CloseDate, CloseDateExplanation, ArchiveDate, o.CFDANumbers, o.EstimatedTotalProgramFunding
from Opportunity o
	where (o.CloseDate < getdate() or o.CloseDate > '2099-01-01') -- CloseDate in the past or typoed like 2102 or 3018
	 or  (o.ArchiveDate < getdate()) -- ArchiveDate in the past
	 or  ((o.CloseDate is null or o.CloseDate between getdate() and '2099-01-01') and o.CloseDateExplanation is not null and (o.CloseDateExplanation like '% not accept%' or o.CloseDateExplanation like '% no applications%'))
order by 3 desc --> 46,312

select OpportunityNumber, PostDate, CloseDate, CloseDateExplanation, ArchiveDate, o.CFDANumbers, o.EstimatedTotalProgramFunding
from Opportunity o
	where (o.EstimatedTotalProgramFunding = '0') 


-- Opportunities with no match in Programs 
select OpportunityNumber, PostDate, CloseDate, CloseDateExplanation, ArchiveDate, o.CFDANumbers, p.ProgramNumber, o.*
from Opportunity o
	left join Program p on o.CFDANumbers like '%' + p.ProgramNumber + '%'
	where (o.CloseDate is null or o.CloseDate > getdate()) -- CloseDate empty or in the future
	 and (o.ArchiveDate is null or o.ArchiveDate > getdate()) -- ArchiveDate empty or in the future
	 and (o.CloseDateExplanation is null or o.CloseDateExplanation not like '% not accept%') -- 
	 and p.ProgramNumber is null
order by 3 desc --> 103


/**************************/
/*        Programs        */
/**************************/
-- Total count of Programs
select count(*) from Program --> 2200

-- Deadlines_094 with no date
select count(*) from Program where Deadlines_094 not like '%20%' --> 1,969 no real date (18 distinct values)
select distinct Deadlines_094, count(*) [count] from Program where Deadlines_094 not like '%20%' group by Deadlines_094  --> count of similar deadlines with no dates (ex: 'Not Applicable.' appears 454 times)

-- Deadlines_094 with date(s)
select count(*) from Program where Deadlines_094 like '%20%' --> 231 with dates 
select Deadlines_094,* from Program where Deadlines_094 like '%20%' --> 231 with dates 
-- Index of year for Deadlines_94 having dates in them
select Deadlines_094, 
patindex( '%, 20%', Deadlines_094) [patindex ', 20'], -- 7
patindex( '% to %', Deadlines_094) [patindex ' to'], -- 13
* from Program where patindex( '%, 20%', Deadlines_094) = 7 --> 227 with dates 

-- Program currently available --> 2,012
select * from (
	-- Records with deadline
	select  
		1 as DeadlineDefined,
		case when patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) != 13 -- we have one date only at the beginning
				then convert(date, (substring(Deadlines_094, 1, 12))) 
			 when patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) = 13 and /**/substring(Deadlines_094, 25, 1) = '2' /*<--prevent issue with [date] to [be determined]*/-- we have a range of dates
				then convert(date, (substring(Deadlines_094, 17, 12)))
		end [Extracted deadline],
		* 
	from Program 
	where (patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) != 13)
			or
		  (patindex( '%, 20%', Deadlines_094) = 7 and patindex( '% to %', Deadlines_094) = 13 and substring(Deadlines_094, 25, 1) = '2') /*prevent issue with [date] to [be determined]*/ 
	UNION ALL
	-- Records with no deadline defined
	select 
		0 as DeadlineDefined,
		null as [Extracted deadline], 
		* from Program where Deadlines_094 not like '%20%' 
) as t
where 
	DeadlineDefined = 1 and t.[Extracted deadline] > getdate() -- deadline defined and in the future
	or
	DeadlineDefined = 0 -- no deadline defined


/***************/
/* Aggregation */
/***************/
select 
	o.OpportunityTitle,
	o.OpportunityNumber,
	o.FundingInstrumentType,
	o.CategoryOfFundingActivity,
	o.CFDANumbers,
	o.EligibleApplicants,
	o.AdditionalInformationOnEligibility,
	o.AgencyName,
	o.PostDate,
	o.CloseDate,
	o.ExpectedNumberOfAwards,
	o.EstimatedTotalProgramFunding,
	o.AwardCeiling,
	o.LastUpdatedDate,
	o.ArchiveDate,
	o.Description,
	o.AdditionalInformationURL,
	o.GrantorContactText,
	o.GrantorContactEmail,
	o.Version,

	p.ProgramNumber,
	p.ProgramTitle,
	p.PopularName_020,
	p.FederalAgency_030,
	p.Objectives_050,
	p.TypesOfAssistance_060,
	p.UsesAndUseRestrictions_070,
	p.ApplicantEligibility_081,
	p.BeneficiaryEligibility_082,
	p.ApplicationProcedures_092,
	p.AwardProcedure_093,
	p.Deadlines_094,
	p.RangeOfApprovalDisapprovalTime_095,
	p.Renewals_097,
	p.WebsiteAddress_153,
	p.URL
from OpportunityView o 
		left join 
	 ProgramView p 
		on PATINDEX('%'+p.ProgramNumber+'%', o.CFDANumbers) > 0
where 
p.BeneficiaryEligibility_082 like '%women%' 
order by o.OpportunityNumber desc, o.LastUpdatedDate desc
