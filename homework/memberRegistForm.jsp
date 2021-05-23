<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@page import= "homework.membershipDTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration02.html</title>
    <!-- 
        웹폰트 : https://fonts.google.com/
        jQuery UI : 
     -->
   
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
        *{margin:0px auto; font-family: 'Noto Sans KR', sans-serif;}
        .AllWrap{padding:50px;}
        .wrap_regiform{border: 1px solid red; width: 720px; padding:5px 10px;}
        .wrap_regiform>p{text-align: right;}
        .wrap_regiform table{border-top: 2px solid #000000; border-left:1px solid silver; border-right:1px solid silver; border-bottom:1px solid silver; width:100%;}
        .wrap_regiform tr td:nth-child(1){border: 0px solid blue; font-weight: bold; font-size: 0.9em; padding:5px 0 5px 40px;}
        .wrap_regiform tr td:nth-child(1) span.red{color:red;}
        .wrap_regiform tr td:nth-child(2){border: 0px solid blue; font-size: 0.8em; padding:5px 0 5px 5px;}
        .wrap_regiform tr td:nth-child(2) .comment{ color: #777777;}
        .wrap_regiform tr td:nth-child(2) img.pick{ position: relative; top:11px; left:-4px; margin-top:-5px; width:33px;}
        .wrap_regiform tr td:nth-child(2) button{background-color: #333333; color:#ffffff; font-size: 1em; padding:5px; width:100px; border:2px solid #333333;}
        .wrap_regiform tr td:nth-child(2) button:hover{background-color: #727272; cursor:pointer;}
        .wrap_regiform tr td:nth-child(2) label{position: relative; height:20px; top:-2px; left:10px;}
        .wrap_regiform td input{padding:6px; border: 1px solid #cccccc;}
        .wrap_regiform td select{padding:5px; border: 1px solid #cccccc;}
        .w01{width:320px;}
        .w02{width:200px;}
        .w03{width:100px;}
        .w04{width:230px;}
        .w05{width:150px;}
        .w06{width:80px;}
        .s01{width:140px;}
        .s02{width:70px;}
    </style>

   
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
    $( function() {
        //라디오를 버튼모양으로 바꿔주는 jQuery UI
        $("input[type=radio]").checkboxradio({
            icon: false
        });

        //날짜선택을 편리하게 - Date Picker
        $("#birthday").datepicker({
            dateFormat : "yy-mm-dd"
        });    
    } );

    
    //아이디 검증을 위한 전역변수
    var idObj;
    var idFlag;
    window.onload = function(){
        idObj = document.registFrm.id;//아이디 객체
    }
	function idCheck(fn){
		if(!idCapsule()){
            idObj.value="";
            idObj.focus();
            return;
        }
        if(fn.id.value==""){
            alert("아이디를 입력후 중복확인을 해주세요.");
            fn.id.focus();		
        }	
        else{
            fn.id.readOnly = true;
            window.open("./pages/id_overapping.jsp?id="+fn.id.value,
                    "idover", "width=300,height=200");
        }
    }
    function loginValdidate(fn){        
        //일반적인방법
        if(fn.id.value==""){
            alert("아이디를 입력해주세요");
			fn.id.readOnly = false;
			fn.id.focus();
			return false;
        } 
        if(!idCapsule()){
            idObj.value="";
            idObj.focus();
            return false;
        }
        var p1 = fn.pass;
        var p2 = fn.pass2;
        if(p1.value==""){alert("패스워드를 입력해주세요");p1.focus();return false;}
	    if(p2.value==""){alert("패스워드확인을 입력해주세요");p2.focus();return false;}
        if(isPassword(p1.value)==false){
            alert('패스워드는 숫자와 특수기호가 하나이상 포함되야합니다.');
			p1.value="";p2.value="";p1.focus();
            return false;
        }
        if(p1.value!=p2.value){
            alert("패스워드가 틀립니다. 다시 입력해주세요");
            p1.value="";p2.value="";p1.focus();
            return false;
        }        
        if(fn.name.value==""){
            alert("이름을 입력해주세요");fn.name.focus();
            return false;
        } 
        
    }
    function isPassword(param){
        //숫자나 특수기호가 확인되면 true로 변경한다.
        var isNum = false, isSpec = false;
        //숫자가 포함되었는지 확인
        for(var i=0 ; i<param.length ; i++){
            if(param[i].charCodeAt(0)>=48 && param[i].charCodeAt(0)<=57){
                isNum = true;
                console.log("숫자포함됨");
                break;
            }
        }
        for(var i=0 ; i<param.length ; i++){
            if((param[i].charCodeAt(0)>=33 && param[i].charCodeAt(0)<=47)
                || (param[i].charCodeAt(0)>=58 && param[i].charCodeAt(0)<=64)
                || (param[i].charCodeAt(0)>=91 && param[i].charCodeAt(0)<=96)){
                isSpec = true;
                console.log("특수기호포함됨");
                break;
            }
        }
        if(isNum==true && isSpec==true)
            return true;
        else
            return false;
    }
    //아이디가 8~12자 사이가 아니면 false를 반환한다.
    var idLength = function(param){	
        if(!(param.value.length>=8 && param.value.length<=12)){		
            return false;
        }
        return true;
    }
    //아스키코드로 숫자인지 여부확인 : 숫자라면 true를 반환한다.
    function isNumber(param){		
        for(var i=0 ; i<param.length ; i++){
            if(!(param[i].charCodeAt(0)>=48 && param[i].charCodeAt(0)<=57)){
                return false;
            }		
        }
        return true;
    }
    //아이디의 첫문자는 숫자로 시작할수 없다
    var idStartAlpha = function(param){	
        if(isNumber(param.value.substring(0,1))==true){		
            return false;
        }	
        return true;
    }
    //아스키코드로 숫자 or 알파벳인지 확인. 아니면 false반환
    function isAlphaNumber(param){
        for(var i=0 ; i<param.value.length ; i++){			
            if(!((param.value[i].charCodeAt(0)>=97 && param.value[i].charCodeAt(0)<=122) 
                    || (param.value[i].charCodeAt(0)>=65 && param.value[i].charCodeAt(0)<=90)
                    || (param.value[i].charCodeAt(0)>=48 && param.value[i].charCodeAt(0)<=57))){
                return false;	
            }
        }
        return true;
    }
    //아이디검증 로직을 하나로 묶는다.
    function idCapsule(){        
        //1.아이디는 8~12자 이내여야 한다. 즉 7자를 쓰거나 13자를 쓰면 잘못된 아이디로 판단하고 재입력을 요구한다.
        if(!idLength(idObj)){
            alert('아이디는 8~12자만 가능합니다.');
            return false;
        }        
        //2.아이디는 반드시 영문으로 시작해야 한다. 만약 숫자로 시작하면 잘못된 아이디로 판단한다.
        if(!idStartAlpha(idObj)){
            alert("아이디는 숫자로 시작할수 없습니다.");
            return false;
        }	
        //3.영문과 숫자의 조합으로만 구성해야 한다. 특수기호가 들어가거나 한글이 들어갈 경우 잘못된 아이디로 판단한다.
        if(!isAlphaNumber(idObj)){
            alert("아이디는 영문과 숫자만 포함할수 있습니다.");
            return false;
        }        
        return true;
    }
	function inputEmail(frm){		
		if (frm.email_domain.value=='1') {
            /*
            select에서 직접입력을 선택하면
            readonly속성을 비활성화하고, 입력된 내용을 비워준다. 
            */
			frm.email2.readOnly = false;
			frm.email2.value = '';
			frm.email2.focus();
		}
		else {
            /*
            특정 도메인을 선택하면
            선택한 도메인을 입력하고, readonly속성은 활성화한다.
            */
			frm.email2.readOnly = true;
			frm.email2.value = frm.email_domain.value;
		}
	}
	function commonFocusMove(obj, mLength, next_obj){        
        var strLength = obj.value.length;        
        if(strLength>=mLength){
            eval("document.registFrm."+next_obj+".focus()");
        }        
    } 
    </script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    function zipcodeFind(){
        new daum.Postcode({
            oncomplete: function(data) {
                //DAUM 우편번호API가 전달해주는 값을 콘솔에 출력
                console.log("zonecode", data.zonecode);
                console.log("address", data.address);
                //회원 가입폼에 적용
                var f = document.registFrm;//<form>태그의 DOM객체를 변수에 저장
                f.addr1.value = data.zonecode;
                f.addr2.value = data.address;
                f.addr3.focus();
            }
        }).open();
    }
    </script>
</head>

<body>
<form action="registProcess.jsp" method="post" name="registFrm" onsubmit="return loginValdidate(this)">
<div class="AllWrap">
    <div class="wrap_regiform">
        <p>*필수입력사항</p>
        <table class="regi_table">
            <colgroup>
                <col width="180px">
                <col width="*">
            </colgroup>
            <tr>
                <td><span class="red">*</span> 아이디</td>
                <td>
                    <input type="text" class="w01" name="id" value="" />       
                    <button type="button" onclick="idCheck(this.form);">중복확인</button>             
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <span class="comment">※ 3~15자의 영문과 숫자만 가능합니다.</span>                
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 비밀번호</td>
                <td>
                    <input type="password" class="w01" name="pass" value="" />                   
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <span class="comment">
                        ※ 영문/숫자/특수문자 조합 6~20자 이상 입력해주세요. (아이디/전화번호 사용불가)<br>
                        ※ 1234** 비밀번호는 홈페이지 사용에 제한됩니다.
                    </span>
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 비밀번호확인</td>
                <td>
                    <input type="password" class="w01" name="pass2" value="" />
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 이름</td>
                <td>
                    <input type="text" class="w01" name="name" value="" />
                    
                    <label for="radio-1">남</label>
                    <input type="radio" name="gender" id="radio-1" value="남" checked>
                    <label for="radio-2">여</label>
                    <input type="radio" name="gender" id="radio-2" value="여">
                    
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 생년월일</td>
                <td style="padding: 0px 0 5px 5px;">
                    <input type="text" class="w02" name="birth" id="birthday" value="" />
                    <img src="./images/pick.jpg" alt="" class="pick" />
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 주소</td>
                <td>
                    <input type="text" class="w03" name="addr1" value="" />
                    <button type="button" onclick="zipcodeFind();">우편번호찾기</button> 
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="text" class="w04" name="addr2" value="" />                
                    <input type="text" class="w04" name="addr3" value="" />
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 이메일</td>
                <td>
                    <input type="text" class="w05" name="email1" value="" />
                    @
                    <input type="text" class="w05" name="email2" value="" />
                    <select name="email_domain" class="s01" onchange="inputEmail(this.form);">
                        <option value="1">직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="gmail.com">gmail.com</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 휴대폰번호</td>
                <td>
                    <select name="ph_num1" class="s02" onchange="commonFocusMove(this, 3, 'ph_num2');">
                        <option value=""></option>
						<option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select>
                    -
                    <input type="text" class="w06" name="ph_num2" maxlength="4" 
                        value="" onkeyup="commonFocusMove(this, 4, 'ph_num3');" />
                    -
                    <input type="text" class="w06" name="ph_num3" maxlength="4" 
                        value="" onkeyup="commonFocusMove(this, 4, 'ano_num1');" />
                </td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td>
                    <select name="ano_num1" class="s02" onchange="commonFocusMove(this, 3, 'ano_num2');">
                        <option value=""></option>
						<option value="02">02</option>                        
                        <option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
                    </select>
                    -
                    <input type="text" class="w06" name="ano_num2" maxlength="4" value="" onkeyup="commonFocusMove(this, 4, 'ano_num3');" />
                    -
                    <input type="text" class="w06" name="ano_num3" maxlength="4" value="" />
                </td>
            </tr>
        </table>
        <div style="text-align: center; margin-top:10px;">
            <input type="submit" value="회원가입하기">
            <input type="reset" value="작성내용리셋">
        </div>
    </div>
</div>
</form>
</body>
</html>