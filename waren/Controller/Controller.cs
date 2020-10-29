using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace waren
{
    public class Controller
    {
        List<Produkt> _produkte;
        MySqlConnection _mysqlconnection;
        string _connectionString;

        public List<Produkt> Produkte { get => _produkte; set => _produkte = value; }
        public MySqlConnection Mysqlconnection { get => _mysqlconnection; set => _mysqlconnection = value; }
        public string ConnectionString { get => _connectionString; set => _connectionString = value; }

        public Controller()
        {
            Produkte = new List<Produkt>();
            Mysqlconnection = new MySqlConnection();
            ConnectionString = $"server=127.0.0.1;port=3306;user id=root; password=; database=waren; SslMode=none";
        }

        public Controller(List<Produkt> produkte)
        {
            this.Produkte = produkte;
        }

        public Produkt changeProductPrice(int articleNr, double newPrice)
        {
            Produkt retVal;
            retVal = Produkte.Find(p => p.ArticleNr == articleNr);
            retVal.Preis = newPrice;
            return retVal;
        }


        public List<Produkt> getProdukte()
        {
            List<Produkt> retVal = new List<Produkt>();
            // string SQLString = "SELECT * FROM `produkte` WHERE `testtable`.`id` = @id;";
            string SQLString = "SELECT * FROM `produkte`";
            MySqlCommand command = new MySqlCommand(SQLString, Mysqlconnection);
            // command.Parameters.AddWithValue("@id", id);
            MySqlDataReader rdr = command.ExecuteReader();

            while (rdr.Read())
            {
                Produkt p = new Produkt(
                    Convert.ToInt32(rdr.GetValue(0)),
                    rdr.GetValue(1).ToString(),
                    Convert.ToDouble(rdr.GetValue(2))
                    );
                retVal.Add(p);
            }
            rdr.Close();

            return retVal;
        }

        public void createProdukt(double price, string bezeichnung)
        {
            string SQLString = "INSERT INTO `produkte` (`Artikelnummer`, `Bezeichnung`, `Preis`) VALUES (NULL, @bez, @preis);";
            MySqlCommand command = new MySqlCommand(SQLString, Mysqlconnection);
            command.Parameters.AddWithValue("@bez", bezeichnung);
            command.Parameters.AddWithValue("@preis", price);
            executeSQLCommand(command);
        }

        public void deleteProdukt(int artNr)
        {
            string SQLString = "DELETE FROM `produkte` WHERE `produkte`.`Artikelnummer` = @id";
            MySqlCommand command = new MySqlCommand(SQLString, Mysqlconnection);
            command.Parameters.AddWithValue("@id", artNr);
            executeSQLCommand(command);
        }

        public void editProduktID(double price, int artNr)
        {
            string SQLString = "UPDATE `produkte` SET `Preis` = @preis WHERE `produkte`.`Artikelnummer` = @id;";
            MySqlCommand command = new MySqlCommand(SQLString, Mysqlconnection);
            command.Parameters.AddWithValue("@id", artNr);
            command.Parameters.AddWithValue("@preis", price);
            executeSQLCommand(command);
        }

        public bool openDBConection()
        {
            try
            {
                Mysqlconnection.ConnectionString = ConnectionString;
                Mysqlconnection.Open();
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        private bool executeSQLCommand(MySqlCommand command)
        {
            bool retVal = false;
            int anzahl = -1;
            try
            {
                anzahl = command.ExecuteNonQuery();
                retVal = true;
            }
            catch (MySqlException e)
            {
                Mysqlconnection.Close();
                retVal = false;
                throw;
            }
            return retVal;
        }

        public void closeConnection()
        {
            Mysqlconnection.Dispose();
            Mysqlconnection.Close();
        }


    }
}