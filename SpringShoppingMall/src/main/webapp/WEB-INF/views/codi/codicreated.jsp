<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../layout/top.jsp"  %>
<%@include file="../layout/mypage.jsp"  %>

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
.codibtn{
	width: 120px;
	background: #8080ff;
	color: #fff;
	height: 30px;
	border:0;
	margin-right: 5px;
}
#save{
	width: 200px;
	background: #8080ff;
	color: #fff;
	height: 50px;
	font-size:19px;
	border:0;
}

.selected {
	/*div끼리 영향 안받게*/
	position: absolute;
	top:300px;
	left:300px;
}

.selected img {
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
		
		//스크롤 이중처리
		//해당 영역안에서는 스크롤을 별도로 처리하게끔 (장점: 바디 스크롤바 고정, 단점: 스크롤 가속 없음)
		$('#ajax').on('mousewheel', function (e) {
		  if (e.originalEvent.wheelDelta >= 120) {
		    this.scrollTop -= 50;
		  } else if (e.originalEvent.wheelDelta <= -120) {
		    this.scrollTop += 50;
		  }
		  return false;
		});

		$(".draggable").draggable({
			revert : true,
			scroll : false
		});
        
		//한번씩만 복사되게
		var chk = 0;
		var cloneCount = 1;
		
		$("#droppable").droppable(
				{
					drop : function(event, ui) {
	
						//alert($(ui.draggable).children().children().attr('id'));
					
						if($(ui.draggable).children().attr('class')=='selector'||chk != 1){
						
						$(ui.draggable).children().attr('class','selected');
						
						Oriobj=$(ui.draggable).children();
						obj=$(ui.draggable).children().clone();
						
						obj.attr('id','id'+cloneCount++).appendTo("#container");
						chk=1;
						
						$(ui.draggable).children().attr('class','selector');
						
						}

						$("#reset").click(function() {
							 $("#container").children().remove();
							 $(ui.draggable).children().attr('class','selector');
						});
								
				}
		});

		//삭제버튼
		$("#delete").click(function() {
			$(".selected").last().remove();
			 
		}); 

		//drop된 객체 30개 까지
		for(var i=1;i<=30;i++){
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
		for(var i=0;i<=30;i++){
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
		
		f.action="<%=cp%>/codi/insertBoard.action";
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
				success:function(data){
					var result = data.json;

					//console.log(JSON.stringify(data));
					
					$("#ajax").empty();
					
					var k=1;
					var str="<table>";
					str+="<tr>";

		            $.each(data , function(i){	
		            
		            	str+='<td align="center" style="text-align: center; width:200px;" >';
			            str +='<div class="draggable" style="text-align: center;">';
		            	str +='<div class="selector" style="width:200px; height:200px; display: inline-block;"  class="ui-widget-content" >';
		            	str +='<img id='+data[i].productId+' alt="" src="../upload/codi/'+data[i].saveFileName+'" width="200px;" height="200px;" style=" z-index:1;"/>';
		            	str +='</div></div>';
		            	str+='</td>';
		            	
		            	if((i+1)%3==0){
		            		str+='</tr><tr>';
		            	}
		           });
		            str+="</tr>";
		            str+="</table>";
		           
		            $("#ajax").append(str); 
		            
					$(".draggable").draggable({
						revert : true,
						helper: "clone",
						appendTo: 'body',
						scroll: false
					});
				},
				error:function(e){
					alert(e.responseText);
				}
				
			});
	        
	    });
	});

</script>
<script type="text/javascript">


</script>
	<div id="sector1" style="width: 1600px; height:750px; margin-top: 20px;  margin-left:auto; margin-right:auto; display: block;">
	
		<table style="width: 700px; margin-bottom: 10px;">
			<tr height="30px" style="float:left; position: relative; ">
				<td><input type="button" value="새로하기" class="codibtn" id="reset"/></td>
				<td><input type="button" value="삭제" class="codibtn" id="delete"/></td>
			</tr>
	    </table>
		
			
		<div id="droppable" class="ui-widget-header"
			style="width: 800px; height: 700px; float: left; background: white;">
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

		<div class="imageList" style="height: 700px;">
			<table style="width: 700px; margin-left: 30px; margin-bottom: 20px;">

				<tr height="30px" style="float:left; position: relative; ">
					<td><input type="button" value="OUTER" class="ctg"/></td>
					<td><input type="button" value="TOP"  class="ctg"/></td>
					<td><input type="button" value="BOTTOM" class="ctg"/></td>
					<td><input type="button" value="DRESS" class="ctg"/></td>
					<td><input type="button" value="SHOES" class="ctg"/></td>
					<td><input type="button" value="BAG" class="ctg"/></td>
					<td><input type="button" value="ACC" class="ctg"/></td>
				</tr>
		    </table>
				
				<form name="dynAjax">
				<div id="ajax" style=" position: relative; margin-left: 20px; width:770px; height:650px; overflow: auto; ">
			
				</div>
				<input type="hidden" name="str" id="str">
				</form>

		</div>


	</div>
	
	<div style="text-align: center; margin:10px 0px 40px; ">
		<button onclick="capture();" value="사진 저장" id="save">사진 저장</button>
		
	</div>
	<form id="myform">
		<input type="hidden" name="imgSrc" id="imgSrc" />
	</form>
<%@include file="../layout/footer.jsp"  %>