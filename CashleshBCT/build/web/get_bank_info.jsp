<%@page import="cryptography.AES"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="pack.DBConnection"%>
<%
    try {
        String id = request.getParameter("id");
        AES aes =new AES();
        String sql = "SELECT * FROM tbl_users WHERE sr=" + id + "";
        DBConnection con = new DBConnection();
        ResultSet rs = con.select(sql);
        JSONObject json = new JSONObject();
        if (rs.next()) {
            json.put("bank_name", aes.decrypt(rs.getString("name")));
            json.put("bank_email", aes.decrypt(rs.getString("email")));
            json.put("bank_mobile", aes.decrypt(rs.getString("mobile")));
            json.put("bank_address", aes.decrypt(rs.getString("address")));
            json.put("sr", rs.getString("sr"));
        }
        response.setContentType("application/json");
        response.getWriter().write(json.toString());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>