
truncate table  OpportunityProgramXRef
;with cte as 
(select OpportunityID from OpportunityView)
, cte2 as (select o.OpportunityID from Opportunity o
left join cte on cte.OpportunityID = o.OpportunityID
where cte.OpportunityID is null
)
delete Opportunity where OpportunityID in 
(select * from cte2)

;with cte as 
(select ProgramNumber from ProgramView)
, cte2 as (select p.ProgramNumber from Program p
left join cte on cte.ProgramNumber = p.ProgramNumber
where cte.ProgramNumber is null
)
delete Program where ProgramNumber in 
(select * from cte2)
