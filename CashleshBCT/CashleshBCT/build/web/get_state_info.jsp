<%@page import="cryptography.AES"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="pack.DBConnection"%>
<%
    try {
        AES aes=new AES();
        String id = request.getParameter("id");
        String sql = "SELECT * FROM tbl_users WHERE sr=" + id + "";
        DBConnection con = new DBConnection();
        ResultSet rs = con.select(sql);
        JSONObject json = new JSONObject();
        if (rs.next()) {
            json.put("state_name", aes.decrypt(rs.getString("name")));
            json.put("state_email", aes.decrypt(rs.getString("email")));
            json.put("state_mobile", aes.decrypt(rs.getString("mobile")));
            json.put("state_address", aes.decrypt(rs.getString("address")));
            json.put("sr", rs.getString("sr"));
        }
        response.setContentType("application/json");
        response.getWriter().write(json.toString());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>