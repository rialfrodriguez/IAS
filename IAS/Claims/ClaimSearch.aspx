﻿<%@ Page Title="Buscar Siniestros" Language="C#" MasterPageFile="~/Claim.Master" AutoEventWireup="true" CodeBehind="ClaimSearch.aspx.cs" Inherits="IAS.Claims.ClaimSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />

    <script type="text/javascript">
        function searchRecords() {
            document.getElementById("<%=searchBox.ClientID %>").click();
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div id="header">
            <div class="row">
                <div class="col-lg-4">
                    <div class="input-group">
                        <span class="input-group-btn">
                            <button id="searchBox" class="btn btn-default" runat="server" type="button" onserverclick="searchBox_ServerClick">Buscar</button>
                        </span>
                        <input type="text" class="form-control" id="txtSearchClaim" runat="server"
                            placeholder="Buscar Siniestro..."
                            onkeydown="if (window.event.keyCode == 13) 
                                        {
                                            event.returnValue=false; 
                                            event.cancel = true;
                                            searchRecords();
                                        }" />
                        <div class="input-group-btn">
                            <button type="button" id="criteriaBtn" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" runat="server">Nro. Póliza<span class="caret"></span></button>
                            <ul class="dropdown-menu">
                                <li><a href="?criteria=PolicyNumber">Nro Póliza</a></li>
                                <li><a href="?criteria=Client">Cliente</a></li>
                                <li><a href="?criteria=ClientDocumentNumber">Nro. Documento</a></li>
                            </ul>
                        </div>

                        <%--<button id="btnObtenerTodos" class="btn btn-default" runat="server" type="button" onserverclick="getAllBox_ServerClick">Obtener todos</button>--%>
                    </div>
                </div>
                <div class="col-lg-2">
                    <asp:DropDownList ID="ddlMyClaims" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0" Text="Todos los siniestros" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Mis siniestros"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-lg-2">
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" DataValueField="ClaimStatusID" DataTextField="Status" DataSourceID="StatusSqldataSoruce" AppendDataBoundItems="true">
                        <asp:ListItem Value="-1" Text="Todos los estados" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-lg-2">
                    <a href="NewClaim.aspx?criteria=Client">Alta Siniestro</a>
                </div>

            </div>
        </div>
        <div id="contenido">
            <div class="row">
                <div class="col-lg-12">
                    <asp:ListView ID="ClaimListView" runat="server"
                        DataKeyNames="ClaimID"
                        DataSourceID="ClaimSqldataSource"
                        OnItemCommand="ClaimListView_ItemCommand">
                        <LayoutTemplate>
                            <div class="table responsive">
                                <table class="table table-striped" style="font-size: x-small">
                                    <thead>
                                        <tr>
                                            <th>Nro Póliza</th>
                                            <th>Cliente</th>
                                            <%--      <th>Nro. Doc.</th>--%>
                                            <th>Siniestro</th>
                                            <th>Riesgo</th>
                                            <th>Fecha</th>
                                            <th>Usuario</th>
                                            <th>Estado</th>
                                            <th>Sub Estado</th>
                                            <th>Pendiente</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder" />
                                    </tbody>
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label ID="lblClaimID" runat="server" Text='<%# Eval("ClaimID").ToString() %>' Visible="false" />
                                    <asp:Label ID="lblPolicyNumber" runat="server" Text='<%# Eval("PolicyNumber").ToString() %>' /></td>
                                <td>
                                    <asp:Label ID="lblClient" runat="server" Text='<%# Eval("Client") %>' /></td>
                                <%-- <td>
                                    <asp:Label ID="lblClientDocumentNumber" runat="server" Text='<%# Eval("ClientDocumentNumber") %>' /></td>--%>
                                <td>
                                    <asp:Label ID="lblClaimNumber" runat="server" Text='<%# Eval("ClaimNumber") %>' /></td>
                                <td>
                                    <asp:Label ID="lblRiskName" runat="server" Text='<%# Eval("RiskName") %>' /></td>
                                <td>
                                    <asp:Label ID="lblRegistryDate" runat="server" Text='<%# DateTime.Parse( Eval("ClaimDate").ToString()).ToShortDateString() %>' /></td>
                                <td>
                                    <asp:Label ID="lblUsuario" runat="server" Text='<%# Eval("Usuario") %>' /></td>
                                <td>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' /></td>
                                <td>
                                    <asp:Label ID="lblSubStatus" runat="server" Text='<%# Eval("SubStatus") %>' /></td>
                                <td>
                                    <asp:HyperLink ID="linkAction" runat="server" Text='<%#   Eval("NextStatus") %>' NavigateUrl='<%#   Eval("ActionForm") %>'></asp:HyperLink>
                                </td>

                                <td>
                                    <div class="container">
                                        <div class="row">

                                            <asp:LinkButton ID="EditButton" runat="server" Text="Editar" CommandName="Edit" CssClass="btn btn-link">
                                                    <span class="glyphicon glyphicon-edit"></span>
                                            </asp:LinkButton>


                                            <asp:LinkButton ID="DeleteButton" runat="server" Text="Borrar" CommandName="Delete" CssClass="btn btn-link" OnClientClick="return confirm('Esta Usted seguro de Eliminar el Siniestro.?');" >
                                                <span class="glyphicon glyphicon-trash"></span>
                                            </asp:LinkButton>

                                        </div>
                                    </div>

                                </td>
                            </tr>
                        </ItemTemplate>
                        <EditItemTemplate>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                        </InsertItemTemplate>
                        <EmptyDataTemplate>
                            <div class="row">
                                <div class="col-lg-10 text-center">
                                    <div class="msg-box bg-warning alert-danger">No se encontraron Siniestros.</div>
                                </div>
                            </div>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>

    <!-- #region DATSOURCES -->
    <asp:SqlDataSource ID="ClaimSqldataSource" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>"
        SelectCommand="claim.sp_search_claims" SelectCommandType="StoredProcedure"
        DeleteCommand="claim.sp_delete_claim" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="find" ControlID="txtSearchClaim" PropertyName="Value" Type="String" />
            <asp:QueryStringParameter Name="criteria" QueryStringField="criteria" DefaultValue="PolicyNumber" />
            <asp:Parameter Name="user" />
            <asp:ControlParameter Name="myClaims" ControlID="ddlMyClaims" Type="String" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="claimStatusId" ControlID="ddlStatus" DbType="Int32" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ClaimID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="StatusSqldataSoruce" runat="server" ConnectionString="<%$ ConnectionStrings:IASDBContext %>"
        SelectCommand="[claim].[sp_get_status]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <!-- #endregion -->
</asp:Content>
