using EMI.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EMI.Utils
{
    public static class Util
    {
        public static List<SelectListItem> GetEmiPlanMasterList(List<EmiPlanMaster> emiPlans)
        {
            var items = new List<SelectListItem>();
            foreach (var data in emiPlans)
            {
                items.Add(new SelectListItem()
                {
                    Text = $"{data.PlanName}({data.Tenure})",
                    Value = $"{data.Id}|{data.Tenure}|{data.ROI}"
                    // Put all sorts of business logic in here
                    //Selected = model.Subject.ExamType > 0 ? true : false
                });
            }
            return items;
        }
        public static string SetDateFormat(string inputString)
        {
            try
            {
                DateTime DateInput = new DateTime();
                //Oct 01, 2022
                var formats = new[] { "Mon-DD-YYYY", "DD-Mon-YYYY", "YYYYY-Mon-DD", "Mon dd, yyyy", "Mon DD, yyyy", "Mon DD, YYYY", "DD Mon, YYYY", "YYYY, Mon DD", "yyyy-MM-dd HH:mm:ss", "DD-MM-YYYY", "dd-MM-yyyy", "YYYY-DD-MM", "MM-DD-YYYY", "dd-MM-yyyy HH:mm:ss", "MM-dd-yyyy HH:mm:ss", "yyyy-mm-dd", "dd-mm-yyyy", "mm-dd-yyyy", "yyyy-MM-dd", "dd-MM-yyyy", "MM-dd-yyyy", "dd/MM/yyyy HH:mm:ss", "MM/dd/yyyy HH:mm:ss", "MM/dd/yyyy HH:mm:ss", "dd/MM/yyyy", "M/d/yyyy h:mm:ss tt", "M/d/yyyy h:mm tt", "MM/dd/yyyy hh:mm:ss", "M/d/yyyy h:mm:ss", "M/d/yyyy hh:mm tt", "M/d/yyyy hh tt", "M/d/yyyy h:mm", "M/d/yyyy h:mm", "MM/dd/yyyy hh:mm", "M/dd/yyyy hh:mm", "M/dd/yyyy", "DD/MM/YYYY" };
                if (DateTime.TryParseExact(inputString.Trim(), formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateInput))
                    return DateInput.ToString("yyyy-MM-dd HH:mm:ss");
                if (DateTime.TryParseExact(inputString, formats, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateInput))
                    return DateInput.ToString("yyyy-MM-dd HH:mm:ss");
                else
                {
                    DateTime dDate = new DateTime();
                    DateTime dDat = new DateTime();
                    if (DateTime.TryParse(inputString.Trim(), out dDate))
                    {
                        string.Format("{0:MM/dd/yyyy}", dDat);
                        var dat = DateTime.ParseExact(dDat.ToString(), "MM/dd/yyyy", CultureInfo.InvariantCulture).ToString("MM/dd/yyyy");
                        return dat;
                    }
                    else
                    {
                        if (DateTime.TryParse(inputString.Trim(), out dDat))
                        {
                            string.Format("{0:d/MM/yyyy}", dDate);
                            return dDate.ToString("MM/dd/yyyy");
                        }
                        else
                            return null;
                    }
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}