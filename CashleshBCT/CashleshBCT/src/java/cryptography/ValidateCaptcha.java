/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cryptography;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import pack.DBConnection;

/**
 *
 * @author Dinesh
 */
public class ValidateCaptcha extends HttpServlet {

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
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            System.out.println("password is :" + password);
            System.out.println("email :" + email);
            String uname = "";
            DBConnection db = new DBConnection();
            Connection con = db.con;
            Statement st = con.createStatement();
            JSONObject json = new JSONObject();
            AES aes = new AES();
            String orgPass = "";
            String sql = "SELECT * FROM tbl_users WHERE email='" + aes.encrypt(email) + "'";
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                uname = rs.getString("sr");
                orgPass = rs.getString("password");
            }
            ServletContext sc = this.getServletContext();
            String sg = sc.getRealPath("/");
            String path = sg.substring(0, sg.indexOf("build"));
            path = path + "web\\password\\";

            sql = "SELECT * from setpassword WHERE UserName='" + uname + "' and password='" + password + "'";
            System.err.println(sql);
            rs.close();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                json.put("success", "true");
                json.put("password", orgPass);
                String filename = rs.getString("imageName");
                File file = new File(path + filename);
                file.delete();
                sql = "DELETE FROM setpassword WHERE UserName='" + uname + "'";
                int row_affetcted = st.executeUpdate(sql);
            } else {
                json.put("failed", "true");
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
