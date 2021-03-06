﻿<%@ Page Title="Nuevo Siniestro" Language="C#" MasterPageFile="~/Claim.Master" AutoEventWireup="true" CodeBehind="NewClaim.aspx.cs" Inherits="IAS.Claims.NewClaim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
            $("[id$=txtSearchClient]").autocomplete(
                {
                    source: "SearchClient.ashx",
                    response: function (event, ui) {
                        // ui.content is the array that's about to be sent to the response callback.
                        if (ui.content.length === 0) {
                            $('#myModalNewPolicy').modal('show');
                        }
                    },
                    // note minlength, triggers the Handler call only once 3 characters entered
                    minLength: 3,
                    focus: function (event, ui) {
                        return false;
                    },
                    select: function (event, ui) {
                        if (ui.item) {
                            $("[id$=txtSearchClient]").val(ui.item.Client);
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
    <script>

        function openModalPolizas() {
            $('#myModalPolizas').modal('show');
        }

    </script>

    <style>
        #contenido {
            margin: 0 10px;
        }

        #header {
            padding-top: 5px;
            height: 50px;
            padding-right: 10px;
        }

        .modal-wide1 .modal-dialog {
            width: 80%; /* or whatever you wish */
        }
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="msg-box bg-danger" />
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-lg-12" style="font-size: small">
                <div class="panel panel-default">
                    <div class="panel-heading">Datos de la Póliza</div>
                    <div class="panel-body">
                        <div class="form-group">

                            <div class="row">
                                <div class="col-lg-10">
                                    <asp:TextBox ID="txtSearchClient" runat="server" CssClass="form-control" placeholder="Busqueda de poliza: CI, Nombre, Apellido, Nro Poliza"></asp:TextBox>
                                    <button style="display: none;" id="btnSearch" runat="server" class="btn btn-default" onserverclick="btnSearch_ServerClick">
                                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                    </button>
                                </div>
                                <div class="col-lg-2">
                                    <a href="NewPolicy.aspx" class="btn btn-default">
                                        <span class="glyphicon glyphicon-plus"></span>
                                        <span class="glyphicon glyphicon-list-alt"></span>
                                    </a>
                                </div>
                            </div>

                            <br />
                            <%--<div class="row">
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <span class="input-group-btn">
                                            <button id="searchBox" class="btn btn-default" runat="server" type="button" onserverclick="searchBox_ServerClick">Buscar</button>
                                        </span>
                                        <input type="text" class="form-control" id="txtSearchClaim" runat="server"
                                            placeholder="Buscar Cliente..."
                                            onkeydown="if (window.event.keyCode == 13) 
                                        {
                                            event.returnValue=false; 
                                            event.cancel = true;
                                            searchRecords();
                                        }" />
                                        <div class="input-group-btn">
                                            <button type="button" id="criteriaBtn" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server">Cliente<span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li><a href="?criteria=Client">Cliente</a></li>
                                                <li><a href="?criteria=ClientDocumentNumber">Nro. Documento</a></li>
                                                <li><a href="?criteria=PolicyNumber">Nro Póliza</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />--%>
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Cliente</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblCliente" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Nro Documento</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblNroDocumento" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Poliza</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblPoliza" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Aseguradora</label>
                                <div class="col-sm-10">
                                    <asp:Label ID="lblAseguradora" runat="server"></asp:Label>
                                </div>
                            </div>
                            <%--    <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Cliente</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlClientes" runat="server" DataSourceID="clientesDataSource" AutoPostBack="true"
                                        CssClass="form-control" DataValueField="id_persona" DataTextField="cliente">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Nro. póliza</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlNroPoliza" runat="server" DataSourceID="polizasDataSource"
                                        CssClass="form-control" DataValueField="nro_poliza" DataTextField="detail">
                                    </asp:DropDownList>
                                </div>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12" style="font-size: small">
                <div class="panel panel-default">
                    <div class="panel-heading">Datos del Siniestro</div>
                    <div class="panel-body">
                        <div class="form-group">
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Fecha Siniestro</label>
                                <div class="col-sm-4">
                                    <div class='input-group date' id='datetimepicker1'>
                                        <input id="dp1" placeholder="Fecha siniestro" class="form-control" runat="server" />
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <%--    <input data-provide="datepicker" id="dp1" class="form-control" data-date-format="dd-mm-yyyy" runat="server" />--%>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Tipo Siniestro</label>
                                <div class="col-sm-10">
                                    <asp:DropDownList ID="ddlTipoSiniestro" runat="server" CssClass="form-control" DataSourceID="tipoSinistrosDataSource" AutoPostBack="true"
                                        DataValueField="ClaimTypeID" DataTextField="Description">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label class="col-sm-2 control-label" for="form-group-input">Cobertura</label>
                                <div class="col-sm-10">
                                    <asp:ListBox ID="lsbCoberturas"
                                        Rows="10"
                                        Width="100%"
                                        CssClass="form-control"
                                        SelectionMode="Multiple"
                                        DataSourceID="coberturaPolizas"
                                        runat="server"
                                        DataTextField="ClaimMade"
                                        DataValueField="ClaimMadeID"></asp:ListBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <hr />
        </div>
        <div class="row">
            <div class="col-lg-2 col-lg-offset-10">
                <asp:Button ID="registrarSiniestroBtn" runat="server" Text="Generar Siniestro" CssClass="btn btn-primary" OnClick="registrarSiniestroBtn_Click" />
            </div>
        </div>
        <div class="modal fade modal-wide1" id="myModalPolizas" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                        <h4 class="modal-title" id="H5">Seleccionar póliza</h4>
                    </div>
                    <br />
                    <div class="form-horizontal" role="form">
                        <div class="row" style="padding-left: 20px; padding-right: 20px; font-size: x-small !important;">
                            <div class="col-lg-12">
                                <asp:GridView ID="gridClients" AutoGenerateColumns="false" EmptyDataText="Sin registros" runat="server" CssClass="table table-hover"
                                    OnRowCommand="gridClients_RowCommand">
                                    <Columns>
                                        <asp:BoundField HeaderText="Nro Póliza" DataField="detail" />
                                        <asp:BoundField HeaderText="Nro documento" DataField="numero_documento" />
                                        <asp:BoundField HeaderText="Cliente" DataField="cliente" />
                                        <asp:BoundField HeaderText="Aseguradora" DataField="InsuranceManager" />
                                        <asp:TemplateField HeaderText="Seleccionar">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkSeleccionar" runat="server" CausesValidation="False" CommandArgument='<%# Eval("detail") + "|" + Eval("numero_documento") + "|" + Eval("cliente") + "|" + Eval("id_persona") + "|" + Eval("nro_poliza") %>'
                                                    CommandName="seleccionar" Text="Seleccionar" ToolTip="Seleccionar">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="NewPolicy.aspx" class="btn btn-default">
                                <span class="glyphicon glyphicon-plus"></span>
                            </a>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade modal-wide" id="myModalNewPolicy" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                        <h4 class="modal-title" id="H5">No existe la poliza</h4>
                    </div>
                    <br />
                    <div class="form-horizontal" role="form">
                        <div class="row" style="padding-left: 20px; padding-right: 20px; font-size: x-small !important;">
                            <div class="col-lg-12">
                                <h4>¿Quisiera dar de alta la poliza?
                                </h4>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="NewPolicy.aspx" class="btn btn-primary">
                                <span>Aceptar</span>
                            </a>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- #SQL Data Sources -->
    <asp:SqlDataSource ID="clientesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="sp_obtener_persona_para_siniestros" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <%--  <asp:SqlDataSource ID="polizasDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="sp_obtener_polizas_por_persona" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlClientes" Name="p_id_persona" DbType="Int32" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="tipoSinistrosDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="sp_obtener_tipo_siniestros" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="coberturaPolizas" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>" SelectCommand="SELECT  [ClaimMade],[ClaimMadeID]  FROM [dbo].[ClaimMade] where ClaimTypeID = @ClaimTypeID" SelectCommandType="Text">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlTipoSiniestro" Name="ClaimTypeID" DbType="Int32" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script type="text/javascript">

        $('#datetimepicker1').datetimepicker({
            format: 'DD-MM-YYYY',
            locale: 'es'
        });

    </script>

</asp:Content>

