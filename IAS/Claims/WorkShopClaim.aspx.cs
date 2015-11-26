﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IAS.Claims
{
    public partial class WorkShopClaim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UpdateClaim()
        {
            SqlConnection sqlConnection1 = new SqlConnection(estadoClienteDataSource.ConnectionString);
            SqlCommand cmd = new SqlCommand();
            SqlCommand cmd1 = new SqlCommand();
            Int32 rowsAffected;

            string txtClaimNumber = (ClaimDetailsListView.Row.FindControl("txtClaimNumber") as TextBox).Text;
            string txtRiskName = (ClaimDetailsListView.Row.FindControl("txtRiskName") as TextBox).Text;
            DropDownList ddlLiquidador = (ClaimDetailsListView.Row.FindControl("ddlLiquidador") as DropDownList);
            DropDownList ddlTaller = (ClaimDetailsListView.Row.FindControl("ddlTaller") as DropDownList);
            string txtContactName = (ClaimDetailsListView.Row.FindControl("txtContactName") as TextBox).Text;
            string txtClaimDate = (ClaimDetailsListView.Row.FindControl("txtClaimDate") as TextBox).Text;
            DropDownList ddlExpertoAseguradora = (ClaimDetailsListView.Row.FindControl("ddlExpertoAseguradora") as DropDownList);
            string txtSection = (ClaimDetailsListView.Row.FindControl("txtSection") as TextBox).Text;
            string txtClaimAddress = (ClaimDetailsListView.Row.FindControl("txtClaimAddress") as TextBox).Text;
            string txtClaimDescription = (ClaimDetailsListView.Row.FindControl("txtClaimDescription") as TextBox).Text;
            string txtClaimTime = (ClaimDetailsListView.Row.FindControl("txtClaimTime") as TextBox).Text;

            string txtOtherVehicleDescription = (ClaimDetailsListView.Row.FindControl("txtOtherVehicleDescription") as TextBox).Text;
            string txtOtherVehiclePatentNumber = (ClaimDetailsListView.Row.FindControl("txtOtherVehiclePatentNumber") as TextBox).Text;
            string txtLooseDescription = (ClaimDetailsListView.Row.FindControl("txtLooseDescription") as TextBox).Text;



            try
            {

                cmd1.CommandText = "[claim].[sp_update_claim]";
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Connection = sqlConnection1;

                cmd1.Parameters.AddWithValue("@ClaimID", Request.QueryString["ClaimID"]);
                cmd1.Parameters.AddWithValue("@ClaimNumber", txtClaimNumber);
                cmd1.Parameters.AddWithValue("@RiskName", txtRiskName);
                cmd1.Parameters.AddWithValue("@LiquidatorID", ddlLiquidador.SelectedValue);
                cmd1.Parameters.AddWithValue("@WorkshopID", ddlTaller.SelectedValue);
                cmd1.Parameters.AddWithValue("@ClaimDate", DateTime.Parse(txtClaimDate));
                cmd1.Parameters.AddWithValue("@InsuranceExpertID", ddlExpertoAseguradora.SelectedValue);
                cmd1.Parameters.AddWithValue("@Section", txtSection);
                cmd1.Parameters.AddWithValue("@ContactName", txtContactName);
                cmd1.Parameters.AddWithValue("@ClaimAddress", txtClaimAddress);
                cmd1.Parameters.AddWithValue("@ClaimDescription", txtClaimDescription);
                cmd1.Parameters.AddWithValue("@ClaimTime", txtClaimTime);
                cmd1.Parameters.AddWithValue("@OtherVehicleDescription", txtOtherVehicleDescription);
                cmd1.Parameters.AddWithValue("@OtherVehiclePatentNumber", txtOtherVehiclePatentNumber);
                cmd1.Parameters.AddWithValue("@LooseDescription", txtLooseDescription);

                sqlConnection1.Open();

                rowsAffected = cmd1.ExecuteNonQuery();

                sqlConnection1.Close();

            }
            catch (Exception exp)
            {
                ErrorLabel.Text = exp.Message;
                ErrorLabel.Visible = true;
            }

        }
    }
}