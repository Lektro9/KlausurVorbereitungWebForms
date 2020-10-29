<%@ Page Title="Produkte" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Produkte.aspx.cs" Inherits="waren.View.Produkte" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Page.Title %></h2>

    <table class="table">
        <tr>
            <th>Artikel Nummer</th>
            <th>Bezeichnung</th>
            <th>Preis</th>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server">

            <ItemTemplate>
                <tr>
                    <td><%# Eval("ArticleNr").ToString() %></td>
                    <td><%# Eval("Bezeichnung").ToString() %></td>
                    <td><%# Eval("Preis").ToString() %></td>
                </tr>
            </ItemTemplate>

        </asp:Repeater>
    </table>
    <div>
        Artikel Nummer:
   
        <input type="number" name="artNr" value="" />
        Preis:
        <input type="number" step="0.01" name="priceInput" value="" />
        <asp:Button ID="Button1" runat="server" Text="Bearbeiten" OnClick="EditBtn" />
    </div>
    <div>
        Artikel erstellen:
        Preis:
        <input type="number" step="0.01" name="priceCreate" value="" />
        Bezeichnung:
        <input type="text" name="bezCreate" value="" />
        <asp:Button ID="Button2" runat="server" Text="Erstellen" OnClick="CreateArtBtn" />
    </div>

    <div>
        Artikel löschen:
        Artikel Nummer:
        <input type="number" name="artNrDelete" value="" />
        <asp:Button ID="Button3" runat="server" Text="Löschen" OnClick="DeleteArtBtn" />
    </div>
</asp:Content>
