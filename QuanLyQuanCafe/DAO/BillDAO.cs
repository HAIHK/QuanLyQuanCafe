using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance { get {if (instance == null) instance = new BillDAO(); return BillDAO.instance; } private set { BillDAO.instance = value; } }


        private BillDAO() { }
        
        public int GetUnCheckBillIDByTableID(int id)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("select * from dbo.Bill where idTable = " + id +"and status = 0");

            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;
            }
            return -1;
        }

        public void CheckOut(int id, int discount, float totalPrice)
        {
            string query = "update dbo.Bill set dateCheckOut = GETDATE(), status = 1, " + " discount = " + discount + ", totalPrice = " + totalPrice + " where id = " + id;
            DataProvider.Instance.ExecuteNonQuery(query);
        }
        public void InsertBill(int id)
        {
            DataProvider.Instance.ExecuteNonQuery("exec USP_InsertBill @idTable", new object[]{id});
        }
        public DataTable GetBillListByDate(DateTime checkIn, DateTime checKOut)
        {
            return DataProvider.Instance.ExecuteQuery("exec USP_GetListBillByDate @checkIn , @checkOut", new object[] { checkIn, checKOut });
        }
        public DataTable GetBillListByDateAndPage(DateTime checkIn, DateTime checKOut, int pageNum)
        {
            return DataProvider.Instance.ExecuteQuery("exec USP_GetListBillByDateAndPage @checkIn , @checkOut , @page", new object[] { checkIn, checKOut, pageNum });
        }
        public int GetNumBillListByDate(DateTime checkIn, DateTime checKOut)
        {
            return (int)DataProvider.Instance.ExecuteScalar("exec USP_GetNumBillByDate @checkIn , @checkOut", new object[] { checkIn, checKOut });
        }
        public int GetMaxIDBill()
        {
            try
            {
                return (int)DataProvider.Instance.ExecuteScalar("select max(id) from dbo.Bill");
            }
            catch 
            {
                return 1;
            }
        }
    }
}
