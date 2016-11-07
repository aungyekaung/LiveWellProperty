using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PropertyDetails : System.Web.UI.Page
{
    PropertyDbEntities entities;
    protected void Page_Load(object sender, EventArgs e)
    {

            entities = new PropertyDbEntities();

            int ID = Convert.ToInt32(Request.QueryString["PropertyID"]);


            PropertyDetail obj = entities.PropertyDetails.Where(x => x.PropertyID == ID).FirstOrDefault();

            //lblPrice.Text = obj.Price.ToString();
            PropertyLocation propertyLoc = entities.PropertyLocations.Where(x => x.PropertyID == obj.PropertyID).FirstOrDefault();
            lblAddress.Text = propertyLoc.Address + propertyLoc.City + propertyLoc.Region;
            lblType.Text = entities.PropertyTypes.Where(x => x.TypeID == obj.TypeID).Select(y => y.Type).FirstOrDefault().ToString();
            lblSubType.Text = entities.PropertySubtypes.Where(x => x.TypeID == obj.TypeID).Select(y => y.Subtype).FirstOrDefault().ToString();
            lblSize.Text = obj.Size.ToString();
            lblFloorLvl.Text = obj.FloorLevel.ToString();
            lblTenure.Text = entities.PropertyTenures.Where(x => x.TenureID == obj.TenureID).Select(y => y.TenureType).FirstOrDefault().ToString();
            lblDev.Text = obj.Developer.ToString();
            lblListDate.Text = obj.ListedDate.ToString();
            lblMRT.Text = obj.MRT.ToString();
            lblSchool.Text = obj.School.ToString();
            lblChildcare.Text = obj.ChildCare.ToString();
            lblDesc.Text = obj.Description.ToString();

                

       
    }
    protected string FormatUrl(int FriendsAccountID)
    {
        return "PropertyDetails.aspx?PropertyID=" + FriendsAccountID.ToString();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        entities = new PropertyDbEntities();

        PropertyImage propertyImg = new PropertyImage();

        propertyImg.PropertyID = 1;

        
        entities.PropertyImages.Add(propertyImg);
        entities.SaveChanges();
    }
}