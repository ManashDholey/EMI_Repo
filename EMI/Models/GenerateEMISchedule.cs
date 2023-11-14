using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EMI.Models
{
    public class GenerateEMISchedule
    {
        public long Id { get; set; }
        [Required]
        public long EmiPlanMasterId { get; set; }
        public string EmiPlanMasterSelect { get; set; }
        [Required]
        public decimal LoanAmount { get; set; }
        public bool Status { get; set; }
        [Required]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime LoanDate { get; set; }
        public DateTime DueDate { get; set; }
        public decimal EmiAmount { get; set; }
        [Required]
        public int Tenure { get; set; }
        [Required]
        public string ROI { get; set; }

    }
}