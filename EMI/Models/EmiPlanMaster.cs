using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EMI.Models
{
    public class EmiPlanMaster
    {
        public long Id { get; set; }
        [Required]
        public string PlanName { get; set; }
        public bool Status { get; set; }
        [Required]
        public int Tenure { get; set; }
        [Required]
        public string ROI { get; set; }

    }
    public class EMICal
    {
        public decimal P { get; set; }
        public int T { get; set; }
        public int R { get; set; }
    }
}