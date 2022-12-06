// 김태형 (Terry) - registerForm 기능용 js 파일

onload = function () {
	$('#accountID').focus();
}

// 폼 중 값이 하나라도 입력이 안되면 false 리턴	
function joinCheck(obj) {
	
	// 아이디 폼 체크	
	if (!obj.accountID.value || obj.accountID.value.trim().length == 0) {
		window.alert('아이디가 입력되지 않았습니다.')
		obj.accountID.focus();
		return false;
	} 
	
	// 패스워드 폼 체크
	if (!obj.accountPassword.value || obj.accountPassword.value.trim().length == 0) {
		window.alert('패스워드가 입력되지 않았습니다.')
		obj.accountPassword.focus();
		return false;
	}
	
	//	이름 폼 체크
	if (!obj.userName.value || obj.userName.value.trim().length == 0) {
		window.alert('이름이 입력되지 않았습니다.')
		obj.userName.focus();
		return false;
	}
	
	// 주민등록번호 폼 체크
	if (!obj.registerNumber.value || obj.registerNumber.value.trim().length == 0) {
		window.alert('주민등록번호가 입력되지 않았습니다.')
		obj.registerNumber.focus();
		return false;
	}
	
	// 전화번호 폼 체크
	if (!obj.mobileNumber.value || obj.mobileNumber.value.trim().length == 0) {
		window.alert('전화번호가 입력되지 않았습니다.')
		obj.mobileNumber.focus();
		return false;
	} else if (obj.mobileNumber.value.substring(0, 3) != '010') {
		window.alert('전화번호는 010으로 시작해야 합니다.')
		obj.mobileNumber.focus();
		return false;
	}
	
	// 이메일 폼 체크
	if (!obj.email.value || obj.email.value.trim().length == 0) {
		window.alert('이메일이 입력되지 않았습니다.')
		obj.email.focus();
		return false;
	} else if (!obj.email.value.includes('@')) {
		window.alert('이메일은 반드시 "@" 을 사용해야 합니다.')
		obj.email.focus();
		return false;
	} else if (!(obj.email.value.includes('.com') || obj.email.value.includes('.net') || obj.email.value.includes('.co.kr') || obj.email.value.includes('.ac.kr'))) {
		window.alert('이메일 형식이 올바르지 않습니다.')
		obj.email.focus();
		return false;
	}
	
window.alert('회원가입이 완료되었습니다.');
return true;
}

// id 검사
function idCheck() {
	
	let ID = $('#accountID').val().trim();
	let chkID = /[^a-z|^A-Z|^0-9]/g;

	if (ID.length == 0 || ID.length > 20) {
		window.alert('아이디는 6자 이상 20자 이내로 작성해야 합니다.')
		document.getElementById('accountID').value = '';
		$('#idCheckMsg').html('아이디는 영문자, 숫자 포함 20자 이내로 작성하여야 합니다.')
		$('#idCheckMsg').css('color', 'red')
		$('#accountID').focus();
	} else if (ID.length >=1 && ID.length < 6) {
		alert('아이디는 6자 이상 20자 이내로 작성해야 합니다.')
		document.getElementById('accountID').value = '';
		$('#accountID').focus();
	} else if (ID.search(chkID) != -1) {
		window.alert('아이디는 영문자, 숫자 포함 20자 이내로 작성하여야 합니다.')
		document.getElementById('accountID').value = '';
		$('#idCheckMsg').html('아이디는 영문자, 숫자 포함 20자 이내로 작성하여야 합니다.')
		$('#idCheckMsg').css('color', 'red')
		$('#accountID').focus();
	} else {
		$('#idCheckMsg').html('사용 가능한 아이디 입니다.')
		$('#idCheckMsg').css('color', 'green')
	}
}

/*		
// id 중복 검사
function idDuplicateCheck(obj) {
	let ID = obj.accountID.value;
	let userList = new userInfoSelectList();
	console.log('userList' + userList);
	
	if (userList.accountID.value == ID) {
		window.alert('중복된 아이디 입니다.')
		document.getElementById('accountID').value = '';
		$('#accountID').focus();
		return false;
	} else if (ID.length == 0 || ID.length > 20) {
		window.alert('아이디는 6자 이상 20자 이내로 작성해야 합니다.')
		document.getElementById('accountID').value = '';
		$('#idCheckMsg').html('아이디는 영문자, 숫자 포함 20자 이내로 작성하여야 합니다.')
		$('#idCheckMsg').css('color', 'red')
		return false;
	} else if(ID.length >=1 && ID.length < 6) {	
		alert('아이디는 6자 이상 20자 이내로 작성해야 합니다.')
		document.getElementById('accountID').value = '';
		return false;
	} else {
		window.alert('사용가능한 아이디 입니다.')
	}
return true;
}	
*/

 
// PW 검사 
function pwCheck() {
	
	let Password = $('#accountPassword').val().trim();
	let Password2 = $('#accountPassword2').val().trim();
	
	if (Password != "" && Password2 != "") {
		if (Password == Password2) {
			$('#pwCheckMsg').html('비밀번호가 일치합니다.')
			$('#pwCheckMsg').css('color', 'green')
		} else if (Password.length < 6) {
			window.alert('비밀번호는 6자 이상 입력해야합니다.');
			document.getElementById('accountPassword').value = '';
			document.getElementById('accountPassword2').value = '';
			$('#accountPassword').focus();
		} else if (Password.length > 20) {
			window.alert('비밀번호는 20자 이하로 입력해야합니다.');
			document.getElementById('accountPassword').value = '';
			document.getElementById('accountPassword2').value = '';
			$('#accountPassword').focus();
		} else {
			$('#pwCheckMsg').html('비밀번호가 일치하지 않습니다.')	
			$('#pwCheckMsg').css('color', 'red')
		}
	}
	if (Password == "" && Password2 == "") {
		$('#pwCheckMsg').html('')
	}
}

// 주민등록번호 유효성 검사
function regCheck() {
	
	let registerNumber = document.getElementById('registerNumber').value
	let check = '234567892345';
	let chkRegNum = /[^0-9]/g;
	
	let sum = 0;
	for (let i = 0; i < 13; i++) {
		sum += registerNumber.charAt(i) * check.charAt(i)
	}
	
	// 앞 부분 월 / 일 체크 / 윤년평년
	// 유효한 주민등록번호여도 월, 일 안맞으면 false
	
	let form = (11 - (sum % 11)) % 10;
	if (registerNumber.substring(2, 4) > 12) {
		window.alert('주민등록번호상 월은 12월을 넘어갈 수 없습니다.')
		document.getElementById('registerNumber').value = "";
		$('#registerNumber').focus();
	} else if (registerNumber.substring(4, 6) > 31) {
		window.alert('주민등록번호상 일은 31일을 넘어갈 수 없습니다.')
		document.getElementById('registerNumber').value = "";
		$('#registerNumber').focus();
	} else if (registerNumber.substring(6) >= 5000000) {
		window.alert('해당 주민번호는 아직 사용 불가합니다.')
		document.getElementById('registerNumber').value = "";
		$('#registerNumber').focus();
	} else if (registerNumber.search(chkRegNum) != -1) {
		window.alert('주민번호에는 숫자만 기입해주세요')
		document.getElementById('registerNumber').value = "";
		$('#registerNumber').focus();
	} else if (form != registerNumber.substring(12, 13)) {
		window.alert('유효하지않은 주민등록번호 입니다.')
		document.getElementById('registerNumber').value = "";
		$('#registerNumber').focus();
	} else { 
		window.alert('유효한 주민등록번호 입니다.')
	}
}	

// 이름 검사	
function nameCheck() {
	
	let userName = $('#userName').val();
	let chkName = /[^ㄱ-ㅎ|^ㅏ-ㅣ|^가-힣]/g;
	
	if (userName.length > 6) {
		window.alert('성함은 한글 6자 이내로 작성 해야합니다.');
		document.getElementById('userName').value = "";
	} else if (userName.search(chkName) != -1) {
		window.alert('성함은 한글 6자 이내로 작성 해야합니다.')
		document.getElementById('userName').value = '';
		$('#userName').focus();
	}
}

// 휴대폰번호 검사
function mobileCheck() {
	
	let mobileNumber = $('#mobileNumber').val();
	let chkMobileNum = /[^0-9]/g;
	
	if (mobileNumber.length > 11) {
		window.alert('휴대전화번호는 11자리 입니다.')
		document.getElementById('mobileNumber').value = "";
		$('#mobileNumber').focus();
	} else if (mobileNumber.search(chkMobileNum) != -1) {
		window.alert('휴대전화번호는 숫자만 입력해주세요.')
		document.getElementById('mobileNumber').value = "";
		$('#mobileNumber').focus();
	} 
}	
	

