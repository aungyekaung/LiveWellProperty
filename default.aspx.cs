using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (IsPostBack == true)
        //    labelPostback.Text = "This is not 1st time load";
        //else
        //    labelPostback.Text = "This is 1st time load";
        //    ddl1.Items.Add("Choice1");
        //    ddl1.Items.Add("Choice2");
        //    ddl1.Items.Add("Choice3");

    }

    //protected void btnPostback_Click(object sender, EventArgs e)
    //{
    //    //label.Text = "Hello After postback by clicking postback button";
    //}


    //protected void btnLabel_Click(object sender, EventArgs e)
    //{
    //    //label.Text = "Hello after clicking change label msg button";
    //}




    protected void btnSearch_Click(object sender, EventArgs e)
    {
        var results = GoogleMapAPIGetLatLong.GoogleMapAPIGeoCoding(txtSearch.Text.Trim() + ",Singapore");

        var resultCount = results.Elements("result").Count();

        lvDidYouMean.Visible = false;
        lblNoResults.Visible = false;

        // How many results did we get back?
        if (resultCount == 0)
            //Eep, no results!
            lblNoResults.Visible = true;

        else if (resultCount == 1)
            //Got back just one result, show the stores that match the address search
            ShowResults(results);

        else
        {
            //Got back multiple results - We need to ask the user which address they mean to use...
            var matches = from result in results.Elements("result")
                          let formatted_address = result.Element("formatted_address").Value
                          select formatted_address;

            lvDidYouMean.DataSource = matches;
            lvDidYouMean.DataBind();
            lvDidYouMean.Visible = true;
        }
    }


    protected void ShowResults(XElement results)
    {
        Response.Redirect("ShowLocation2.aspx?Address=" +
                            Server.UrlEncode(results.Element("result").Element("formatted_address").Value));
    }



}