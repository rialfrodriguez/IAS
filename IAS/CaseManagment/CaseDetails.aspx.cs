﻿//«Copyright 2014 Balcazz HT, http://www.balcazzht.com»

//This file is part of IAS | Insurance Advanced Services.

//IAS is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.

//IAS is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.

//You should have received a copy of the GNU General Public License
//along with Foobar.  If not, see <http://www.gnu.org/licenses/>.


using IAS.Infrastructure;
using IAS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IAS.CaseManagment {
    public partial class CaseDetails : System.Web.UI.Page {
        protected void Page_Load( object sender, EventArgs e ) {
        }

        protected override bool OnBubbleEvent( object source, EventArgs e ) {
            bool handled = false;
            var arg = e as CaseStateChangedEventArgs;
            if ( null != arg ) {
                this.CaseData.Rebind();
                handled = true;
            }
            return handled;
            
        }
    }
}