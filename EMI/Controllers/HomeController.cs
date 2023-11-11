using EMI.DB;
using EMI.Models;
using EMI.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EMI.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult ADDEmiPlan()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ADDEmiPlan(EmiPlanMaster emiPlan)
        {
            if (ModelState.IsValid) {
                EmiDB dB=new EmiDB();
                emiPlan.Status = true;
               var res= dB.EmiPlanAdd(emiPlan);
                if (res > 0)
                {
                    ViewBag.Message = "Emi Plan added successfully done!";
                    ViewBag.Status = true;
                }
                else
                {
                    ViewBag.Message = "Something goes wrong, please try again later!";
                    ViewBag.Status = false;
                }
                dB = null;
            }
            return View();
        }

        [HttpGet]
        public ActionResult GenerateEMISchedule()
        {
            EmiDB dB = new EmiDB();
            var master = dB.EmiPlanListAll();
            var model = (IEnumerable <GenerateEMISchedule>) dB.GenerateEMIScheduleListAll(master.FirstOrDefault().Id);
            ViewBag.EmiPlan = Util.GetEmiPlanMasterList(master);
            return View(model);
        }
        [HttpPost]
        public ActionResult GenerateEMISchedule(GenerateEMISchedule generateEMI)
        {
            EmiDB dB = new EmiDB();
            generateEMI.EmiPlanMasterId = Convert.ToInt64(generateEMI.EmiPlanMasterSelect.Split('|')[0]);
            if (ModelState.IsValid)
            {
                EMICal emical = new EMICal();
                emical.P = generateEMI.LoanAmount;
                emical.R = Convert.ToInt32(generateEMI.ROI);
                emical.T = generateEMI.Tenure;
                var emi = FunCalculateEMI(emical);

                for (int i = 0;i< generateEMI.Tenure; i++)
                {
                    generateEMI.EmiAmount = Convert.ToDecimal(emi);
                    if (i > 0)
                    {
                        
                     generateEMI.DueDate = generateEMI.LoanDate.AddMonths(i);
                        
                    }
                    else
                    {
                        generateEMI.DueDate = generateEMI.LoanDate;
                    }
                   
                    dB.GenerateEMIScheduleAdd(generateEMI);
                }

            }
            
            var model = (IEnumerable<GenerateEMISchedule>)dB.GenerateEMIScheduleListAll(generateEMI.EmiPlanMasterId, generateEMI.LoanAmount);
            var master = dB.EmiPlanListAll();
            ViewBag.EmiPlan = Util.GetEmiPlanMasterList(master);
            return View(model);
        }
        [HttpPost]
        public JsonResult CalculateEMI(EMICal emi)
        {

            return Json(FunCalculateEMI(emi), JsonRequestBehavior.AllowGet);
        }
        private decimal FunCalculateEMI(EMICal emi) {
            //var d =(decimal) emi.R/100;
            // var monthlyIntRet = (decimal)d /12;
            //decimal EMI = (emi.P + (emi.P * monthlyIntRet)) / emi.T;
            ////double EMI = (emi.P * monthlyIntRet) / (1 - Math.Pow(1 +  monthlyIntRet, -emi.T));
            ///
            var addInt = emi.P * emi.R / 100;
            var total = emi.P + addInt;
            var EMI = total / emi.T;

            return EMI;
        }
        public ActionResult About()
        {

            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}