<%--
  Created by IntelliJ IDEA.
  User: kimdeokha
  Date: 2022/08/11
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello</title>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>

<body>

<h1>성공기원 두번째</h1>

<form method="post" id="fileForm" action="#" enctype="multipart/form-data">
    <input type="file" id="file" name="multiFile" multiple>
</form>

<button id = "convert" onclick = "javascript:sendData()">Convert</button>

</body>

<script>

    function sendData() {
        let formData = new FormData($('#fileForm')[0]);
        console.log("hihi");

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: '/pdfConvert/pdf.do',
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            success: function (result) {
                console.log(result);
            },
            error: function (e) {
            }
        });
    }




</script>
</html>
