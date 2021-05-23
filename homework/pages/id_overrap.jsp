<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        function iduse(obj){
            var id = obj.check;
            if(id.value.length>=8 && id.value.length<=12){
                if(!(id.value[0].charCodeAt(0)>=48 && id.value[0].charCodeAt(0)<=57)){
                    for(var i=0;i<id.value.length;i++){
                        if(((id.value[i].charCodeAt(0)>=33 && id.value[i].charCodeAt(0)<=47)||
                        (id.value[i].charCodeAt(0)>=58 && id.value[i].charCodeAt(0)<=64)||
                        (id.value[i].charCodeAt(0)>=91 && id.value[i].charCodeAt(0)<=96)||
                        (id.value[i].charCodeAt(0)>=123 && id.value[i].charCodeAt(0)<=126))){
                            alert("아이디는 숫자와 영문자만 포함되어야 합니다.")
                            id.value = "";
                            id.focus();
                            return false;
                        }
                    }
                    alert("사용가능한 아이디 입니다.")
                    opener.document.regiform.userid.value = document.overlapFrm.check.value;
                    opener.document.idchecktime++;
                    opener.document.alreadyCheckId = id.value;
                    self.close();
                    
                }
                else{
                    alert("아이디의 첫문자는 숫자로 시작할 수 없습니다.");
                    id.value = "";
                    id.focus();
                    return false;
                }
            }
            else{
                alert("아이디는 8~12자로 작성해야합니다.");
                id.value = "";
                id.focus();
                return false;
            }

        }

    </script>
</head>
<body>
    <form name="overlapFrm">
        <h2>아이디 중복확인하기</h2>
        <input type="text" name="check" value= <%=request.getParameter("id") %> >
        <input type="button" name="submit" onclick="iduse(this.form)" value="중복확인하기">


    </form>
</body>
</html>