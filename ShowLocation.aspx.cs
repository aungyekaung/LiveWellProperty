using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ShowLocation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            var address = Request.QueryString["Address"];
            if (string.IsNullOrEmpty(address))
                Response.Redirect("FindProperty.aspx");


            // Get the lat/long info about the address
            var results = GoogleMapAPIGetLatLong.GoogleMapAPIGeoCoding(address);

            lblAddress.Text = address;

            // Set the latitude and longtitude parameters based on the address being searched on
            dsSearchResults.SelectParameters["Latitude"].DefaultValue = results.Element("result").Element("geometry").Element("location").Element("lat").Value;
            dsSearchResults.SelectParameters["Longitude"].DefaultValue = results.Element("result").Element("geometry").Element("location").Element("lng").Value;

            lvSearchResults.DataBind();
        }
    }
}