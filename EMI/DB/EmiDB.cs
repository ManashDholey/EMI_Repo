using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using EMI.Models;
using System.Globalization;
using System.Reflection;
using EMI.Utils;

namespace EMI.DB
{
    public class EmiDB
    {
        //declare connection string
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        //Return list of all EmiPlan
        public List<EmiPlanMaster> EmiPlanListAll()
        {
            List<EmiPlanMaster> lst = new List<EmiPlanMaster>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("SP_InsertUpdateSelectEMI_Plan", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@StatementType", "Select");
                SqlDataReader rdr = com.ExecuteReader();
                while (rdr.Read())
                {
                    lst.Add(new EmiPlanMaster
                    {
                        Id = Convert.ToInt64(rdr["Id"]),
                        PlanName = rdr["PlanName"].ToString(),
                        ROI =Convert.ToString(rdr["ROI"]),
                        Tenure= Convert.ToInt32(rdr["Tenure"]),
                        Status = Convert.ToBoolean(rdr["Status"])
                    });
                }
                return lst;
            }
        }

        //Method for Adding an EmiPlan
        public int EmiPlanAdd(EmiPlanMaster emiPlan)
        {
            try
            {
                int i;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand com = new SqlCommand("SP_InsertUpdateSelectEMI_Plan", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@PlanName", emiPlan.PlanName);
                    com.Parameters.AddWithValue("@ROI", emiPlan.ROI);
                    com.Parameters.AddWithValue("@Tenure", emiPlan.Tenure);
                    com.Parameters.AddWithValue("@Status", emiPlan.Status);
                    com.Parameters.AddWithValue("@StatementType", "Insert");
                    i = com.ExecuteNonQuery();
                }
                return i;
            }catch(Exception ex) {
                return -1;
            }
        }

        //Method for Updating EmiPlanMaster record
        public int EmiPlanUpdate(EmiPlanMaster emiPlan)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("SP_InsertUpdateSelectEMI_Plan", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Id", emiPlan.Id);
                com.Parameters.AddWithValue("@PlanName", emiPlan.PlanName);
                com.Parameters.AddWithValue("@ROI", emiPlan.ROI);
                com.Parameters.AddWithValue("@Tenure", emiPlan.Tenure);
                com.Parameters.AddWithValue("@Status", emiPlan.Status);
                com.Parameters.AddWithValue("@StatementType", "Update");
                i = com.ExecuteNonQuery();
            }
            return i;
        }


        //Return list of all EmiPlan
        public List<GenerateEMISchedule> GenerateEMIScheduleListAll(long id, decimal LoanAmount=0)
        {
            List<GenerateEMISchedule> lst = new List<GenerateEMISchedule>();
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("SP_InsertUpdateSelectGenerateEMISchedule", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@StatementType", "Select");
                com.Parameters.AddWithValue("@EmiPlanMasterId", id);
                if (LoanAmount > 0)
                {
                    com.Parameters.AddWithValue("@LoanAmount", LoanAmount);
                }
                SqlDataReader rdr = com.ExecuteReader();
               
                while (rdr.Read())
                {
                    //DateTime.TryParseExact(rdr["LoanDate"].ToString(),
                    //                   "yyyy-MM-dd",
                    //                   CultureInfo.InvariantCulture,
                    //                   DateTimeStyles.None,
                    //                   out dt);
                  var d=  Utils.Util.SetDateFormat(rdr["LoanDate"].ToString());
                    var d1 = Utils.Util.SetDateFormat(rdr["DueDate"].ToString());
                    lst.Add(new GenerateEMISchedule
                    {
                        Id = Convert.ToInt64(rdr["Id"]),
                        EmiPlanMasterId = Convert.ToInt64(rdr["EmiPlanMasterId"]),
                        LoanAmount = Convert.ToDecimal(rdr["LoanAmount"]),
                        Status = Convert.ToBoolean(rdr["Status"]),
                        EmiAmount= Convert.ToDecimal(rdr["EmiAmount"]),
                        LoanDate =DateTime.Parse(d),
                        DueDate= DateTime.Parse(d1),
                    });
                }
                return lst;
            }
        }
        public int GenerateEMIScheduleAdd(GenerateEMISchedule emiPlan)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("SP_InsertUpdateSelectGenerateEMISchedule", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@EmiPlanMasterId", emiPlan.EmiPlanMasterId);
                com.Parameters.AddWithValue("@LoanMount", emiPlan.LoanAmount);
                com.Parameters.AddWithValue("@EmiAmount", emiPlan.EmiAmount);
                com.Parameters.AddWithValue("@Status", 1);
                com.Parameters.AddWithValue("@LoanDate", emiPlan.LoanDate);
                com.Parameters.AddWithValue("@DueDate", emiPlan.DueDate);
                com.Parameters.AddWithValue("@StatementType", "Insert");
                i = com.ExecuteNonQuery();
            }
            return i;
        }

        ////Method for Deleting an Employee
        //public int Delete(int ID)
        //{
        //    int i;
        //    using (SqlConnection con = new SqlConnection(cs))
        //    {
        //        con.Open();
        //        SqlCommand com = new SqlCommand("DeleteEmployee", con);
        //        com.CommandType = CommandType.StoredProcedure;
        //        com.Parameters.AddWithValue("@Id", ID);
        //        i = com.ExecuteNonQuery();
        //    }
        //    return i;
        //}
    }
}