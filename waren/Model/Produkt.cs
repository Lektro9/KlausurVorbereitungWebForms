using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace waren
{
    public class Produkt
    {
        int _articleNr;
        string _bezeichnung;
        double _preis;

        public int ArticleNr { get => _articleNr; set => _articleNr = value; }
        public string Bezeichnung { get => _bezeichnung; set => _bezeichnung = value; }
        public double Preis { get => _preis; set => _preis = value; }

        public Produkt()
        {
            ArticleNr = -1;
            Bezeichnung = "gibtsnicht";
            Preis = -1.0;
        }

        public Produkt(int articleNr, string bezeichnung, double preis)
        {
            ArticleNr = articleNr;
            Bezeichnung = bezeichnung;
            Preis = preis;
        }

        public Produkt(Produkt produkt)
        {
            ArticleNr = produkt.ArticleNr;
            Bezeichnung = produkt.Bezeichnung;
            Preis = produkt.Preis;
        }


        public string getAllProductInfos()
        {
            string retVal;
            retVal = this.ArticleNr + " " + this.Bezeichnung + " " + this.Preis;
            return retVal;
        }

    }
}