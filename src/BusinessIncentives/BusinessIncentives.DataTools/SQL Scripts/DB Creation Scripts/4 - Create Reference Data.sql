use [BusinessIncentives]

-- ***************************
-- Create PermissionLevel Data
-- ***************************

INSERT INTO [dbo].[PermissionLevel]
		   ([ID]
		   ,[Name])
	 VALUES
		   (1,'Administrator'),
		   (2,'OpportunityCreator'),
		   (3,'User')
GO

-- **************************
-- Create FundingLevel Data
-- **************************

INSERT INTO [dbo].[FundingLevel]
		   ([ID]
		   ,[Name])
	 VALUES
		   (1,'City'),
		   (2,'State'),
		   (3,'County'),
		   (4,'Region'),
		   (5,'Federal')
GO

-- *****************
--  Assistance Types
-- *****************

INSERT INTO [dbo].[AssistanceType]
		   ([Name])
	 VALUES
		('Advisory Service'),
		('Cash'),
		('Equipment Assistance'),
		('Grant'),
		('Loan'),
		('Other'),
		('Specialized Service'),
		('Tax Incentive'),
		('Training'),
		('Venture Capital')
GO

-- ****************************
-- Custom Opportunies Test Data
-- ****************************
USE [BusinessIncentives]
GO
SET IDENTITY_INSERT [dbo].[CustomOpportunity] ON 
GO
INSERT [dbo].[CustomOpportunity] ([ID], [Name], [Summary], [FundingLevelID], [FundingLevelDetails], [AssistanceTypeID], [OpeningDate], [ClosingDate], [WebLink], [PhoneNumber], [Email], [EligibilityKeywords], [Origin], [InsertedDate], [UpdatedDate]) VALUES (1, N'On-the-Job Training', N'OJT is a limited-duration agreement between an employer and the Mesa County Workforce Center, which provides the training of a new employee who is also a participant in the Workforce Innovation & Opportunity Act (WIOA) program. Employer benefits include reimbursement of 50 - 75% of a new employee''s wage rate for a set period of time, assessment screening of skill levels and work values needed for the job and the worker receives the knowledge and skills essential to the needs of the employer. On-the-Job Training is an excellent opportunity for employers to cultivate new, qualified employees while minimizing the cost of training. See website for more details.', 3, N'Mesa County', 9, CAST(N'2018-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2018-12-31T00:00:00.0000000' AS DateTime2), N'http://mcwfc.us/business/on-the-job-training/', N'970-248-7560', N'jobservice@mesacounty.us', N'employer;training;employees;employee;skill', N'Mesa County Workforce Center', CAST(N'2018-05-31T08:06:14.2433333' AS DateTime2), CAST(N'2018-05-31T08:06:14.2433333' AS DateTime2))
GO
INSERT [dbo].[CustomOpportunity] ([ID], [Name], [Summary], [FundingLevelID], [FundingLevelDetails], [AssistanceTypeID], [OpeningDate], [ClosingDate], [WebLink], [PhoneNumber], [Email], [EligibilityKeywords], [Origin], [InsertedDate], [UpdatedDate]) VALUES (2, N'Eileen Fisher Community Partnerships Grant', N'The Community Partnerships Grant evaluates and funds local nonprofits that specifically focus on the needs of their local communities. Cash grants of up to $2,500 are awarded on a quarterly basis and may be used for programming, operating expenses or event sponsorship. Gift certificates up to $250 are also available.', 1, N'Grand Junction', 4, CAST(N'2018-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2018-12-31T00:00:00.0000000' AS DateTime2), N'https://www.eileenfisher.com/grants/community-partnerships/', N'N/A', N'N/A', N'501(c)3;community;development;Environment;Human Rights;Women;Girls; Diversity;Inclusion
', N'Private small business grants for women', CAST(N'2018-05-31T08:07:47.6833333' AS DateTime2), CAST(N'2018-05-31T08:07:47.6833333' AS DateTime2))
GO
INSERT [dbo].[CustomOpportunity] ([ID], [Name], [Summary], [FundingLevelID], [FundingLevelDetails], [AssistanceTypeID], [OpeningDate], [ClosingDate], [WebLink], [PhoneNumber], [Email], [EligibilityKeywords], [Origin], [InsertedDate], [UpdatedDate]) VALUES (3, N'Community Development Block Grant (CDBG)', N'CDBG is a U.S. Department of Housing and Urban Development (HUD) program that provides Federal dollars to our community. Its purpose is to develop viable communities by providing decent housing and a suitable living environment, and by expanding economic opportunities, principally for persons of low and moderate incomes.', 1, N'Grand Junction', 4, CAST(N'2015-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-12-31T00:00:00.0000000' AS DateTime2), N'http://www.gjcity.org/siteassets/residents/community-development/cdbg/2018-cdbg-application-final-1-30-18.pdf', N'970-244-1491', NULL, N'Community;communities;housing; expanding economic opportunities;low income;moderate income;Childcare;Prevent homelessness;Reduce Homelessness;Neighborhood Program;special needs;human services;Home Repair', N'City of Grand Junction', CAST(N'2018-05-31T20:28:30.1766667' AS DateTime2), CAST(N'2018-05-31T20:28:30.1766667' AS DateTime2))
GO
INSERT [dbo].[CustomOpportunity] ([ID], [Name], [Summary], [FundingLevelID], [FundingLevelDetails], [AssistanceTypeID], [OpeningDate], [ClosingDate], [WebLink], [PhoneNumber], [Email], [EligibilityKeywords], [Origin], [InsertedDate], [UpdatedDate]) VALUES (4, N'2018 ART GRANT PROGRAM', NULL, NULL, NULL, 4, NULL, NULL, N'https://www.gjarts.org/grants/', N'(970) 254-3876', N'lorieg@gjcity.org', N'non-profit;arts;cultural;organizations;', N'City of Grand Junction', CAST(N'2018-05-31T20:34:04.6133333' AS DateTime2), CAST(N'2018-05-31T20:34:04.6133333' AS DateTime2))
GO
INSERT [dbo].[CustomOpportunity] ([ID], [Name], [Summary], [FundingLevelID], [FundingLevelDetails], [AssistanceTypeID], [OpeningDate], [ClosingDate], [WebLink], [PhoneNumber], [Email], [EligibilityKeywords], [Origin], [InsertedDate], [UpdatedDate]) VALUES (5, N'CASH COLLATERAL SUPPORT (CCS) – SSBCI', N'Cash Collateral Support (CCS) creates greater access to capital for small and medium sized businesses operating in Colorado that are experiencing difficulty securing credit due to collateral shortfalls. CCS uses small amounts of public resources to encourage private lender financing. The program provides a deposit of cash as collateral for a business loan or credit facility when a business cannot meet the lender’s collateral requirements.', 2, N'CO', 5, CAST(N'2015-12-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-12-31T00:00:00.0000000' AS DateTime2), N'https://www.chfainfo.com/', N'1-800-877-2432', N'Denver Office', N'Access;capital;grow;business;financing; developers;', N'Colorado Housing and Finance Authority', CAST(N'2018-05-31T20:37:11.3766667' AS DateTime2), CAST(N'2018-05-31T20:37:11.3766667' AS DateTime2))
GO
INSERT [dbo].[CustomOpportunity] ([ID], [Name], [Summary], [FundingLevelID], [FundingLevelDetails], [AssistanceTypeID], [OpeningDate], [ClosingDate], [WebLink], [PhoneNumber], [Email], [EligibilityKeywords], [Origin], [InsertedDate], [UpdatedDate]) VALUES (6, N'Rural Jump-Start', N'The Rural Jump-Start Zone program provides specific tax relief to New Businesses and New Hires of these businesses that are located in certain economically distressed areas of rural Colorado and align with local or regional state higher education institutions in order to promote economic development in these areas. This program is based on Senate Bill 15-282, and codified under Colorado Revised Statutes 39-30.5-101.', 2, N'CO', 8, CAST(N'2015-12-01T00:00:00.0000000' AS DateTime2), CAST(N'2020-12-31T00:00:00.0000000' AS DateTime2), N'https://choosecolorado.com/doing-business/incentives-financing/rural-jump-start-program/', N'303-892-3743', N'Ken Jensen', N'tax relief;new business;state sales & use tax;county and municipal personal property taxes;state income taxes for the new business;new hires;jump-start zones', N'Colorado Office of Economic Development and International Trade (OEDIT)', CAST(N'2018-05-31T20:38:29.9900000' AS DateTime2), CAST(N'2018-05-31T20:38:29.9900000' AS DateTime2))
GO
INSERT [dbo].[CustomOpportunity] ([ID], [Name], [Summary], [FundingLevelID], [FundingLevelDetails], [AssistanceTypeID], [OpeningDate], [ClosingDate], [WebLink], [PhoneNumber], [Email], [EligibilityKeywords], [Origin], [InsertedDate], [UpdatedDate]) VALUES (7, N'CERTIFIED CAPITAL COMPANIES (CAPCO) PROGRAM', N'The Certified Capital Companies Program (CAPCO) makes venture capital funds available to new or expanding small businesses throughout Colorado. The program encourages new business development and expansions of businesses by making a $75 million statewide pool available for investment throughout Colorado, and a $25 million rural pool available for investment in designated rural counties in Colorado.', 2, N'CO', 10, CAST(N'2002-04-01T00:00:00.0000000' AS DateTime2), CAST(N'2025-12-31T00:00:00.0000000' AS DateTime2), N'https://choosecolorado.com/doing-business/incentives-financing/certified-capital-companies-capco-program/', N'303-892-3840', N'john.reece@state.co.us', N'new business;expanding small business;new business development;business expansion;venture capital;rural counties;employment', N'Colorado Office of Economic Development and International Trade (OEDIT)', CAST(N'2018-05-31T20:40:42.3533333' AS DateTime2), CAST(N'2018-05-31T20:40:42.3533333' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[CustomOpportunity] OFF
GO

