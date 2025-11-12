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
public class AddCustomer extends HttpServlet {

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
            AES aes=new AES();
            String customer_name = aes.encrypt(request.getParameter("customer_name"));
            String address = aes.encrypt(request.getParameter("address"));
            String customer_email = aes.encrypt(request.getParameter("customer_email"));
            String customer_mobile = aes.encrypt(request.getParameter("customer_mobile"));
            String password = aes.encrypt(AddBank.getAlphaNumericString(6));
            DBConnection con = new DBConnection();
            DBConnection1 con1 = new DBConnection1();
            String sql = "SELECT * FROM tbl_users WHERE email='" + customer_email + "'";
            ResultSet rs = con.select(sql);
            String id = request.getParameter("productId");
            if (id.equals("")) {
                if (rs.next()) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Email Already in used!');");
                    out.println("location='customers.jsp';");
                    out.println("</script>");
                } else {
                    sql = "INSERT INTO tbl_users(usertype,email,password,address,mobile,name) VALUES('"+aes.encrypt("3")+"','" + customer_email + "','" + password + "','" + address + "','" + customer_mobile + "','" + customer_name + "')";
                    int row_affected = con.update(sql);
                     row_affected = con1.update(sql);
                    if (row_affected > 0) {

                        //send password email to state government
                        String email[] = {aes.decrypt(customer_email)};
                        String subject = "Account Details";
                        String msg = "Dear Customer. \n Your account has been activated by bank.\n"
                                + "Login Details as Username= " + aes.decrypt(customer_email )+ " \n password= " + aes.decrypt(password) + " \n Thank you.";
                        MailUtil mail = new MailUtil();
//                        Uncomment the below line to send account details on mail
                        mail.sendMail(email, email, subject, msg);
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Customer Added Successfully!');");
                        out.println("location='customers.jsp';");
                        out.println("</script>");
                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Customer Not Added!');");
                        out.println("location='customers.jsp';");
                        out.println("</script>");
                    }
                }
            } else {
                sql = "UPDATE tbl_users SET name='" + customer_name + "',mobile='" + customer_mobile + "',address='" + address + "' WHERE sr=" + id + "";
                int row_affected = con.update(sql);
                 row_affected = con1.update(sql);
                if (row_affected > 0) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Customer Updated Successfully!');");
                    out.println("location='customer.jsp';");
                    out.println("</script>");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Customer Not Updated!');");
                    out.println("location='customers.jsp';");
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

}
