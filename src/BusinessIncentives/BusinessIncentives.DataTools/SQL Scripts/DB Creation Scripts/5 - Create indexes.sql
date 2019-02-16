use [BusinessIncentives]

/********************************/
/*        ColoradoBusiness      */
/********************************/

CREATE NONCLUSTERED INDEX [IX_EntityName] ON [dbo].[ColoradoBusiness]
(
	[EntityName] ASC
)

GO

/*************************/
/*      Opportunity      */
/*************************/
CREATE NONCLUSTERED INDEX [IX_FundingInstrumentType] ON [dbo].[Opportunity]
(
	[FundingInstrumentType] ASC
)

GO

/******************************/
/*      Opportunity VIEW      */
/******************************/

/* WORKS ONLY ON SQL SERVER STANDARD EDITION + */
/*
CREATE UNIQUE CLUSTERED INDEX [PK_OpportunityView] ON dbo.[OpportunityView] 
(
	[OpportunityID] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_FundingInstrumentType] ON [dbo].[OpportunityView]
(
	[FundingInstrumentType] ASC
)

GO
*/


