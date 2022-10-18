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
    <title>JPGTOPDF</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Simple line icons-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.5.5/css/simple-line-icons.min.css" rel="stylesheet" />
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/resources/css/styles.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<style>
    #my-spinner { width: 100%; height: 100%; top: 0; left: 0; display: none; opacity: .6; background: silver; position: absolute; z-index: 2; }
    #my-spinner div { width: 100%; height: 100%; display: table; }
    #my-spinner span { display: table-cell; text-align: center; vertical-align: middle; }
    #my-spinner img { background: white; padding: 1em; border-radius: .7em; }
</style>
<body id="page-top">
<!-- Header-->
<header class="masthead d-flex align-items-center">
    <div id='my-spinner'>
        <div>
    <span>
    	<img src='/resources/images/loader_spinner.gif'>
    </span>
        </div>
    </div>
    <div class="container px-4 px-lg-5 text-center">
        <h1 class="mb-1">JPGTOPDF</h1>
        <form method="post" id="fileForm" action="#" enctype="multipart/form-data">
            <input type="file" id="file" name="multiFile" accept="image/jpeg, image/png, image/jpg" multiple >
        </form>
        <a class="btn btn-primary btn-xl" href="#about" onclick="sendData()">CONVERT</a>

    </div>
</header>
<!-- About-->
<footer class="footer text-center">
    <div class="container px-4 px-lg-5">
        <p class="text-muted small mb-0">Copyright &copy; thecar2022</p>
        <p class="text-muted small mb-0">ddeokgu@gmail.com</p>
    </div>
</footer>
<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>



</body>

<script>

    function chk(obj) {
        if (/(\.gif|\.jpg|\.jpeg\|.png)$/i.test(obj.value) == false) {
            alert("이미지 형식의 파일을 선택하십시오");
            return false;
        }
    }

    function fileCheck() {
        let fileCheck = document.querySelector("#file").value;
        if(!fileCheck){
            alert("파일을 첨부해 주세요");
            return false;
        } else {
            return true;
        }

    }

    function sendData() {
        let check = fileCheck();
        if(check) {
            let formData = new FormData($('#fileForm')[0]);
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: '/pdfConvert/pdf.do',
                data: formData,
                processData: false,
                contentType: false,
                cache: false,
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("Authorization", window.localStorage["accessToken"]);
                    $("#my-spinner").show();
                },
                success: function (data, status, xhr) {
                    let filename = xhr.getResponseHeader("X-Filename");
                    let _blob = new Blob([xhr.response], {type : "application/pdf"});
                    let link = document.createElement("a");
                    //link.href = window.URL.createObjectURL(_blob);
                    link.href = "/pdfConvert/fileDownload.do?fileName="+filename;
                    link.download = filename;
                    link.click();
                    $("#my-spinner").hide();
                },
                error: function (e) {
                    alert("프로세스 진행 중 오류가 발생하였습니다.");
                    $("#my-spinner").hide();
                }
            });
        }
    }




</script>
</html>
