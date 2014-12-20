using N_Tier_Classes.DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Contracting_System
{
    /// <summary>
    /// This is a sttic class Contains All the genral functions To any project and the current project.
    /// </summary>
    public static class StandardClass
    {
        public static string menuHtml = "<ul class='mlddm'><li><a href='#'>المدير</a><ul><li><a href='#'>العاملين</a><ul><li><a href='#'>موردين</a><ul><li><a href='AddSupplier.aspx'>اضافة</a></li><li><a href='EditSupplier.aspx'>تعديل</a></li></ul></li><li><a href='#'>مقاولين الباطن</a><ul id='subContr'><li><a href='AddSubcontractor.aspx'>اضافة</a></li><li><a href='EditSubcontractors.aspx'>تعديل</a></li></ul></li><li><a href='#'>العمالة اليومية</a><ul><li><a href='AddDailyWorker.aspx'>اضافة</a></li><li><a href='EditDailyWorker.aspx'>تعديل</a></li></ul></li><li><a href='#'>الموظفين</a><ul><li><a href='AddEmployee.aspx'>اضافة</a></li><li><a href='EditEmployee.aspx'>تعديل</a></li></ul></li></ul></li><li><a href='#'>الخزن</a><ul><li><a href='ProjectSaver.aspx'>إيداع لخزنة المشروع</a></li><li><a href='#'>بنود الخزن</a><ul><li><a href='AddSaverItem.aspx'>اضافة</a></li><li><a href='EditSaverItem.aspx'>تعديل</a></li></ul></li></ul></li><li><a href='#'>المواد الخام</a><ul><li><a href='AddCategory.aspx'>اضافة</a></li><li><a href='EditCategory.aspx'>تعديل</a></li></ul></li><li><a href='#'>انواع المواد الخام</a><ul><li><a href='AddItems.aspx'>اضافة</a></li><li><a href='EditItems.aspx'>تعديل</a></li></ul></li><li><a href='#'>أعمال مقاولى الباطن</a><ul><li><a href='AddWorkCategory.aspx'>اضافة</a></li><li><a href='EditWorkCategory.aspx'>تعديل</a></li></ul></li><li><a href='#'>انواع اعمال مقاولى الباطن</a><ul><li><a href='AddWorkType.aspx'>اضافة</a></li><li><a href='EditWorkType.aspx'>تعديل</a></li></ul></li><li><a href='#'>وحدات القياس</a><ul><li><a href='AddMeasurementUnit.aspx'>اضافة</a></li></ul></li><li><a href='#'>فئات المصروفات</a><ul><li><a href='AddExpenseCategory.aspx'>اضافة</a></li><li><a href='EditExpenseCategory.aspx'>تعديل</a></li></ul></li><li><a href='#'>بنود المصروفات</a><ul><li><a href='AddExpenseItem.aspx'>اضافة</a></li><li><a href='EditExpenseItem.aspx'>تعديل</a></li></ul></li><li><a href='DailyCashbook.aspx'>دفتر اليومية النقدى</a></li><li><a href='DailySuppliesbook.aspx'>دفتر يومية التوريدات</a></li></ul></li><li><a href='#'>مشاريع</a><ul><li><a href='NewProject.aspx'>مشروع جديد</a></li><li><a href='SelectProject.aspx'>مشاريع جارية</a></li><li><a href='ReportFillterProject.aspx'>أرشيف المشروعات</a></li></ul></li><li><a href='#'>المستخلصات</a><ul><li><a href='CompanyExtract.aspx'>مستخلص الشركة</a></li><li><a href='SupplierExtract.aspx'>مستخلص موردين</a></li><li><a href='SubContractorExtract.aspx'>مستخلص مقاولين الباطن</a></li><li><a href='DailyWorkerExtract.aspx'>مستخلص العماله اليوميه</a></li></ul></li><li><a href='#'>تعديل</a><ul><li><a href='EditDailyCashbook.aspx'>دفتر اليوميه</a></li><li><a href='EditDailySuppliesbook.aspx'>دفتر التوريدات</a></li><li><a href='EditProjectSaver.aspx'>سحب/ايداع خزنة</a></li><li><a href='EditCompanyExtract.aspx'>مستخلص الشركة</a></li><li><a href='EditSupplierExtract.aspx'>مستخلص موردين</a></li><li><a href='EditSubContractorExtract.aspx'>مستخلص مقاولين الباطن</a></li><li><a href='EditDailyWorkerExtract.aspx'>مستخلص العماله اليوميه</a></li></ul></li><li><a href='#'>تقارير</a><ul><li><a href='ReportFillterCompany.aspx'>مستخلص شركه</a></li><li><a href='ReportFillterSupplier.aspx'>مستخلص مورد</a></li><li><a href='ReportFillterSub.aspx'>مستخلص مقاول</a></li><li><a href='ReportFillterWorkerExtract.aspx'>مستخلص العماله اليوميه</a></li><li><a href='ReportFillterProject.aspx'>أرشيف المشروعات</a></li><li><a href='ReportFillterDailyCashbook.aspx'>دفتر اليوميه</a></li><li><a href='ReportFillterDailySuppliesbook.aspx'>دفتر التوريدات</a></li></ul></li><li><a href='#'>المستخدمين</a><ul><li><a href='EditUserAndPassword.aspx'>اضافة وتعديل اسم مستخدم</a></li><li><a href='SelectRoles.aspx'>اسناد الصلاحيات</a></li><li><a href='SetRoles.aspx'>تصنيف الصلاحيات</a></li><li><a href='EditRoles.aspx'>تعديل تصنيف الصلاحيات</a></li></ul></li><li><a href='#'>قاعدة البيانات</a><ul><li><a href='BackupDatabase.aspx'>عمل نسخة احتياطية</a></li><li><a href='RestoreDatabase.aspx'>استرجاع من نسخة محفوظه</a></li></ul></li><li><a href='ContactUs.aspx'>مساعدة</a></li></ul>";

        public static string shortMenuHtml = @"<ul><li style='border-top: medium none;'><a href='NewProject.aspx'>مشروع جديد</a></li><li><a href='SelectProject.aspx'>مشاريع جارية</a></li><li><a href='DailySuppliesbook.aspx'>دفتر التوريدات</a></li><li><a href='DailyCashbook.aspx'>دفتر اليومية</a></li></ul>";
        #region Standard Extensions
        public static string SetSerialNumber(this string x)
        {
            long number = long.Parse(x);
            if (number < 9)
            {
                return "0000000" + number;
            }
            else if (number < 99)
            {
                return "000000" + number;
            }
            else if (number < 999)
            {
                return "00000" + number;
            }
            else if (number < 9999)
            {
                return "0000" + number;
            }
            else if (number < 99999)
            {
                return "000" + number;
            }
            else if (number < 999999)
            {
                return "00" + number;
            }
            else if (number < 9999999)
            {
                return "0" + number;
            }
            else
            {
                return number.ToString();
            }
        }

        public static string ToSerialNumberText(this long number)
        {
            if (number < 9)
            {
                return "0000000" + number;
            }
            else if (number < 99)
            {
                return "000000" + number;
            }
            else if (number < 999)
            {
                return "00000" + number;
            }
            else if (number < 9999)
            {
                return "0000" + number;
            }
            else if (number < 99999)
            {
                return "000" + number;
            }
            else if (number < 999999)
            {
                return "00" + number;
            }
            else if (number < 9999999)
            {
                return "0" + number;
            }
            else
            {
                return number.ToString();
            }
        }

        /// <summary>
        /// Return Current DateTime in SQL Format
        /// </summary>
        /// <param name="x"></param>
        /// <returns></returns>
        public static string Now(this object x)
        {
            return DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
        }

        public static string ToSqlFormat(this DateTime thisdate)
        {
            return thisdate.ToString("MM/dd/yyyy HH:mm:ss");
        }

        public static bool Security(this System.Web.UI.Page page)
        {
            
            string PageName = page.GetType().BaseType.Name + ".aspx";
            bool accessType = false;
            int userId = (int)page.Session["UserId"];
            if (userId > 0)
            {
                DataTable Tbl_Security = (DataTable)page.Session["Tbl_Security"];
                DataRow[] rows = Tbl_Security.Select("PageName = '" + PageName + "'");

                if (rows.Count() > 0)
                {
                    accessType = bool.Parse(rows[0]["Access"].ToString());
                }
            }
            if (!accessType)
            {
                page.Response.Redirect("Default.aspx");
            }
            return accessType;
        }
        #endregion
    }
}
