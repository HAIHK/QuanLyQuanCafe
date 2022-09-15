using QuanLyQuanCafe.DAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DTO
{
    public class Table
    {
        private Table(string status, string name, int id)
        {
            this.ID = id;
            this.Status = status;
            this.Name = name;
        }
        public Table(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.Status = row["status"].ToString();
        }

        private string status;
        public string Status { get => status; set => status = value; }

        private string name;
        public string Name { get => name; set => name = value; }

        private int iD;
        public int ID { get => iD; set => iD = value; }

        
    }
}
