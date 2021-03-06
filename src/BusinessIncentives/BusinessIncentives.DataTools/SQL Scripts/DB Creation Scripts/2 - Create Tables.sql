USE [BusinessIncentives]
GO
/****** Object:  Table [dbo].[AssistanceType]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssistanceType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AssistanceType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ColoradoBusiness]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ColoradoBusiness](
	[EntityId] [bigint] NOT NULL,
	[EntityName] [nvarchar](400) NULL,
	[PrincipalAddress1] [nvarchar](400) NULL,
	[PrincipalAddress2] [nvarchar](400) NULL,
	[PrincipalCity] [nvarchar](400) NULL,
	[PrincipalState] [nvarchar](40) NULL,
	[PrincipalZipCode] [nvarchar](40) NULL,
	[PrincipalCountry] [nvarchar](400) NULL,
	[EntityStatus] [nvarchar](400) NULL,
	[JurisdictionOfFormation] [nvarchar](400) NULL,
	[EntityType] [nvarchar](400) NULL,
	[EntityFormDate] [datetime2](7) NULL,
	[InsertedDate] [datetime2](7) NULL,
	[UpdatedDate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[EntityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomOpportunity]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomOpportunity](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](300) NOT NULL,
	[Summary] [nvarchar](max) NULL,
	[FundingLevelID] [smallint] NULL,
	[FundingLevelDetails] [nvarchar](300) NULL,
	[AssistanceTypeID] [int] NULL,
	[OpeningDate] [datetime2](7) NULL,
	[ClosingDate] [datetime2](7) NULL,
	[WebLink] [nvarchar](300) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Email] [nvarchar](300) NULL,
	[EligibilityKeywords] [nvarchar](2000) NULL,
	[Origin] [nvarchar](300) NULL,
	[InsertedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CustomOpportunity] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FieldCodedValue]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FieldCodedValue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OriginID] [int] NOT NULL,
	[FieldName] [nvarchar](100) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[InsertedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_FieldCodedValues] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FieldCodedValueOrigin]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FieldCodedValueOrigin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[InsertedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_FieldCodedValueOrigin] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FundingLevel]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FundingLevel](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_FundingLevel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opportunity](
	[OpportunityID] [nvarchar](30) NOT NULL,
	[OpportunityTitle] [nvarchar](300) NULL,
	[OpportunityNumber] [nvarchar](50) NULL,
	[OpportunityCategory] [nvarchar](4) NULL,
	[OpportunityCategoryExplanation] [nvarchar](300) NULL,
	[FundingInstrumentType] [nvarchar](5) NULL,
	[CategoryOfFundingActivity] [nvarchar](200) NULL,
	[CategoryExplanation] [nvarchar](4000) NULL,
	[CFDANumbers] [nvarchar](200) NULL,
	[EligibleApplicants] [nvarchar](200) NULL,
	[AdditionalInformationOnEligibility] [nvarchar](4000) NULL,
	[AgencyCode] [nvarchar](300) NULL,
	[AgencyName] [nvarchar](300) NULL,
	[PostDate] [datetime2](7) NULL,
	[CloseDate] [datetime2](7) NULL,
	[CloseDateExplanation] [nvarchar](4000) NULL,
	[ExpectedNumberOfAwards] [nvarchar](20) NULL,
	[EstimatedTotalProgramFunding] [nvarchar](20) NULL,
	[AwardCeiling] [nvarchar](20) NULL,
	[AwardFloor] [nvarchar](20) NULL,
	[LastUpdatedDate] [datetime2](7) NULL,
	[EstimatedSynopsisPostDate] [nvarchar](8) NULL,
	[FiscalYear] [nvarchar](4) NULL,
	[EstimatedSynopsisCloseDate] [nvarchar](8) NULL,
	[EstimatedSynopsisCloseDateExplanation] [nvarchar](300) NULL,
	[EstimatedAwardDate] [nvarchar](8) NULL,
	[EstimatedProjectStartDate] [nvarchar](8) NULL,
	[ArchiveDate] [datetime2](7) NULL,
	[Description] [nvarchar](max) NULL,
	[CostSharingOrMatchingRequirement] [nvarchar](4) NULL,
	[AdditionalInformationText] [nvarchar](300) NULL,
	[AdditionalInformationURL] [nvarchar](300) NULL,
	[GrantorContactText] [nvarchar](2500) NULL,
	[GrantorContactEmailDescription] [nvarchar](300) NULL,
	[GrantorContactEmail] [nvarchar](300) NULL,
	[GrantorContactName] [nvarchar](2500) NULL,
	[GrantorContactPhoneNumber] [nvarchar](100) NULL,
	[Version] [nchar](10) NULL,
	[InsertedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Opportunity] PRIMARY KEY CLUSTERED 
(
	[OpportunityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityProgramXRef]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityProgramXRef](
	[OpportunityID] [nvarchar](30) NOT NULL,
	[ProgramNumber] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_OpportunityProgramXRef] PRIMARY KEY CLUSTERED 
(
	[OpportunityID] ASC,
	[ProgramNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermissionLevel]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionLevel](
	[ID] [smallint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PermissionLevel] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program](
	[ProgramNumber] [nvarchar](30) NOT NULL,
	[ProgramTitle] [nvarchar](800) NULL,
	[PopularName_020] [nvarchar](max) NULL,
	[FederalAgency_030] [nvarchar](500) NULL,
	[Authorization_040] [nvarchar](max) NULL,
	[Objectives_050] [nvarchar](max) NULL,
	[TypesOfAssistance_060] [nvarchar](4000) NULL,
	[UsesAndUseRestrictions_070] [nvarchar](max) NULL,
	[ApplicantEligibility_081] [nvarchar](max) NULL,
	[BeneficiaryEligibility_082] [nvarchar](max) NULL,
	[CredentialsDocumentation_083] [nvarchar](max) NULL,
	[PreapplicationCoordination_091] [nvarchar](max) NULL,
	[ApplicationProcedures_092] [nvarchar](max) NULL,
	[AwardProcedure_093] [nvarchar](max) NULL,
	[Deadlines_094] [nvarchar](max) NULL,
	[RangeOfApprovalDisapprovalTime_095] [nvarchar](max) NULL,
	[Appeals_096] [nvarchar](max) NULL,
	[Renewals_097] [nvarchar](max) NULL,
	[FormulaAndMatchingRequirements_101] [nvarchar](max) NULL,
	[LengthAndTimePhasingOfAssistance_102] [nvarchar](max) NULL,
	[Reports_111] [nvarchar](max) NULL,
	[Audits_112] [nvarchar](max) NULL,
	[Records_113] [nvarchar](max) NULL,
	[AccountIdentification_121] [nvarchar](3000) NULL,
	[Obligations_122] [nvarchar](max) NULL,
	[RangeAndAverageOfFinancialAssistance_123] [nvarchar](max) NULL,
	[ProgramAccomplishments_130] [nvarchar](max) NULL,
	[RegulationsGuidelinesAndLiterature_140] [nvarchar](max) NULL,
	[RegionalOrLocalOffice_151] [nvarchar](max) NULL,
	[HeadquartersOffice_152] [nvarchar](max) NULL,
	[WebsiteAddress_153] [nvarchar](800) NULL,
	[RelatedPrograms_160] [nvarchar](4000) NULL,
	[ExamplesOfFundedProjects_170] [nvarchar](max) NULL,
	[CriteriaForSelectingProposals_180] [nvarchar](max) NULL,
	[PublishedDate] [nvarchar](100) NULL,
	[ParentShortname] [nvarchar](200) NULL,
	[URL] [nvarchar](300) NULL,
	[Recovery] [nvarchar](25) NULL,
	[InsertedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[ProgramNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [varbinary](max) NOT NULL,
	[Salt] [varbinary](max) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[PermissionLevelID] [smallint] NULL,
	[InsertedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCustomOpportunityXRef]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCustomOpportunityXRef](
	[UserID] [int] NOT NULL,
	[CustomOpportunityID] [bigint] NOT NULL,
 CONSTRAINT [PK_UserCustomOpportunityXRef] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[CustomOpportunityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserOpportunityXRef]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserOpportunityXRef](
	[UserID] [int] NOT NULL,
	[OpportunityID] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_UserOpportunityXRef] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[OpportunityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProgramXRef]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProgramXRef](
	[UserID] [int] NOT NULL,
	[ProgramNumber] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_UserProgramXRef] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[ProgramNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSavedSearch]    Script Date: 5/31/2018 4:57:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSavedSearch](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[SearchJsonData] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_UserSavedSearch] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ColoradoBusiness] ADD  CONSTRAINT [DF_ColoradoBusinesses_inserteddate]  DEFAULT (getdate()) FOR [InsertedDate]
GO
ALTER TABLE [dbo].[ColoradoBusiness] ADD  CONSTRAINT [DF_ColoradoBusinesses_updateddate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[CustomOpportunity] ADD  CONSTRAINT [DF_CustomOpportunity_InsertedDate]  DEFAULT (getdate()) FOR [InsertedDate]
GO
ALTER TABLE [dbo].[CustomOpportunity] ADD  CONSTRAINT [DF_CustomOpportunity_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[FieldCodedValue] ADD  CONSTRAINT [DF_FieldCodedValues_InsertedDate]  DEFAULT (getdate()) FOR [InsertedDate]
GO
ALTER TABLE [dbo].[FieldCodedValue] ADD  CONSTRAINT [DF_FieldCodedValues_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[FieldCodedValueOrigin] ADD  CONSTRAINT [DF_FieldCodedValueOrigin_InsertedDate]  DEFAULT (getdate()) FOR [InsertedDate]
GO
ALTER TABLE [dbo].[FieldCodedValueOrigin] ADD  CONSTRAINT [DF_FieldCodedValueOrigin_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[Opportunity] ADD  CONSTRAINT [DF_Opportunity_InsertedDate]  DEFAULT (getdate()) FOR [InsertedDate]
GO
ALTER TABLE [dbo].[Opportunity] ADD  CONSTRAINT [DF_Opportunity_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[Program] ADD  CONSTRAINT [DF_Program_InsertedDate]  DEFAULT (getdate()) FOR [InsertedDate]
GO
ALTER TABLE [dbo].[Program] ADD  CONSTRAINT [DF_Program_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_InsertedDate]  DEFAULT (getdate()) FOR [InsertedDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_UpdatedDate]  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[CustomOpportunity]  WITH CHECK ADD  CONSTRAINT [FK_CustomOpportunity_AssistanceType] FOREIGN KEY([AssistanceTypeID])
REFERENCES [dbo].[AssistanceType] ([ID])
GO
ALTER TABLE [dbo].[CustomOpportunity] CHECK CONSTRAINT [FK_CustomOpportunity_AssistanceType]
GO
ALTER TABLE [dbo].[CustomOpportunity]  WITH CHECK ADD  CONSTRAINT [FK_CustomOpportunity_FundingLevel] FOREIGN KEY([FundingLevelID])
REFERENCES [dbo].[FundingLevel] ([ID])
GO
ALTER TABLE [dbo].[CustomOpportunity] CHECK CONSTRAINT [FK_CustomOpportunity_FundingLevel]
GO
ALTER TABLE [dbo].[FieldCodedValue]  WITH CHECK ADD  CONSTRAINT [FK_FieldCodedValues_FieldCodedValueOrigin] FOREIGN KEY([OriginID])
REFERENCES [dbo].[FieldCodedValueOrigin] ([ID])
GO
ALTER TABLE [dbo].[FieldCodedValue] CHECK CONSTRAINT [FK_FieldCodedValues_FieldCodedValueOrigin]
GO
ALTER TABLE [dbo].[OpportunityProgramXRef]  WITH CHECK ADD  CONSTRAINT [FK_OpportunityProgramXRef_Opportunity] FOREIGN KEY([OpportunityID])
REFERENCES [dbo].[Opportunity] ([OpportunityID])
GO
ALTER TABLE [dbo].[OpportunityProgramXRef] CHECK CONSTRAINT [FK_OpportunityProgramXRef_Opportunity]
GO
ALTER TABLE [dbo].[OpportunityProgramXRef]  WITH CHECK ADD  CONSTRAINT [FK_OpportunityProgramXRef_Program] FOREIGN KEY([ProgramNumber])
REFERENCES [dbo].[Program] ([ProgramNumber])
GO
ALTER TABLE [dbo].[OpportunityProgramXRef] CHECK CONSTRAINT [FK_OpportunityProgramXRef_Program]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([PermissionLevelID])
REFERENCES [dbo].[PermissionLevel] ([ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User]
GO
ALTER TABLE [dbo].[UserCustomOpportunityXRef]  WITH CHECK ADD  CONSTRAINT [FK_UserCustomOpportunityXRef_CustomOpportunity] FOREIGN KEY([CustomOpportunityID])
REFERENCES [dbo].[CustomOpportunity] ([ID])
GO
ALTER TABLE [dbo].[UserCustomOpportunityXRef] CHECK CONSTRAINT [FK_UserCustomOpportunityXRef_CustomOpportunity]
GO
ALTER TABLE [dbo].[UserCustomOpportunityXRef]  WITH CHECK ADD  CONSTRAINT [FK_UserCustomOpportunityXRef_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserCustomOpportunityXRef] CHECK CONSTRAINT [FK_UserCustomOpportunityXRef_User]
GO
ALTER TABLE [dbo].[UserOpportunityXRef]  WITH CHECK ADD  CONSTRAINT [FK_UserOpportunityXRef_Opportunity] FOREIGN KEY([OpportunityID])
REFERENCES [dbo].[Opportunity] ([OpportunityID])
GO
ALTER TABLE [dbo].[UserOpportunityXRef] CHECK CONSTRAINT [FK_UserOpportunityXRef_Opportunity]
GO
ALTER TABLE [dbo].[UserOpportunityXRef]  WITH CHECK ADD  CONSTRAINT [FK_UserOpportunityXRef_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserOpportunityXRef] CHECK CONSTRAINT [FK_UserOpportunityXRef_User]
GO
ALTER TABLE [dbo].[UserProgramXRef]  WITH CHECK ADD  CONSTRAINT [FK_UserProgramXRef_Program] FOREIGN KEY([ProgramNumber])
REFERENCES [dbo].[Program] ([ProgramNumber])
GO
ALTER TABLE [dbo].[UserProgramXRef] CHECK CONSTRAINT [FK_UserProgramXRef_Program]
GO
ALTER TABLE [dbo].[UserProgramXRef]  WITH CHECK ADD  CONSTRAINT [FK_UserProgramXRef_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserProgramXRef] CHECK CONSTRAINT [FK_UserProgramXRef_User]
GO
