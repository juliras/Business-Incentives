//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Opportunity
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Opportunity()
        {
            this.Programs = new HashSet<Program>();
            this.Users = new HashSet<User>();
        }
    
        public string OpportunityID { get; set; }
        public string OpportunityTitle { get; set; }
        public string OpportunityNumber { get; set; }
        public string OpportunityCategory { get; set; }
        public string OpportunityCategoryExplanation { get; set; }
        public string FundingInstrumentType { get; set; }
        public string CategoryOfFundingActivity { get; set; }
        public string CategoryExplanation { get; set; }
        public string CFDANumbers { get; set; }
        public string EligibleApplicants { get; set; }
        public string AdditionalInformationOnEligibility { get; set; }
        public string AgencyCode { get; set; }
        public string AgencyName { get; set; }
        public Nullable<System.DateTime> PostDate { get; set; }
        public Nullable<System.DateTime> CloseDate { get; set; }
        public string CloseDateExplanation { get; set; }
        public string ExpectedNumberOfAwards { get; set; }
        public string EstimatedTotalProgramFunding { get; set; }
        public string AwardCeiling { get; set; }
        public string AwardFloor { get; set; }
        public Nullable<System.DateTime> LastUpdatedDate { get; set; }
        public string EstimatedSynopsisPostDate { get; set; }
        public string FiscalYear { get; set; }
        public string EstimatedSynopsisCloseDate { get; set; }
        public string EstimatedSynopsisCloseDateExplanation { get; set; }
        public string EstimatedAwardDate { get; set; }
        public string EstimatedProjectStartDate { get; set; }
        public Nullable<System.DateTime> ArchiveDate { get; set; }
        public string Description { get; set; }
        public string CostSharingOrMatchingRequirement { get; set; }
        public string AdditionalInformationText { get; set; }
        public string AdditionalInformationURL { get; set; }
        public string GrantorContactText { get; set; }
        public string GrantorContactEmailDescription { get; set; }
        public string GrantorContactEmail { get; set; }
        public string GrantorContactName { get; set; }
        public string GrantorContactPhoneNumber { get; set; }
        public string Version { get; set; }
        public System.DateTime InsertedDate { get; set; }
        public System.DateTime UpdatedDate { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Program> Programs { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<User> Users { get; set; }
    }
}
