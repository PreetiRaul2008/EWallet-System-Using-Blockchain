<%@page import="pack.DBConnection1"%>
<%@page import="cryptography.AES"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="pack.DBConnection"%>
<%
    try {
        AES aes=new AES();
        String id = request.getParameter("id");
        String sql = "SELECT * FROM tbl_users tu inner join tbl_account_details ta on tu.email=ta.account_holder WHERE tu.sr=" + id + "";
        DBConnection con = new DBConnection();
        DBConnection1 con1 = new DBConnection1();
        ResultSet rs = con.select(sql);
        JSONObject json = new JSONObject();
        if (rs.next()) {
            json.put("bank_name", aes.decrypt(rs.getString("bank_name")));
            json.put("bank_email", aes.decrypt(rs.getString("bank_id")));
            json.put("account_no", aes.decrypt(rs.getString("account_no")));
            json.put("balance", rs.getString("balance"));
            json.put("bank_address", aes.decrypt(rs.getString("bank_address")));
            json.put("sr",rs.getString("account_id"));
            json.put("status",aes.decrypt(rs.getString("account_status")));
        }
        response.setContentType("application/json");
        response.getWriter().write(json.toString());
    } catch (Exception e) {
        e.printStackTrace();
    }
%>