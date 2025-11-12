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
import org.json.JSONObject;
import pack.DBConnection;
import pack.DBConnection1;

/**
 *
 * @author PhoenixZone
 */
public class AddBeneficiary extends HttpServlet {

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
            AES aes=new AES();
            String name = aes.encrypt(request.getParameter("name"));
            String email = aes.encrypt(request.getParameter("email"));
            String beneficiary_email = aes.encrypt(request.getParameter("beneficiary_email"));
            String account_no = aes.encrypt(request.getParameter("account_no"));
            String ifsc = aes.encrypt(request.getParameter("ifsc"));
            String address = aes.encrypt(request.getParameter("address"));
            String account_type = aes.encrypt(request.getParameter("account_type"));
            JSONObject json = new JSONObject();
            String sql = "SELECT * FROM tbl_beneficiary WHERE user_email='" + email + "' and account_no='" + account_no + "'";
            DBConnection db = new DBConnection();
            DBConnection1 db1 = new DBConnection1();
            ResultSet rs = db.select(sql);
            if (rs.next()) {
                json.put("success", "true");
                json.put("message", "Beneficiary details already added");

            } else {

                sql = "SELECT * FROM tbl_account_details WHERE account_no='" + account_no + "' AND account_holder='" + beneficiary_email + "'";
                rs.close();
                rs = db.select(sql);
                if (rs.next()) {
                    sql = "INSERT INTO tbl_beneficiary(user_email,account_holder,account_no,ifsc_code,holder_address,beneficiary_status,account_type,beneficiary_email) VALUES('" + email + "','" + name + "','" + account_no + "','" + ifsc + "','" + address + "','Active','" + account_type + "','" + beneficiary_email + "')";
                    int row_affected = db.update(sql);
                     row_affected = db1.update(sql);
                    if (row_affected > 0) {
                        json.put("success", "true");
                        json.put("message", "Beneficiary Added Successfully..");
                    } else {
                        json.put("success", "true");
                        json.put("message", "Error..");
                    }
                } else {
                    json.put("success", "true");
                    json.put("message", "Beneficiary Details not found in database");
                }
            }

            response.setContentType("application/json");
            response.getWriter().write(json.toString());
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
