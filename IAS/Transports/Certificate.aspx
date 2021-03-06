﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Transport.Master" AutoEventWireup="true" CodeBehind="Certificate.aspx.cs" Inherits="IAS.Transports.Certificate" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    <link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <link href="/Content/bootstrap-datetimepicker.css" rel="stylesheet" />

    <script src="/Scripts/jquery-1.12.4.min.js"></script>
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <link href="/Content/bootstrap.min.css" rel="stylesheet" />
    
    <script src="/Scripts/moment-with-locales.min.js"></script>
    <script src="/Scripts/bootstrap-datetimepicker.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearch]").autocomplete(
                {
                    source: "SearchClient.ashx",
                    // note minlength, triggers the Handler call only once 3 characters entered
                    minLength: 3,
                    focus: function (event, ui) {
                        $("[id$=txtSearch]").val(ui.item.label);
                        return false;
                    },
                    select: function (event, ui) {
                        if (ui.item) {
                            $("[id$=txtSearch]").val(ui.item.Client);

                            var d = ui.item.Client.split('|');
                            $("[id$=hifPersonID]").text(d[1]);

                            $("[id$=btnSearch]").click();
                            return false;
                        }
                    }
                })
                .autocomplete("instance")._renderItem = function (ul, item) {
                    
                    return $("<li>")
                      .append("<div>" + item.Client + "</div>")
                      .appendTo(ul);
                };
        });

    </script>
    
    <style>
        .modal-wide1 .modal-dialog {
            width: 80%; /* or whatever you wish */
            left: 0;
        }
    </style>
    
    
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container-fluid" >
         <div class="row" style="padding-left:5px">
            <ul class="breadcrumb" runat="server" id="bread">
                <li><a href="/Default.aspx">IAS</a></li>
                <li><a href="/Transports/Certificates.aspx">Transportes</a></li>
                <li class="active" id="SiteLabel" runat="server">Certificado</li>
            </ul>
        </div>
    </div>

<%--    <asp:UpdatePanel ID="upnlCertificate" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="gridClients" />
        </Triggers>
        <ContentTemplate>--%>

            <div class="container-fluid" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding-left: 15px; padding-right: 15px">

                <div class="row">
                    <div class="col-lg-12">
                        <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="msg-box bg-danger" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12" style="font-size: small">
                        <div class="panel panel-default">
                            <div class="panel-heading"><span class="glyphicon glyphicon-search"></span>Buscar cliente</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="row" hidden="hidden">
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                                <span class="input-group-btn">
                                                    <button id="searchBox" class="btn btn-primary" runat="server" type="button" onserverclick="searchBox_ServerClick">Buscar</button>
                                                </span>
                                                <input type="text" class="form-control" id="txtSearchClient" runat="server"
                                                    placeholder="Buscar Cliente..."
                                                    onkeydown="if (window.event.keyCode == 13) 
                                                               {
                                                                    event.returnValue = false; 
                                                                    event.cancel = true;
                                                                    searchRecords();
                                                               }" />
                                                <div class="input-group-btn">
                                                    <button type="button" id="criteriaBtn" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server">Cliente<span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li><a href="?criteria=Client">Cliente</a></li>
                                                        <li><a href="?criteria=ClientDocumentNumber">Nro. Documento</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                   <%-- <div class="row"  hidden="hidden">
                                        <div class="col-lg-1">Cliente</div>
                                        <div class="col-lg-11">
                                            <asp:DropDownList ID="ClientsDDL" runat="server" CssClass="form-control" DataSourceID="clientDS"
                                                DataValueField="id_persona" DataTextField="client" OnSelectedIndexChanged="ClientsDDL_SelectedIndexChanged" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </div>
                                    </div>--%>
                                    <div class="row">
                                        <div class="col-lg-1">Cliente</div>
                                        <div class="col-lg-10">
                                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:HiddenField ID="hifPersonID" runat="server" />
                                        </div>
                                        <div class="col-lg-1" hidden="hidden">
                                            <button id="btnSearch" runat="server" class="btn btn-default" onserverclick="btnSearch_ServerClick">
                                                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                            </button>
                                        </div>

                                    </div>
                                    <br />
                                    <div id="divClientData" runat="server" style="border-bottom: double; border-bottom-color: lightgray">
                                        <div class="row">
                                            <label class="col-sm-2 control-label" for="form-group-input">Cliente</label>
                                            <div class="col-sm-6">
                                                <asp:Label ID="lblCliente" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 control-label" for="form-group-input">Razón social</label>
                                            <div class="col-sm-6">
                                                <asp:Label ID="lblRazonSocial" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="col-sm-2 control-label" for="form-group-input">Nro Documento</label>
                                            <div class="col-sm-6">
                                                <asp:Label ID="lblNroDocumento" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12" style="font-size: small">
                        <div class="panel panel-default">
                            <div class="panel-heading">Datos de Póliza</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Nro. Póliza</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlPolicy" runat="server" CssClass="form-control" DataSourceID="policyDataSource"
                                                DataValueField="PolicyNumber" DataTextField="Description">
                                            </asp:DropDownList>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Nro. Certificado</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtCertificateNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Beneficiario</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtBeneficiary" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <%--  <label class="col-sm-1 control-label" for="form-group-input">Porcentaje partner</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtPartnerAmmountPercent" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>--%>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Emisión</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtEmissionDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Extensión</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtExtensionDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Moneda</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="form-control" DataSourceID="currencyDataSource"
                                                DataValueField="CurrencyID" DataTextField="Denomination">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Fecha de solicitud</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtRequestDate" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Tipo de cobertura</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlCoverType" runat="server" CssClass="form-control">
                                                <asp:ListItem Text="Todo riesgo" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Limitada" Value="1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12" style="font-size: small">
                        <div class="panel panel-default">
                            <div class="panel-heading">Datos del seguro</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Aseguradora</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlInsuranceManager" runat="server" CssClass="form-control" DataSourceID="insuranceManagerDataSource"
                                                DataValueField="InsuranceManagerID" DataTextField="InsuranceManager">
                                            </asp:DropDownList>
                                        </div>
                                        <%-- <label class="col-sm-1 control-label" for="form-group-input">Asociado</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlPartners" runat="server" CssClass="form-control" DataSourceID="partnersDataSource"
                                                DataValueField="PartnerID" DataTextField="Partner">
                                            </asp:DropDownList>
                                        </div>--%>

                                        <label class="col-sm-1 control-label" for="form-group-input">Mercadería</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtRiskName" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Bultos</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtPackageCount" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Contacto</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlContact" runat="server" CssClass="form-control" DataSourceID="contactDataSource"
                                                DataValueField="ContactID" DataTextField="Contact">
                                            </asp:DropDownList>
                                        </div>

                                        <label class="col-sm-1 control-label" for="form-group-input">Medio Transporte</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="ddlTransportationMethod" runat="server" CssClass="form-control" DataSourceID="transportationMethodDataSource"
                                                DataValueField="TransportationMethodID" DataTextField="Method">
                                            </asp:DropDownList>
                                        </div>

                                    </div>
                                    <br />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Origen</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtOrigin" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Destino</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtDestination" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Descripción</label>
                                        <div class="col-sm-11">
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Height="150px"></asp:TextBox>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Suma Asegurada</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtCapitalAmount" runat="server" CssClass="form-control" onkeypress="numberFormat(this);" onchange="numberFormat(this);" AutoPostBack="true" OnTextChanged="Comission_TextChanged"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">% Prima L</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtRate" runat="server" CssClass="form-control" onkeypress="numberFormat(this);" onchange="numberFormat(this);" AutoPostBack="true" OnTextChanged="Comission_TextChanged"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Prima L</label>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtPremium" runat="server" CssClass="form-control" ReadOnly="true" onchange="formatoNumero(this, null, ',', '.')"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12" style="font-size: small">
                        <div class="panel panel-default">
                            <div class="panel-heading">Tasas</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">% ASSA</label>
                                        <div class="col-sm-1">
                                            <asp:TextBox ID="txtComissionASSAPercent" runat="server" CssClass="form-control" onkeypress="numberFormat(this);" onchange="numberFormat(this);" AutoPostBack="true" OnTextChanged="Comission_TextChanged"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Comisión ASSA</label>
                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txtComissionASSA" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                        </div>

                                        <label class="col-sm-1 control-label" for="form-group-input">% Asesor</label>
                                        <div class="col-sm-1">
                                            <asp:TextBox ID="txtComissionAdviserPercent" runat="server" CssClass="form-control" onkeypress="numberFormat(this);" onchange="numberFormat(this);" AutoPostBack="true" OnTextChanged="Comission_TextChanged"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Comisión Asesor</label>
                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txtComissionAdviser" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>

                                    <br />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">% Gasto</label>
                                        <div class="col-sm-1">
                                            <asp:TextBox ID="txtSpendingPercent" runat="server" CssClass="form-control" onkeypress="numberFormat(this);" onchange="numberFormat(this);" AutoPostBack="true" OnTextChanged="Comission_TextChanged"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Gasto</label>
                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txtSpending" runat="server" ReadOnly="true" CssClass="form-control" onkeypress="numberFormat(this);" onchange="numberFormat(this);"></asp:TextBox>
                                        </div>

                                    </div>
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row" id="divAgentCommission" runat="server">
                    <div class="col-lg-12" style="font-size: small">
                        <div class="panel panel-default">
                            <div class="panel-heading">Comisionistas</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Agente 1</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="AgentsDDL_1" runat="server" CssClass="form-control" DataSourceID="agentsDS"
                                                DataValueField="AgentID" DataTextField="Agent">
                                            </asp:DropDownList>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">% Comisión</label>
                                        <div class="col-sm-1">
                                            <asp:TextBox ID="txtAgentPercent_1" runat="server" CssClass="form-control" Font-Size="X-Small" AutoPostBack="true" OnTextChanged="Comission_TextChanged"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Comisión</label>
                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txtAgentAmount_1" runat="server" ReadOnly="true" CssClass="form-control" Font-Size="X-Small" />
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Aplicar Gasto</label>
                                        <div class="col-sm-2">
                                            <asp:CheckBox ID="CheckBox2" runat="server" />
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <label class="col-sm-1 control-label" for="form-group-input">Agente 2</label>
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="AgentsDDL_2" runat="server" CssClass="form-control" DataSourceID="agentsDS"
                                                DataValueField="AgentID" DataTextField="Agent">
                                            </asp:DropDownList>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">% Comisión</label>
                                        <div class="col-sm-1">
                                            <asp:TextBox ID="txtAgentPercent_2" runat="server" CssClass="form-control" Font-Size="X-Small" AutoPostBack="true" OnTextChanged="Comission_TextChanged"></asp:TextBox>
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Comisión</label>
                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txtAgentAmount_2" runat="server" ReadOnly="true" CssClass="form-control" Font-Size="X-Small" />
                                        </div>
                                        <label class="col-sm-1 control-label" for="form-group-input">Aplicar Gasto</label>
                                        <div class="col-sm-2">
                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-lg-8"></div>
                    <label class="col-sm-1 control-label" for="form-group-input">Prima Total</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtTotalPrime" runat="server" CssClass="form-control" onkeypress="numberFormat(this);" onchange="numberFormat(this);"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8"></div>
                    <label class="col-sm-1 control-label" for="form-group-input">Premio</label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="txtPremiunmPlusTax" runat="server" CssClass="form-control" onchange="formatoNumero(this, null, ',', '.')"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2">
                        <asp:Button ID="btnGuardar" runat="server" CssClass=" btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />
                    </div>
                </div>

                <!-- SQL Data Sources -->
                <asp:SqlDataSource ID="clientesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="sp_obtener_persona_para_siniestros" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="insuranceManagerDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="[dbo].[sp_get_insurance_managers_ddl]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="currencyDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="[dbo].[get_currency_ddl]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="policyDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="[transport].[sp_get_policy_ddl]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="contactDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="[transport].[sp_get_contact_ddl]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="transportationMethodDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="[dbo].[sp_get_transportation_method_ddl]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="partnersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="[dbo].[sp_get_partners_ddl]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="clientDS" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="exchange.sp_get_clients" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="agentsDS" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="[transport].[sp_get_agent_ddl]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:SqlDataSource ID="AgentCommissionDS"
                    runat="server"
                    ConnectionString="<%$ ConnectionStrings:IASDBContext %>"
                    SelectCommand="transport.get_agent_commissions"
                    SelectCommandType="StoredProcedure"
                    InsertCommand="transport.sp_insert_agent_commission"
                    InsertCommandType="StoredProcedure"
                    DeleteCommand="transport.sp_delete_agent_commission"
                    DeleteCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:QueryStringParameter Name="CertificateID" QueryStringField="certificateID" Type="Int32" />
                        <asp:ControlParameter Name="AgentID" ControlID="ctl00$MainContent$AgentCommissionListView$ctrl0$AgentsDDL" PropertyName="SelectedValue" />
                        <asp:Parameter Name="ComissionPercent" Type="Decimal" />
                        <asp:Parameter Name="ComissionSellerPercent" Type="Decimal" />
                    </InsertParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="CertificateID" />
                        <asp:Parameter Name="AgentID" />
                    </DeleteParameters>
                </asp:SqlDataSource>

                <div class="modal fade modal-wide1" id="myModalClients" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                                <h4 class="modal-title" id="myModalLabel">Seleccionar póliza</h4>
                            </div>
                            <br />
                            <div class="form-horizontal" role="form">
                                <div class="row" style="padding-left: 20px; padding-right: 20px; font-size: x-small !important;">
                                    <div class="col-lg-12">
                                        <asp:GridView ID="gridClients" AutoGenerateColumns="false" EmptyDataText="Sin registros" runat="server" CssClass="table table-hover"
                                            OnRowCommand="gridClients_RowCommand">
                                            <Columns>
                                                <asp:BoundField HeaderText="Nro documento" DataField="numero_documento" />
                                                <asp:BoundField HeaderText="Cliente" DataField="cliente" />
                                                <asp:BoundField HeaderText="Razón social" DataField="razon_social" />
                                                <asp:TemplateField HeaderText="Seleccionar">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkSeleccionar" runat="server" CausesValidation="False" CommandArgument='<%# Eval("numero_documento") + "|" + Eval("cliente") + "|" + Eval("razon_social") + "|" + Eval("id_persona") %>'
                                                            CommandName="seleccionar" Text="Seleccionar" ToolTip="Seleccionar">
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
<%--        </ContentTemplate>
    </asp:UpdatePanel>--%>

    <script type="text/javascript">

        // Quitamos el uso de la tecla ENTER
        window.addEventListener("keypress", function (event) {
            if (event.keyCode == 13) {
                event.preventDefault();
            }
        }, false);

        function openModalClients() {
            $('#myModalClients').modal('show');
        }

        $(document).ready(function () {

            //$.fn.datepicker.dates['es'] = {
            //    days: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            //    daysShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
            //    daysMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
            //    months: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            //    monthsShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            //    today: "Hoy"
            //};

            //$('#MainContent_txtEmissionDate').datepicker({
            //    isRTL: false,
            //    format: 'dd/mm/yyyy',
            //    autoclose:true,
            //    language: 'es'
            //});

            //$('#MainContent_txtExtensionDate').datepicker({
            //    isRTL: false,
            //    format: 'dd/mm/yyyy',
            //    autoclose: true,
            //    language: 'es'
            //});
        });

    </script>
</asp:Content>
