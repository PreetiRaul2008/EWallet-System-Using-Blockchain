/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import blockchain.BlockChain;
import cryptography.AES;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import pack.DBConnection;
import pack.DBConnection1;

/**
 *
 * @author PhoenixZone
 */
public class SendMoney extends HttpServlet {

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
            JSONObject json = new JSONObject();
            String semail = aes.encrypt(request.getParameter("email"));

            DBConnection db = new DBConnection();
            DBConnection1 db1 = new DBConnection1();
            ResultSet rs = null, rs1 = null;
            String status = "";
            String remail = aes.encrypt(request.getParameter("receiver_email"));
            double amount = Double.parseDouble(request.getParameter("amount"));
//            String msg = request.getParameter("msg");
            double samount = Double.parseDouble(request.getParameter("samount"));
//            String pin = request.getParameter("pin");
//            String pin1 = "";
            String s = "Success", s1 = "debit";
            Double ramount = 0.0;
            String rifsc = "", saccno = "", raccno = "";
            SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Date date = new Date();
            String timeStamp = format.format(date);
            String balance = "", balance1 = "";
            String sql1 = "Select * from tbl_account_details where account_holder='" + semail + "'";
            rs = db.select(sql1);
            if (rs.next()) {
                samount = Double.parseDouble(rs.getString("balance"));
                balance = rs.getString("balance");
                saccno = rs.getString("account_no");
//                pin1 = rs.getString("tpin");
                status = rs.getString("account_status");
            }
            if (status.equalsIgnoreCase("active")) {
                samount = samount - amount;//deduct amount
                String sql = "Select * from tbl_account_details where account_holder='" + remail + "'";
                rs1 = db.select(sql);
                if (rs1.next()) {
                    ramount = Double.parseDouble(rs1.getString("balance"));
                    balance1 = rs1.getString("balance");
                    raccno = rs1.getString("account_no");
                }
                ramount = ramount + amount;//add amount

                String args[] = {balance1, "" + amount, semail, remail, balance};
                boolean flag = BlockChain.isTransactionDone(args);
                if (flag) {
                    //success
                    json.put("success", "true");
                    json.put("message", "Transaction success");

                } else {
//                       failed
                    json.put("success", "true");
                    json.put("message", "Transaction failed");

                }

            } else {
//account is not active
                json.put("success", "true");
                json.put("message", "Your account is not active.");

            }
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } catch (Exception e) {

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
