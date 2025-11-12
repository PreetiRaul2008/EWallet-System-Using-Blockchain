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
public class GetAllTransactions extends HttpServlet {

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
            String sql = "SELECT * FROM tbl_blockchain WHERE sender_id='" + email + "' OR receiver_id='"+email+"'";
            ResultSet rs = db.select(sql);

            while (rs.next()) {
                JSONObject object = new JSONObject();
                String status="Credit";
                String user_id=email;
                if (rs.getString("sender_id").equals(email)) {
                    status="Debit";
                    user_id=rs.getString("receiver_id");
                }else
                {
                    user_id=rs.getString("sender_id");
                }
                object.put("transaction_id", aes.decrypt(rs.getString("transaction_id")));
                object.put("user_id", aes.decrypt(user_id));
                object.put("account_no", rs.getString("account_no"));
                object.put("transaction_date", aes.decrypt(rs.getString("transaction_date")));
                object.put("status", status);
                object.put("amount", aes.decrypt(rs.getString("amount")));
                array.put(object);

            }
            json.put("TransactionInfo", array);
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
