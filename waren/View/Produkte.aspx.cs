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

            Console.WriteLine("stop");
        }
    }
}