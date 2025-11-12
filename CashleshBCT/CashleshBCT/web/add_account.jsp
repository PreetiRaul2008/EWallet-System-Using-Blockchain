<%@page import="pack.DBConnection1"%>
<%@page import="cryptography.AES"%>
<%@page import="pack.MailUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="pack.DBConnection"%>
<%
    DBConnection db = new DBConnection();
    DBConnection1 db1 = new DBConnection1();
    AES aes=new AES();
    String id = aes.encrypt(request.getParameter("id"));
    String sql = "SELECT * FROM tbl_account_details WHERE account_holder='" + id + "'";
    ResultSet rs = db.select(sql);
    String bank_name = "", bank_address = "";
    String email = aes.encrypt(session.getAttribute("email").toString());
    if (rs.next()) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Account Details Already Added!');");
        out.println("location='customers.jsp';");
        out.println("</script>");
    } else {

        String account_number = aes.encrypt(db.getAccountNumber());
        sql = "SELECT * FROM tbl_users WHERE email='" + email + "'";
        rs.close();
        rs = db.select(sql);
        if (rs.next()) {
            bank_address = rs.getString("address");
            bank_name = rs.getString("name");
        }
        sql = "INSERT INTO tbl_account_details(account_holder,bank_name,bank_id,account_no,bank_address) VALUES('" + id + "',"
                + "'" + bank_name + "','" + email + "','" + account_number + "','" + bank_address + "')";
        int row_affected = db.update(sql);
         row_affected = db1.update(sql);
        if (row_affected > 0) {
            
            MailUtil mailUtil=new MailUtil();
            String msg="Dear Customer,\n your account has been activated by bank. Account Details:\n Account No.: "+aes.decrypt(account_number)+"\n by bank: "+aes.decrypt(bank_name);
           String mail[]={aes.decrypt(id)};
//           uncomment below line to send information to customer
             mailUtil.sendMail(mail, mail, "Account Details", msg);
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Account Details Successfully Added!');");
            out.println("location='customers.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Account Details Not Added!');");
            out.println("location='customers.jsp';");
            out.println("</script>");
        }

    }


%>