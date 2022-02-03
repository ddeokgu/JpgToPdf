<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인 / 회원가입 폼 템플릿</title>
<link rel="stylesheet" href="/resources/css/style.css">
</head>
<body>
	<div class="wrap">
		<div class="form-wrap">
			<div class="button-wrap">
				<div id="btn"></div>
				<button type="button" class="togglebtn" onclick="changeLogin()">LOGIN</button>
				<button type="button" class="togglebtn" onclick="changeRegister()">REGISTER</button>
			</div>
			<div class="social-icons">
				<img src="/resources/image/fb.png" alt="facebook"> 
				<img src="/resources/image/tw.png" alt="twitter"> 
				<img src="/resources/image/gl.png" alt="google">
			</div>
			<form id="login" action="#" class="input-group">
				<input type="text" class="input-field" placeholder="User name" required> 
				<input type="password" class="input-field" placeholder="Enter Password" required> 
				<input type="checkbox" class="checkbox">
				<span>Remember Password</span>
				<button class="submit">Login</button>
			</form>
			<form id="register" action="member/register.do" class="input-group">
				<input type="text" class="input-field" placeholder="User name" required>
				<input type="text" class="input-field" placeholder="Enter ID" required>
				<input type="email" id ="inputEmail" class="input-field" placeholder="Your Email" required>
				<input type="password" id="inputPassword" class="input-field" placeholder="Enter Password" required>
				<button class="submit" onclick="regist(); return false;">REGISTER</button>
			</form>
		</div>
	</div>
</body>
<script>
	let x = document.getElementById("login");
	let y = document.getElementById("register");
	let z = document.getElementById("btn");

	
	
	function changeLogin() {
		x.style.left = "50px";
		y.style.left = "450px";
		z.style.left = "0";
	}

	function changeRegister() {
		x.style.left = "-400px";
		y.style.left = "50px";
		z.style.left = "110px";
	}
	
	function checkEmail(str) {                                                 
	     let reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	     if(!reg_email.test(str)) {                            
	          return false;         
	     }                            
	     else {                       
	          return true;         
	     }                            
	}   

	function checkPassword(pwd) {
		let reg_password = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
		if(!reg_password.test(pwd)) {
		    return false;
		} else {
			return true;
		}
	}

	function registCheck() {
		let email = document.getElementById("inputEmail").value;
		let check = checkEmail(email);
		console.log(check);
		
	}
	
	function regist() {
		let email = document.getElementById("inputEmail").value;
		let password = document.getElementById("inputPassword").value;
		let emailCheck = checkEmail(email);
		let passwordCheck = checkPassword(password);
		if(!emailCheck) {
			alert("이메일을 제대로 입력해 주세요.");
			return false;
		}
		if(!passwordCheck) {
			alert("비밀번호는 최소 8자 이상, 문자와 숫자 조합입니다.");
			return false;
		}
	}
	
	
		
		 
</script>
</html>
