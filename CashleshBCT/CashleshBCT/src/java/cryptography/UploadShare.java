/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cryptography;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

/**
 *
 * @author Dinesh
 */
public class UploadShare extends HttpServlet {

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

            // get access to file that is uploaded from client
            HttpSession session = request.getSession();
            JSONObject json = new JSONObject();
            PrintWriter out = response.getWriter();
            String imageDataString = request.getParameter("imageData");
            // Converting a Base64 String into Image byte array
            byte[] imageByteArray = decodeImage(imageDataString);

            String savefile = "" + System.currentTimeMillis() + ".jpg";
            

            String path = request.getSession().getServletContext().getRealPath("/");
            String patt = path.replace("\\build", "");

            FileOutputStream imageOutFile = new FileOutputStream(patt + "\\shares\\" + savefile);
            imageOutFile.write(imageByteArray);
            imageOutFile.close();

            json.put("success", "true");
            json.put("ShareImage",savefile);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
///remaining to display on android
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {

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

    public static byte[] decodeImage(String imageDataString) {
        byte[] data = Base64.decodeBase64(imageDataString.getBytes());
        return data;
    }
}
