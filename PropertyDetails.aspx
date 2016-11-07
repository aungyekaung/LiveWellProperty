<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PropertyDetails.aspx.cs" Inherits="PropertyDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <asp:Image ID ="imgProperty" runat="server" /> <br />
        <asp:Label ID ="lblPrice" runat="server"></asp:Label> <br />
        <asp:Label ID ="lblAddress" runat="server"></asp:Label> <br />
        Type :
        <asp:Label ID ="lblType"  runat="server"></asp:Label> <br />
        Subtype :
        <asp:Label ID ="lblSubType" runat="server"></asp:Label> <br />
        Size :
        <asp:Label ID ="lblSize" runat="server"></asp:Label> <br />
        Floor Level :
        <asp:Label ID ="lblFloorLvl" runat="server"></asp:Label> <br />
        <!-- To put in a bedroom icon /-->
        <asp:Label ID ="lblBedQty" runat="server"></asp:Label> <br />
        <!-- To put in a bathroom icon /-->
        <asp:Label ID ="lblBathQty" runat="server"></asp:Label> <br />
        Tenure :
        <asp:Label ID ="lblTenure" runat="server"></asp:Label> <br />
        Developer :
        <asp:Label ID ="lblDev" runat="server"></asp:Label> <br />
        Listed Date : <!-- maybe a date icon /-->
        <asp:Label ID ="lblListDate" runat="server"></asp:Label> <br />
        Nearest MRT :
        <asp:Label ID ="lblMRT" runat="server"></asp:Label> <br />
        Nearest School :
        <asp:Label ID ="lblSchool" runat="server"></asp:Label> <br />
        Nearest Childcare :
        <asp:Label ID ="lblChildcare" runat="server"></asp:Label> <br />
        Description :
        <asp:Label ID ="lblDesc" runat="server"></asp:Label> <br />
        <asp:Label ID ="lblUser" runat="server"></asp:Label> <br />
    
    </div>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    </form>
</body>
</html>
