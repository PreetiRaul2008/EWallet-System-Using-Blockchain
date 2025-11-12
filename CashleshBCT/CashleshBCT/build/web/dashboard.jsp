<%
    HttpServletResponse httpResponse = (HttpServletResponse) response;

    httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.addHeader("Cache-Control", "post-check=0, pre-check=0");
    httpResponse.setHeader("Pragma", "no-cache");
    httpResponse.setDateHeader("Expires", 0);
    if (session.getAttribute("usertype") == null || session.getAttribute("email") == null) {
        response.sendRedirect("logout.jsp");
        return;
    }
%>
<jsp:include page="header.jsp"/>
<!-- Codes by HTML.am -->

<!-- CSS Code -->
<style type="text/css" scoped>
.GeneratedMarquee {
font-family:fantasy;
font-size:xx-large;
line-height:1.3em;
color:#330066;
background-color:#FFFFFF;
padding:1.5em;

}
</style>

<!-- HTML Code -->
<marquee class="GeneratedMarquee" direction="left" scrollamount="9" behavior="scroll">SECURE DIGITAL ECONOMY USING CRYPTOGRAPHIC TECHNIQUES</marquee>


<center><img src="cashless_image.jpg"></img></center>
	
<jsp:include page="footer.jsp"/>