﻿<%--   
    «Copyright 2014 Balcazz HT, http://www.balcazzht.com»

    This file is part of IAS | Insurance Advanced Services.

    IAS is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    IAS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UploadCollections.aspx.cs" Inherits="IAS.Collections.UploadCollections" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%--<link href="../Content/bootstrap-datepicker.min.css" rel="stylesheet" />--%>
    <link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.12.4.min.js"></script>
    <script src="/Scripts/jquery-ui-1.12.1.min.js"></script>
    <script src="/Scripts/bootstrap.min.js"></script>
    <link href="/Content/bootstrap-datetimepicker.css" rel="stylesheet" />
    <script src="/Scripts/bootstrap-datepicker.min.js"></script>
    <script src="/Scripts/moment-with-locales.min.js"></script>
    <script src="/Scripts/bootstrap-datetimepicker.min.js"></script>

    <div class="page-header">
        <h2>Subir cuotas</h2>
    </div>

    <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="msg-box bg-danger" />

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Mapfre</div>
                <div class="panel-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-3">
                                <label>Cuotas</label>
                            </div>
                            <div class="col-lg-3">
                                <label>Archivo (.csv)</label>
                            </div>
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3"></div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-2">
                                <label>Fecha</label>
                            </div>
                            <div class="col-lg-3">
                                <div class='input-group date' id='datetimepicker1'>
                                    <input id="txtDateMapfre" placeholder="" class="form-control" runat="server" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDateMapfre" Font-Bold="true"
                                        CssClass="text-danger" ValidationGroup="mapfre" ErrorMessage="El campo es requerido" />
                            </div>
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3"></div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-2">
                                <label>Mapfre vencidos</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:FileUpload ID="MapfreExpiredUp" runat="server" />
                            </div>
                            <div class="col-lg-3 col-lg-offset-1">
                                <asp:Button runat="server" ID="MapfreExpireBtn" ValidationGroup="mapfre" Text="Upload" OnClick="MapfreExpireBtn_Click" />
                            </div>
                            <div class="col-lg-3">
                                <label>
                                    <asp:Label runat="server" ID="MapfreExpiredStatus" Text="Estado" /></label>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-2">
                                <label>Mapfre a vencer</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:FileUpload ID="MapfreToExpireUp" runat="server" />
                            </div>
                            <div class="col-lg-3 col-lg-offset-1">
                                <asp:Button runat="server" ID="MapfreToExpireBtn" ValidationGroup="mapfre" Text="Upload" OnClick="MapfreToExpireBtn_Click" />
                            </div>
                            <div class="col-lg-3">
                                <label>
                                    <asp:Label runat="server" ID="MapfreToExpireStatus" Text="Estado" /></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">Sancor</div>
                <div class="panel-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-lg-3">
                                <label>Cuotas</label>
                            </div>
                            <div class="col-lg-3">
                                <label>Archivo (.csv)</label>
                            </div>
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3"></div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-2">
                                <label>Fecha</label>
                            </div>
                            <div class="col-lg-3">
                                <div class='input-group date' id='datetimepicker2'>
                                    <input id="txtDateSancor" placeholder="" class="form-control" runat="server" />
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDateSancor" Font-Bold="true"
                                        CssClass="text-danger" ValidationGroup="sancor" ErrorMessage="El campo es requerido" />
                            </div>
                            <div class="col-lg-3"></div>
                            <div class="col-lg-3"></div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-2">
                                <label>Sancor</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:FileUpload ID="Sancor" runat="server" />
                            </div>
                            <div class="col-lg-3 col-lg-offset-1">
                                <asp:Button runat="server" ID="SancorBtn" ValidationGroup="sancor" Text="Upload" OnClick="SancorBtn_Click" />
                            </div>
                            <div class="col-lg-3">
                                <label>
                                    <asp:Label runat="server" ID="SancorStatus" Text="Estado" /></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--<script src="../Scripts/jquery-1.12.4.min.js"></script>
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>
    <script src="../Scripts/bootstrap-datepicker.min.js"></script>
    <script src="../Scripts/bootstrap-datetimepicker.min.js"></script>
    <script src="../Scripts/moment-with-locales.min.js"></script>
    --%>
    <script type="text/javascript">

        $('#datetimepicker1').datetimepicker({
            format: 'DD-MM-YYYY',
            locale: 'es'
        });

        $('#datetimepicker2').datetimepicker({
            format: 'DD-MM-YYYY',
            locale: 'es'
        });

    </script>

</asp:Content>
