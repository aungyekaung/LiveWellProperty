<%@ Page Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_Default" 
    EnableViewState="True" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*#map_container
        {
            position: fixed;
            top:36%;
            right: 10%;
            width: 50%;
            height:0%;
            /*background-color:#ffd800;
            z-index:initial;
        }

        #map
        {
            position:absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 400px;
            background-color: #00ff90;
            z-index: 4
        }*/

        #search
        {
            position:absolute;
            top: 30%;
            z-index:11;
        }

    </style>
        
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        

<%--    <script>
        function myMap() {
            var mapCanvas = document.getElementById("map");
            var mapOptions = {
                center: new google.maps.LatLng(1.3520830, 103.8198360),
                zoom: 11
            }
            var map = new google.maps.Map(mapCanvas, mapOptions);
        }
    </script>--%>


    <%--<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkAp0Q--Jr_OPwm7ZKxa_pr8JbJOXPtdo&callback=myMap"
        type="text/javascript"></script>
        
        
    <div id="map_container">
        <div id="map"></div>
    </div>
    --%>    
        
            <div id="search">
        <p>
        Enter your address, area, or postal code to find properties near you
        <%--(There&#39;s also a <a href="FindAStoreCS.aspx">C# version</a>...)--%>
        </p>

        <asp:UpdatePanel ID="upSearchUI" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSearch">
                <b>Your Address:</b> <asp:TextBox ID="txtSearch" Width="55%" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqSearch" ControlToValidate="txtSearch" runat="server" ErrorMessage="[Required]" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Button ID="btnSearch" runat="server" Text="Search!" 
                    onclick="btnSearch_Click" /><br />
                <i>Example: Blk53 Strathmore Ave</i> or <i>Clementi</i> or <i>141052</i>
                    
                <br />
                <br />
                <details>
                <summary>Advanced Search</summary>
                    <br />
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </details>

                
        </asp:Panel>

            <asp:Label runat="server" ID="lblNoResults" Visible="false" ForeColor="Red" Font-Italic="true">The address you entered is not known or understood. Try simplifying the address, or enter just a city, region, or postal code...</asp:Label>

            <asp:ListView ID="lvDidYouMean" runat="server">
                <LayoutTemplate>
                    <div style="padding-left: 25px; margin-top: 10px;">
                        <b>Did you mean...</b>
                        <ol>
                            <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                        </ol>
                    </div>
                </LayoutTemplate>

                <ItemTemplate>
                    <li>
                        <asp:HyperLink ID="lnkSelectDYM" runat="server"
                                        NavigateUrl='<%# string.Format("ShowLocation2.aspx?Address={0}", Server.UrlEncode(Container.DataItem.ToString())) %>'
                                        Text='<%# Container.DataItem %>' />
                    </li>
                </ItemTemplate>
            </asp:ListView>
        </ContentTemplate>
        
    </asp:UpdatePanel>
            
        
        
        </div>
    

       
</asp:Content>    