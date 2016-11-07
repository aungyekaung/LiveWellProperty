using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ShowLocation2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            var address = Request.QueryString["Address"];
            if (string.IsNullOrEmpty(address))
                Response.Redirect("default.aspx");


            // Get the lat/long info about the address
            var results = GoogleMapAPIGetLatLong.GoogleMapAPIGeoCoding(address);

            lblAddress.Text = address;

            // Set the latitude and longtitude parameters based on the address being searched on
            dsSearchResults.SelectParameters["Latitude"].DefaultValue = results.Element("result").Element("geometry").Element("location").Element("lat").Value;
            dsSearchResults.SelectParameters["Longitude"].DefaultValue = results.Element("result").Element("geometry").Element("location").Element("lng").Value;

            lvSearchResults.DataBind();


            // Loop through each nearby location and build up the JavaScript to place the markers
            var markers = new List<string>();

            var nearbyLocations = dsSearchResults.Select(DataSourceSelectArguments.Empty) as DataView;
            foreach (DataRowView location in nearbyLocations)
            {
                markers.Add(string.Format(
                                @"{{ 

                                    title: ""Property #{0}"",
                                    position: new google.maps.LatLng({1}, {2}),
                                    url: ""ShowDetails.aspx?PropertyID={3}""
                                }}",
                                   location["PropertyID"],
                                   location["Latitude"],
                                   location["Longitude"],
                                   location["PropertyID"]
                                   
                                )
                              );
            }

            var lat = results.Element("result").Element("geometry").Element("location").Element("lat").Value;
            var lng = results.Element("result").Element("geometry").Element("location").Element("lng").Value;
            var locationsJson = "[" + string.Join(",", markers.ToArray()) + "]";

            // Inject the Google Maps script
            ClientScript.RegisterStartupScript(this.GetType(), "Google Maps Initialization",
                                               string.Format("init_map('map_canvas', {0}, {1}, 15, {2});", lat, lng, locationsJson), true);





        }
    }
}