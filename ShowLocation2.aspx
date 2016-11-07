<%@ Page Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true" CodeFile="ShowLocation2.aspx.cs" Inherits="ShowLocation2" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #SearchResults
        {         
            position: absolute;
            top:30%;
            width: 50%;
            height: auto;
            z-index:0;
        }

        #map_canvas
        {
            position: absolute;
            top: 30%;
            left:30%;
            width: 50%;
            height: 350px;
        }



    </style>

    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
 <%--   <script type="text/javascript" src="./GoogleMapHelpers.js"></script>--%>

    <!--This is the -->
     

    <script>
        function init_map(map_canvas_id, lat, lng, zoom, markers) {
            var myLatLng = new google.maps.LatLng(lat, lng);

            var options = {
                zoom: zoom,
                center: myLatLng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var map_canvas = document.getElementById(map_canvas_id);

            var map = new google.maps.Map(map_canvas, options);

            if (markers && markers.length > 0) {
                var bounds = new google.maps.LatLngBounds();

                for (var i = 0; i < markers.length; i++) {
                    var marker = new google.maps.Marker(markers[i]);
                    marker.setMap(map);
                    google.maps.event.addListener(marker, 'click', function() {
                        window.location.href = this.url});     
                
                    bounds.extend(marker.getPosition());
                }

                
                
                //google.maps.event.addListenerOnce(map, 'bounds_changed', function (event) {
                //    //this.setZoom(map.getZoom() - 1);

                //    if (this.getZoom() > 15) {
                //        this.setZoom(15);
                //    }
                //});

                map.fitBounds(bounds);
                map.setCenter(bounds.getCenter());

            }
        }

    </script>
 
     <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkAp0Q--Jr_OPwm7ZKxa_pr8JbJOXPtdo"
        ></script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
        <h2>Property Locations Near <asp:Label ID="lblAddress" runat="server"></asp:Label></h2>
    <p>
        <a href="default.aspx">&lt;&lt; Enter a new search...</a>
    </p>

        <div id="map_canvas" class="map-area"></div>


    <asp:UpdatePanel ID="upSearchResults"  UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <div id="SearchResults">
            <asp:ListView ID="lvSearchResults" runat="server" DataSourceID="dsSearchResults">
                <EmptyDataTemplate>
                    <div id="noResults">
                        <p>
                            There are no properties for the address you have entered. Please try again...
                        </p>                        
                    </div>
                </EmptyDataTemplate>

                <LayoutTemplate>
                    <table cellspacing="0" cellpadding="5" rules="all" class="searchResults">
                        <tr>
                            <th>
                                <asp:LinkButton runat="server" ID="lbSortPropertyID" CommandName="Sort" CommandArgument="PropertyID">Property #</asp:LinkButton>
                            </th>  
                            <th>
                                <asp:LinkButton runat="server" ID="lbSortDistance" CommandName="Sort" CommandArgument="DistanceFromAddress">Distance</asp:LinkButton>
                            </th>
                            <th>Address</th>
                        </tr>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                    </table>
                </LayoutTemplate>

                <ItemTemplate>
                    <tr>
                        <td><%# Eval("PropertyID") %></td>
                        <td><%# Eval("DistanceFromAddress", "{0:0.00}")%> km</td>
                        <td>
                            <%# Eval("Address")%><br />
                            <%# Eval("City")%>, <%# Eval("Region")%><br />
                            <%# Eval("Country")%> <%# Eval("PostalCode")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            </div>

            <asp:SqlDataSource ID="dsSearchResults" runat="server" 
                ConnectionString="<%$ ConnectionStrings:PropertyLocationConnectionString %>" 
                
                SelectCommand="SELECT PropertyID, Address, City, Region, Country, PostalCode, Latitude, Longitude, SQRT(POWER(Latitude - @Latitude, 2) + POWER(Longitude - @Longitude, 2)) * 62.1371192 * 1.60934 AS DistanceFromAddress FROM dbo.PropertyLocation WHERE (ABS(Latitude - @Latitude) &lt; 0.03) AND (ABS(Longitude - @Longitude) &lt; 0.03) ORDER BY DistanceFromAddress">
                <SelectParameters>
                    <asp:Parameter Name="Latitude" />
                    <asp:Parameter Name="Longitude" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>



    

</asp:Content>


