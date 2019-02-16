﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BusinessIncentives.Common.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class BusinessIncentivesContext : DbContext
    {
        public BusinessIncentivesContext()
            : base("name=BusinessIncentivesContext")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Program> Programs { get; set; }
        public virtual DbSet<ProgramView> ProgramViews { get; set; }
        public virtual DbSet<Opportunity> Opportunities { get; set; }
        public virtual DbSet<PermissionLevel> PermissionLevels { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<FundingLevel> FundingLevels { get; set; }
        public virtual DbSet<FieldCodedValue> FieldCodedValues { get; set; }
        public virtual DbSet<FieldCodedValueOrigin> FieldCodedValueOrigins { get; set; }
        public virtual DbSet<ColoradoBusiness> ColoradoBusinesses { get; set; }
        public virtual DbSet<AssistanceType> AssistanceTypes { get; set; }
        public virtual DbSet<CustomOpportunity> CustomOpportunities { get; set; }
        public virtual DbSet<UserSavedSearch> UserSavedSearches { get; set; }
        public virtual DbSet<OpportunityView> OpportunityViews { get; set; }
    }
}
