<%@ Page Title="" Language="C#" MasterPageFile="Users.master" AutoEventWireup="true"
    CodeBehind="NewProject.aspx.cs" Inherits="Contracting_System.NewProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="UsersheadContent" runat="server">
    <style type="text/css">
        .auto-style1
        {
            height: 32px;
        }
        
        .auto-style2
        {
            height: 32px;
            width: 160px;
        }
        
        .auto-style3
        {
            width: 261px;
        }
        .style9
        {
            height: 21px;
            width: 156px;
        }
        .style11
        {
            height: 21px;
            width: 176px;
        }
        .style14
        {
            height: 16px;
            width: 163px;
        }
        .style15
        {
            height: 16px;
            width: 156px;
        }
        #cbo_Safe
        {
            width: 202px;
        }
        #cbo_Currency
        {
            width: 199px;
        }
        #txt_Description
        {
            width: 388px;
            height: 25px;
        }
        #cbo_Currency0
        {
            width: 199px;
        }
        #txt_ReceiptNo
        {
            width: 198px;
        }
        #txt_BillDeposit
        {
            width: 200px;
        }
        #Select5
        {
            width: 109px;
        }
        #datepicker2
        {
            width: 102px;
        }
        .style16
        {
            height: 21px;
            width: 147px;
        }
        .style17
        {
            height: 16px;
            width: 147px;
        }
        #Cbo_SubContractorNewProject
        {
            width: 116px;
        }
        #txt_WorkTypeNewProject
        {
            width: 124px;
        }
        #cbo_WorkTypeNewProject
        {
            width: 115px;
        }
        .style18
        {
            height: 21px;
            width: 83px;
        }
        .style22
        {
            height: 21px;
            width: 131px;
        }
        
        .tbl_th_buttonRemove
        {
            width: 74px;
            background-color: White;
        }
        .tbl_td_buttonRemove
        {
            width: 74px;
        }
        #WorkerName
        {
            width: 193px;
        }
        #WorkerName0
        {
            width: 193px;
        }
        #cbo_DailyWorker
        {
            width: 156px;
        }
        #cbo_Employees
        {
            width: 131px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#tabs").tabs();
        });

        $(function () {
            $("#txt_ProjectStartDate").datepicker({ dateFormat: "dd/mm/yy" });
            $("#txt_ReceptionLocationDate").datepicker({ dateFormat: "dd/mm/yy" });
            $("#txt_DailyWorkerStartDate").datepicker({ dateFormat: "dd/mm/yy" });
            $("#txt_ProjectStartTechnicalDate").datepicker({ dateFormat: "dd/mm/yy" });
            $("#txt_ProjectEndDate").datepicker({ dateFormat: "dd/mm/yy" });
            $("#DailyWorkStartDate").datepicker({ dateFormat: "dd/mm/yy" });
            $("#DailyWorkEndDate").datepicker({ dateFormat: "dd/mm/yy" });
        });

        $(function () {
            /*
            var spinner = $("#txt_ProjectPeriod").spinner();
            spinner += $("#spinner0").spinner();
            $("#destroy").click(function () {
            if (spinner.data("ui-spinner")) {
            spinner.spinner("destroy");
            } else {
            spinner.spinner();
            }
            });
            
            $("#setvalue").click(function () {
            spinner.spinner("value", 5);
            });
            */
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="UsersMainContent" runat="server">
    <div id="tabs">
        <ul>
            <li><a href="#tab-1">بيانات المشروع</a></li>
            <li><a href="#tab-2">تحديد معادلات المقايسة</a></li>
            <li><a href="#tab-3">مقاولى الباطن</a></li>
            <li><a href="#tab-4">تحديد العمالة للمشروع</a></li>
            <li><a href="#tab-5">تحديد موظفين للمشروع</a></li>
        </ul>
        <div id="tab-1">
            <br />
            <table>
                <tr>
                    <td class="style23">
                        اسم المشروع :
                    </td>
                    <td>
                        <input id="txt_ProjectName" type="text" />
                    </td>
                    <td class="style23">
                        الجهة المشرفه :
                    </td>
                    <td>
                        <input id="txt_SupervisingAuthority" type="text" />
                    </td>
                </tr>
                <tr>
                    <td class="style23">
                        مدة المشروع بالشهر :
                    </td>
                    <td>
                        <input id="txt_ProjectPeriod" name="value" class="IsNumberOnly" />
                    </td>
                    <td class="style23">
                        حجم التعاقد :
                    </td>
                    <td>
                        <input type="text" id="txt_ProjectCost" />
                    </td>
                </tr>
                <tr>
                    <td class="style23">
                        تاريخ البداية الفعلية :
                    </td>
                    <td>
                        <input type="text" id="txt_ProjectStartDate" />
                    </td>
                    <td class="style23">
                        تاريخ استلام الموقع :
                    </td>
                    <td>
                        <input type="text" id="txt_ReceptionLocationDate" />
                    </td>
                </tr>
                <tr>
                    <td class="style23">
                        تاريخ الفتح الفنى للمشروع :
                    </td>
                    <td>
                        <input type="text" id="txt_ProjectStartTechnicalDate" />
                    </td>
                    <td class="style23">
                        تاريخ انتهاء المشروع :
                    </td>
                    <td>
                        <input type="text" id="txt_ProjectEndDate" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center;">
                        <input id="btn_SaveProjectData" type="button" value="حفظ" onclick="SaveProjectData()"
                            class="btn_Save" />
                        <input id="btn_CancelSaveProjectData" type="button" value="إلغاء" class="btn_Save" />
                        <input type="button" class="btn_Save" value="اختر المقايسة" onclick="window.location.href='AddEstimationItems.aspx'" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="tab-2">
            <%--<a href="ProjectSupplies.aspx" class="togglelink">إضافة نوع توريد جديد</a>
            <div style="border: 3px; border-color: rgb(209, 209, 209); border-style: solid; -moz-border-radius: 12px;
                -webkit-border-radius: 5px; padding: 1px; margin-bottom: 5px;" class="toggle"
                style="display: block;">
                <input id="Button1" type="text" /><br />
                <input id="txt_aaa" type="button" value="save" />
            </div>--%>
            <div>
                <table>
                    <tr>
                        <td class="style23">
                            <a href="AddItems.aspx">إضافة نوع توريد جديد</a>
                        </td>

                        <td>
                            
                        </td>
                        <td>
                            المعادلات المضافة
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="style23">
                            <label>
                                بنود لم يتم اضافة معادلة لها
                            </label>
                        </td>
                        <td>
                            <select id="cbo_EstimationItems" style="width: 111px" onchange="SelectEstimations()">
                                <option></option>
                            </select>
                            
                        </td>
                        <th rowspan="5">
                           <select  id="lst_addedEquation" multiple="multiple">
                               <option>لا يوجد معادلات </option>
                           </select>
                        </th>
                        <td class="style23">
                          
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                    <tr>
                        <td class="style23">
                            <label>
                                المادة الخام
                            </label>
                        </td>
                        <td class="style23">
                            <select id="cbo_ProjectSuppliesCategory" style="width: 141px" onchange="SelectSubItems()">
                                <option></option>
                            </select>
                        </td>
                        <td class="style23">
                           
                        </td>
                        <td>
                           
                        </td>
                    </tr>
                    <div style="border-bottom-color: black; border-bottom-width: medium">
                    <tr>
                        <td class="style23">
                            <label>
                                المعادلة</label>
                        </td>
                        <td>
                             <label>
                                  نوع المادة الخام
                            </label>
                            &nbsp;
                             <select id="cbo_ProjectSuppliesItems" style="width: 113px">
                                <option></option>
                            </select>
                        </td>
                        <td>
                            
                        </td>
                        <td>
                            
                            &nbsp;
                            
                        </td>
                    </tr>
                    <tr>
                       <td>
                           <label>النسبة</label>
                            <input type="text" id="txt_Percentage" style="width: 80px"/>
                           &nbsp; X
                       </td>
                        <td>
                            <label> الكمية</label>
                            <input id="txt_EstemationQTY" type="text" style="width: 120px"/>
                            <br/><label>  ــــــــــــــــــــــــــــــــــــــ</label>
                        </td>
                        <td></td>
                        <td></td> 
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            
                           <input id="txt_DeviedTo"  type="text" value="1" style="width: 80px"/> 
                           <input type="button" value="اضافة المعادلة" onclick="AddEquation()"/>
                        </td>
                        <td></td>
                        <td>
                        </td>
                    </tr>
                        
                    </div>
                    <tr>
                        <td></td><td style="text-align:left"><input type="button" value="تطبيق المعادلة" onclick="ApplyEstimation()"/></td>
                    </tr>
                </table>
                <br />
            </div>
            
            <h3 class="HeaderRow">
                اجمالى الكميات المحددة</h3>
            <table>
                <thead>
                    <tr class="HeaderRow">
                        <td class="style16">
                            المادة الخام
                        </td>
                        <td class="style9">
                            نوع المادة الخام/ الصنف
                        </td>
                        <td class="style11">
                            الكمية
                        </td>
                        <%--<td class="tbl_th_buttonRemove">
                        </td>--%>
                    </tr>
                </thead>
                <tbody id="grid_ProjectSupplies">
                    
                </tbody>
            </table>
            <input id="btn_SaveProjectSupplies" type="button" value="تحديث اجمالى الكميات المحددة" onclick="RefreshAppliedEstemation()" class="btn_Save" />
        </div>
        <div id="tab-3">
            <table>
                <tr>
                    <td>
                        اسم المقاول :&nbsp;
                    </td>
                    <td>
                        <select id="cbo_SubcontractorInNewProject" onchange="javascript:void ($('#txt_SubContractorCode').val($(this).val()));">
                            <option></option>
                        </select>
                    </td>
                    <td>
                        كود المقاول :
                    </td>
                    <td>
                        <input id="txt_SubContractorCode" readonly="readonly" type="text" />
                    </td>
                </tr>
                <tr>
                    <td>
                        فئة العمل :
                    </td>
                    <td>
                        <select id="cbo_SubContractorWorkCategory" onchange="SelectWorkType()">
                            <option></option>
                        </select>
                    </td>
                    <td>
                        &nbsp;نوع العمل :
                    </td>
                    <td>
                        <div id="Cbo_SubContractorWorkType" class="checklistbox">
                            <label>
                                برجاء اختيار فئة العمل
                            </label>
                            <br />
                        </div>
                        <input type="button" value="تحديد الكل" onclick="SelectAll()" />
                        <input type="button" value="إلغاء التحديد" onclick="DisSelectAll()" />
                    </td>
                </tr>
            </table>
            <h3 class="HeaderRow">
                اجمالى المقاولين فى المشروع</h3>
            <table id="grid_SubContractor">
                <thead>
                    <tr class="HeaderRow">
                        <td class="style16">
                            اسم المقاول
                        </td>
                        <td class="style9">
                            فئة العمل
                        </td>
                        <td class="style11">
                            نوع العمل
                        </td>
                        <%--<td class="tbl_th_buttonRemove">
                        </td>--%>
                    </tr>
                </thead>
                <tbody id="Tbody1">
                
                </tbody>
            </table>
            <input id="btn_SaveNewSubContractor" type="button" value="إضافه" onclick="SaveNewSubContractor()"
                class="btn_Save" />
            <input id="btn_CancelSaveNewSubContractor" type="button" value="إلغاء" class="btn_Save" />
        </div>
        <div id="tab-4">
            <div>
                <table>
                    <tr>
                        <td>
                            اسم العامل
                        </td>
                        <td>
                            <select id="cbo_DailyWorker">
                                <option></option>
                            </select>
                        </td>
                        <td>
                            تاريخ بداية العمل
                        </td>
                        <td>
                            <input type="text" id="txt_DailyWorkerStartDate" />
                        </td>
                        <td>
                            اجر اليوم
                        </td>
                        <td>
                            <input type="text" id="txt_DailyWorkerWageDay" class="IsNumberOnly" />
                        </td>
                    </tr>
                </table>
            </div>
            <input id="Button5" type="button" value="إضافه" onclick="SaveDailyWorker()" class="btn_Save" />
            <input id="Button8" type="button" value="إلغاء" class="btn_Save" />
            <table>
                <thead>
                    <tr class="HeaderRow">
                        <td class="style16">
                            اسم العامل
                        </td>
                        <td class="style22">
                            بداية العمل
                        </td>
                        <td class="style18">
                            اجر اليوم
                        </td>
                    </tr>
                </thead>
                <tbody id="grid_DailyWork">
                    <tr class="ItemRow">
                        <td class="style16">
                            <input name="WorkerName" style="width: 180px" />
                        </td>
                        <td class="style22">
                            <input type="text" name="WorkStartDate" />
                        </td>
                        <td class="style18">
                            <input type="text" name="WorkWageDay" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="tab-5">
            <div>
                <table>
                    <tr>
                        <td>
                            اسم الموظف
                        </td>
                        <td>
                            <select id="cbo_Employees" onchange="javascript:void ($('#txt_EmployeeCode').val($(this).val()));">
                                <option></option>
                            </select>
                        </td>
                        <td>
                            كود الموظف
                        </td>
                        <td>
                            <input type="text" id="txt_EmployeeCode" readonly="readonly" />
                        </td>
                    </tr>
                </table>
            </div>
            <input id="Button9" type="button" value="إضافه" class="btn_Save" onclick="SaveEmployee()" />
            <input id="Button10" type="button" value="إلغاء" class="btn_Save" />
            <table>
                <thead>
                    <tr class="HeaderRow">
                        <td class="style16">
                            اسم الموظف
                        </td>
                        <td class="style22">
                            كود الموظف
                        </td>
                    </tr>
                </thead>
                <tbody id="grid_Employee">
                    <tr class="ItemRow">
                        <td class="style16">
                            <input type="text" name="EmployeeName" style="width: 180px" />
                        </td>
                        <td class="style22">
                            <input type="text" name="EmployeeCode" readonly="readonly" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <script src="js/checkboxlist-1.0.js" type="text/javascript"></script>
    <script type="text/javascript">

        function AddNewRow(CellChildInput) {
        }
        function Cbo_SubContractorWorkType_onclick() {

        }


    </script>
    <script src="js/NewProject.js" type="text/javascript"></script>
</asp:Content>
