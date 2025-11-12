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
import org.json.JSONArray;
import org.json.JSONObject;
import pack.DBConnection;

/**
 *
 * @author PhoenixZone
 */
public class GetBeneficiary extends HttpServlet {

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
           AES aes=new AES();
            PrintWriter out = response.getWriter();
            JSONObject json = new JSONObject();
            JSONArray array = new JSONArray();
            String email = aes.encrypt(request.getParameter("email"));

            DBConnection db = new DBConnection();
            String sql = "SELECT * FROM tbl_beneficiary WHERE user_email='" + email + "'";
            ResultSet rs = db.select(sql);

            while (rs.next()) {
                JSONObject object = new JSONObject();
                object.put("beneficiary_id", rs.getString("id"));
                object.put("beneficiary", aes.decrypt(rs.getString("account_holder")));
                object.put("account_no", aes.decrypt(rs.getString("account_no")));
                object.put("ifsc_code", aes.decrypt(rs.getString("ifsc_code")));
                object.put("status", rs.getString("beneficiary_status"));
                object.put("address", aes.decrypt(rs.getString("holder_address")));
                object.put("account_type",aes.decrypt(rs.getString("account_type")));
                object.put("beneficiary_email",aes.decrypt(rs.getString("beneficiary_email")));
                array.put(object);

            }
            json.put("BeneficiaryInfo", array);
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
