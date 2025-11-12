/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import cryptography.AES;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pack.DBConnection;
import pack.DBConnection1;
import pack.MailUtil;

/**
 *
 * @author Dinesh
 */
public class AddBank extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            /* TODO output your page here. You may use following sample code. */
            PrintWriter out = response.getWriter();
            AES aes = new AES();
            String state_name = request.getParameter("state_name");
            String bank_name = aes.encrypt(request.getParameter("bank_name"));
            String office_address = aes.encrypt(request.getParameter("office_address"));
            String bank_email = aes.encrypt(request.getParameter("bank_email"));
            String bank_mobile = aes.encrypt(request.getParameter("bank_mobile"));
            String password = aes.encrypt(getAlphaNumericString(6));
            DBConnection con = new DBConnection();
            DBConnection1 con1 = new DBConnection1();
            String sql = "SELECT * FROM tbl_users WHERE email='" + bank_email + "'";
            ResultSet rs = con.select(sql);
            String id = request.getParameter("productId");
            if (id.equals("")) {
                if (rs.next()) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('State Email Already in used!');");
                    out.println("location='banks.jsp';");
                    out.println("</script>");
                } else {
                    sql = "INSERT INTO tbl_users(usertype,email,password,address,mobile,name,parent_id) VALUES('" + aes.encrypt("2") + "','" + bank_email + "','" + password + "','" + office_address + "','" + bank_mobile + "','" + bank_name + "'," + state_name + ")";
                    int row_affected = con.update(sql);
                    row_affected = con1.update(sql);
                    if (row_affected > 0) {

                        //send password email to state government
                        String email[] = {aes.decrypt(bank_email)};
                        String subject = "Account Details";
                        String msg = "Dear Bank Manager, \n Your account has been activated by Central Govt. \n"
                                + "Login Details as Username= " + aes.decrypt(bank_email) + " \n password= " + aes.decrypt(password) + " \n Thank you.";
                        MailUtil mail = new MailUtil();
//                        Uncomment the below line to send account details on mail
                        mail.sendMail(email, email, subject, msg);
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Bank Added Successfully!');");
                        out.println("location='banks.jsp';");
                        out.println("</script>");
                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Bank Not Added!');");
                        out.println("location='banks.jsp';");
                        out.println("</script>");
                    }
                }
            } else {
                sql = "UPDATE tbl_users SET name='" + bank_name + "',mobile='" + bank_mobile + "',address='" + office_address + "',parent_id=" + state_name + " WHERE sr=" + id + "";
                int row_affected = con.update(sql);
                row_affected = con1.update(sql);
                if (row_affected > 0) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Bank Updated Successfully!');");
                    out.println("location='banks.jsp';");
                    out.println("</script>");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Bank Not Updated!');");
                    out.println("location='banks.jsp';");
                    out.println("</script>");
                }
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static String getAlphaNumericString(int n) {

        // chose a Character random from this String 
        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                + "0123456789"
                + "abcdefghijklmnopqrstuvxyz";

        // create StringBuffer size of AlphaNumericString 
        StringBuilder sb = new StringBuilder(n);

        for (int i = 0; i < n; i++) {

            // generate a random number between 
            // 0 to AlphaNumericString variable length 
            int index
                    = (int) (AlphaNumericString.length()
                    * Math.random());

            // add Character one by one in end of sb 
            sb.append(AlphaNumericString
                    .charAt(index));
        }

        return sb.toString();
    }
}
