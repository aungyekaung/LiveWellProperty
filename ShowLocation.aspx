<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ShowLocation.aspx.cs" Inherits="ShowLocation" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .SearchResults
        {
            display: none;
            position: absolute;
            top:50%;
        }

    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
        <h2>Store Locations Near <asp:Label ID="lblAddress" runat="server"></asp:Label></h2>
    <p>
        <a href="FindProperty.aspx">&lt;&lt; Enter a new search...</a>
    </p>

    <asp:UpdatePanel ID="upSearchResults" CssClass="SearchResults" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <asp:ListView ID="lvSearchResults" runat="server" DataSourceID="dsSearchResults">
                <EmptyDataTemplate>
                    <div id="noResults">
                        <p>
                            There are no branches within 15 miles of the address you entered. Please try again...
                        </p>
                        <p>
                            <b>Hint:</b> We have branches in Southern California. Try entering an address like
                            <i>San Diego</i> or <i>92109</i> or <i>Studio City, CA</i>.
                        </p>
                    </div>
                </EmptyDataTemplate>

                <LayoutTemplate>
                    <table cellspacing="0" cellpadding="5" rules="all" class="searchResults">
                        <tr>
                            <th>
                                <asp:LinkButton runat="server" ID="lbSortStoreNumber" CommandName="Sort" CommandArgument="StoreNumber">Store #</asp:LinkButton>
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
                        <td><%# Eval("StoreNumber") %></td>
                        <td><%# Eval("DistanceFromAddress", "{0:0.00}")%> miles</td>
                        <td>
                            <%# Eval("Address")%><br />
                            <%# Eval("City")%>, <%# Eval("Region")%><br />
                            <%# Eval("CountryCode")%> <%# Eval("PostalCode")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>

            <asp:SqlDataSource ID="dsSearchResults" runat="server" 
                ConnectionString="<%$ ConnectionStrings:PropertyLocationConnectionString %>" 
                
                SelectCommand="SELECT StoreNumber, Address, City, Region, CountryCode, PostalCode, Latitude, Longitude, SQRT(POWER(Latitude - @Latitude, 2) + POWER(Longitude - @Longitude, 2)) * 62.1371192 AS DistanceFromAddress FROM Stores WHERE (ABS(Latitude - @Latitude) &lt; 0.25) AND (ABS(Longitude - @Longitude) &lt; 0.25) ORDER BY DistanceFromAddress">
                <SelectParameters>
                    <asp:Parameter Name="Latitude" />
                    <asp:Parameter Name="Longitude" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


