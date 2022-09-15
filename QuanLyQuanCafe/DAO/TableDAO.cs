using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class TableDAO
    {
        private static TableDAO instance;

        public static TableDAO Instance { get { if (instance == null) instance = new TableDAO(); return TableDAO.instance; } private set { TableDAO.instance = value; } }

        public static int TableWidth = 80;
        public static int TableHeight = 80;

        private TableDAO(){ }

        public void SwitchTable(int id1, int id2)
        {
            DataProvider.Instance.ExecuteQuery("USP_SwitchTable @idTable1 , @idTable2 ", new object[] { id1, id2 });
        }
       public List<Table> LoadTableList()
        {
            List<Table> tableList = new List<Table>();

            DataTable data = DataProvider.Instance.ExecuteQuery("USP_GetTableList");

            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                tableList.Add(table);
            }

            return tableList;
        }
        public List<Table> GetListTable()
        {
            List<Table> list = new List<Table>();

            string query = "select * from TableFood";

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                list.Add(table);
            }

            return list;
        }
        public Table GetTableByID(int id)
        {
            Table table = null;

            string query = "select * from TableFood where id = " + id;

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                table = new Table(item);
                return table;
            }

            return table;
        }
        public bool InsertTable( string name)
        {
            string query = string.Format("insert dbo.TableFood (name)values (N'{0}')", name);

            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool UpdateTable(string name, int id)
        {
            string query = string.Format("update dbo.TableFood set name = N'{0}' where id = {1}", name, id);

            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
        public bool DeleteTable(int id)
        {
            string query = string.Format("delete TableFood where id = {0} ", id);

            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
    }
}
