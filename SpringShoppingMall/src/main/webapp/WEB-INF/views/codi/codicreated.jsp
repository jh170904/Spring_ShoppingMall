<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../layout/commuNav.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp1 = request.getContextPath();
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Droppable - Revert draggable position</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<link rel="stylesheet" type="text/css"
	href="<%=cp%>/resources/css/codicreated.css?ver=2">
<style type="text/css">
.ctg{
	width: 80px;
	background: #8080ff;
	color: #fff;
	height: 30px;
	border:0;
	margin-right: 5px;
}
#save{
	width: 100px;
	background: #8080ff;
	color: #fff;
	height: 30px;
	border:0;
}

.selceted {
	/*div끼리 영향 안받게*/
	position: absolute;
	top:250px;
	left:150px;
	
}

.selceted img {
	width: 100%;
	height: 100%;
}

</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://cdn.rawgit.com/eligrey/FileSaver.js/5ed507ef8aa53d8ecfea96d96bc7214cd2476fd2/FileSaver.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<script>
	$(function() {

		$(".draggable").draggable({
			revert : true
		});
		//한번씩만 복사되게
		var chk = 0;
		var cloneCount = 1;
		

		$("#droppable").droppable(
				{
					drop : function(event, ui) {
	
						//alert($(ui.draggable).children().children().attr('id'));
					
						if($(ui.draggable).children().attr('class')=='selector'||chk != 1){
						
						$(ui.draggable).children().attr('class','selceted');
						$(ui.draggable).children().clone().attr('id','id'+cloneCount++).appendTo("#container");
						chk=1;
						
						$(ui.draggable).children().attr('class','checked');
						}


					}
				});

		//drop된 객체 10개 까지
		for(var i=1;i<=10;i++){
			//clone된 객체 
			$(document).on("mouseover", "#id"+i, function() {
				$(this).draggable({
					containment : "#droppable",
					scroll : false
				}).resizable({
					//containment : "#droppable",
					ghost : true,
					edges : {
						left : true,
						top : true
					}
				});
			});
		}
	});
</script>
<script type="text/javascript" src="<%=cp%>/resources/js/html2canvas.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<script type="text/javascript">
	function capture() {
		
		var chk=0;
		
		var str="";
		for(var i=0;i<=10;i++){
			if($('#id'+i).children().attr('id')!=null){
				//alert($('#id'+i).children().attr('id'));
				str+=$('#id'+i).children().attr('id')+',';
				chk=1;
			}
		
		}
		
		if(chk==0){
			alert("코디할 옷을 선택해주세요.");
			return;
		}

		$('#str').val(str);

		html2canvas($("#droppable"), {
			onrendered : function(canvas) {
				//document.body.appendChild(canvas);
				//alert(canvas.toDataURL("image/png"));

				$("#imgSrc").val(canvas.toDataURL("image/png"));

				$.ajax({
					type : "post",
					data : $("form").serialize(),
					url : "imageCreate.ajax",
					error : function(a, b, c) {
						alert("사진이 저장되었습니다.");
						sendIt();
					},
					success : function(data) {
						try {
							alert("성공");
						} catch (e) {
							alert('server Error!!');
						}
					}

				});

			}

		});

	}

	function sendIt(){
		
		var f= document.dynAjax;
		
		f.action="<%=cp1%>/codi/insertBoard.action";
		f.submit(); 

		}	
	
</script>

<!-- 위의 버튼에 따라 리스트 동적생성 -->
<script type="text/javascript">
	var idck = 0;
	var f = document.myForm;
	
	$(function() {
		
	    $(".ctg").click(function() {

			var params = "category=" + $(this).val();

	        //alert(params);
	       
	        $.ajax({				
				type:"POST",
				url:"<%=cp%>/codi/category.ajax",
				data: params,
				dataType : 'json',
				//dataType : "",//반환데이터
				success:function(data){
					var result = data.json;

					console.log(JSON.stringify(data));
					
					
					$("#ajax").empty();
					
					var k=1;
					var str="<tr>";

		            $.each(data , function(i){	
		            
		            	str+='<td align="center" style="text-align: center; width:200px;" >';
			            str += '<div class="draggable" style="text-align: center; ">';
		            	str +='<div class="selector" style="width:200px; height:200px; display: inline-block;"  class="ui-widget-content" >';
		            	str +='<img id='+data[i].productId+' alt="" src="../upload/codi/'+data[i].saveFileName+'"  width="200px;" height="200px;"/>';
		            	str +='</div></div>';
		            	str+='</td>';
		            	
		            	if((i+1)%3==0){
		            		str+='</tr><tr>';
		            	}
		           });
		            str+="</tr>";
		           
		            $("#ajax").append(str); 
		            
					$(".draggable").draggable({
						revert : true
					});
				},
				error:function(e){
					alert(e.responseText);
				}
				
			});
	        
	    });
	});

</script>
</head>
</head>
<body>
	<div id="sector1" style="width: 1600px; margin-top: 20px;  margin-left:auto; margin-right:auto;">
		<div id="droppable" class="ui-widget-header"
			style="width: 800px; height: 700px; float: left; border: 2px solid #8080ff; background: white;">
			<div id="container" style="width: 100%; height: 100%;">
			
			
			</div>
		</div>
		<!-- div 리스트 부분 -->

		<div class="panel notice etu_find_store_none no_result"
			style="display: none;">
			<i class="ico"></i>
			<p class="text font_lg">
				<span class="tit_1">상품이 존재하지 않습니다.</span>
			</p>
		</div>

		<div class="imageList">
			<table style="width: 700px; margin-left: 50px;">

				<tr height="30px" style="float:left; position: absolute; left:950px; top:230px;">
					<td><input type="button" value="OUTER" class="ctg"/></td>
					<td><input type="button" value="TOP"  class="ctg"/></td>
					<td><input type="button" value="BOTTOM" class="ctg"/></td>
					<td><input type="button" value="DRESS" class="ctg"/></td>
					<td><input type="button" value="SHOES" class="ctg"/></td>
					<td><input type="button" value="BAG" class="ctg"/></td>
					<td><input type="button" value="ACC" class="ctg"/></td>
				</tr>
				
				<form name="dynAjax">
				<div id="ajax" style=" position: absolute; left:950px; top:300px;">
			
				</div>
				<input type="hidden" name="str" id="str">
				</form>

			</table>
		</div>


	</div>
	
	<div style="text-align: center; margin:10px 0px 40px; ">
	<button onclick="capture();" value="글 저장" id="save">글 저장</button>
	</div>
	<form id="myform">
		<input type="hidden" name="imgSrc" id="imgSrc" />
	</form>
</body>
</html>