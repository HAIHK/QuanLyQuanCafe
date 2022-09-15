using QuanLyQuanCafe.DAO;
using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCafe
{
    public partial class fAccountProfile : Form
    {
        private Account loginAccount;

        public Account LoginAccount { get { return loginAccount; } set { loginAccount = value; ChangeAccount(LoginAccount); } }
        public fAccountProfile(Account acc)
        {
            InitializeComponent();

            LoginAccount = acc;
        }

        void ChangeAccount(Account acc)
        {
            txbUserName.Text = LoginAccount.UserName;
            txbDisPlayName.Text = LoginAccount.DisplayName;
        }
        void UpdateAccountInfo()
        {
            string displayName = txbDisPlayName.Text;
            string password = txbPassWord.Text;
            string newPassword = txbNewPass.Text;
            string reendterPass = txbReEnterPass.Text;
            string userName = txbUserName.Text;

            if (!newPassword.Equals(reendterPass))
            {
                MessageBox.Show("Vui lòng nhập lại đúng với mật khẩu mới!");
            }
            else
            {
                if(AccountDAO.Instance.UpdateAccount(userName, displayName, password, newPassword))
                {
                    MessageBox.Show("Cập nhật thành công");
                    if(updateAccount != null)
                        updateAccount(this, new AccountEvent(AccountDAO.Instance.GetAccountByUserName(userName)));
                }
                else
                {
                    MessageBox.Show("Vui lòng nhập lại mật khẩu");
                }
               
            }
        }

        private event EventHandler <AccountEvent> updateAccount;
        public event EventHandler <AccountEvent> UpdateAccount
        {
            add { updateAccount += value; }
            remove { updateAccount -= value; }
        }
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateAccountInfo();
        }
    }
    public class AccountEvent : EventArgs
    {
        private Account acc;

        public Account Acc { get => acc; set => acc = value; }

        public AccountEvent(Account acc)
        {
            this.Acc = acc;
        }
    }
    


}
