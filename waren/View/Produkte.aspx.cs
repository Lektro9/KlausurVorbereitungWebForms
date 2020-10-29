using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace waren.View
{
    public partial class Produkte : System.Web.UI.Page
    {
        Controller _verwalter;

        public Controller Verwalter { get => _verwalter; set => _verwalter = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["Verwalter"] != null)
            {
                Verwalter = (Controller)this.Session["Verwalter"];
            }
            else
            {
                this.Response.Redirect(@"~\Default.aspx");
            }
            fillTable();
        }

        public void fillTable()
        {
            Verwalter.openDBConection();
            Verwalter.Produkte = Verwalter.getProdukte();
            Verwalter.closeConnection();

            Repeater1.DataSource = Verwalter.Produkte;
            Repeater1.DataBind();
        }

        protected void EditBtn(object sender, EventArgs e)
        {
            string input = this.Request.Form["artNr"];
            double price = Convert.ToDouble(this.Request.Form["priceInput"]);
            int ArtNr = Convert.ToInt32(input);
             

            Verwalter.openDBConection();
            Verwalter.editProduktID(price, ArtNr);
            Verwalter.closeConnection();

            Response.Redirect(Request.RawUrl);
        }

        protected void CreateArtBtn(object sender, EventArgs e)
        {
            string Bezeichnung = this.Request.Form["bezCreate"];
            double price = Convert.ToDouble(this.Request.Form["priceCreate"]);


            Verwalter.openDBConection();
            Verwalter.createProdukt(price, Bezeichnung);
            Verwalter.closeConnection();

            Response.Redirect(Request.RawUrl);
        }

        protected void DeleteArtBtn(object sender, EventArgs e)
        {
            int ArtNr = Convert.ToInt32(this.Request.Form["artNrDelete"]);

            Verwalter.openDBConection();
            Verwalter.deleteProdukt(ArtNr);
            Verwalter.closeConnection();

            Response.Redirect(Request.RawUrl);
        }
    }
}