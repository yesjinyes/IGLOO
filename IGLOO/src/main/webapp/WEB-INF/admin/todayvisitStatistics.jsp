<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    //    /IGLOO
%>

<jsp:include page="../header.jsp" />

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/todayvisitStatistics.css" />

<%-- Highcharts --%>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/accessibility.js"></script>

<figure class="highcharts-figure">
    <div id="container"></div>
</figure>

<script type="text/javascript">
$.ajax({
	   url:"<%= ctxPath%>/admin/todayvisitStatisticsJSON.ice",
	   dataType:"json",
	   success: function(json){
		   console.log(json);
		   
		   let todaylogincntarr = [];
		   
		   let logindatearr = [];
		   
		   for(let i=0; i<json.length; i++){
			   
			   todaylogincntarr.push(Number(json[i].todaylogincnt));
			   logindatearr.push(json[i].logindate);
			   
		   }	// end of for----------------
		   
		   Highcharts.chart('container', {
		          chart: {
		              type: 'line'
		          },
		          title: {
		              text: '최근 2주 방문 통계'
		          },
		          xAxis: {
		              type: 'category',
		              labels: {
		                  autoRotation: [-45, -90],
		                  style: {
		                      fontSize: '13px',
		                      fontFamily: 'Verdana, sans-serif'
		                  }
		              }
		          },
		          yAxis: {
		              min: 0,
		              title: {
		                  text: '방문수'
		              }
		          },
		          legend: {
		              enabled: false
		          },
		          tooltip: {
		              pointFormat: '{point.y}명(인원)</b>'
		          },
		          series: [{
		              name: 'Population',
		              colors: '#ff8080',
		              colorByPoint: true,
		              groupPadding: 0,
		              data: [
		                  [logindatearr[0], todaylogincntarr[0]],
		                  [logindatearr[1], todaylogincntarr[1]],
		                  [logindatearr[2], todaylogincntarr[2]],
		                  [logindatearr[3], todaylogincntarr[3]],
		                  [logindatearr[4], todaylogincntarr[4]],
		                  [logindatearr[5], todaylogincntarr[5]],
		                  [logindatearr[6], todaylogincntarr[6]],
		                  [logindatearr[7], todaylogincntarr[7]],
		                  [logindatearr[8], todaylogincntarr[8]],
		                  [logindatearr[9], todaylogincntarr[9]],
		                  [logindatearr[10], todaylogincntarr[10]],
		                  [logindatearr[11], todaylogincntarr[11]],
		                  [logindatearr[12], todaylogincntarr[12]],
		                  [logindatearr[13], todaylogincntarr[13]] 
		              ],
		              dataLabels: {
		                  enabled: true,
		                  rotation: 0,
		                  color: '#FFFFFF',
		                  inside: true,
		                  verticalAlign: 'top',
		                  format: '{point.y}', // one decimal
		                  y: 10, // 10 pixels down from the top
		                  style: {
		                      fontSize: '15px'
		                  }
		              }
		          }]
		      });
		   
	   }
		, error: function(request, status, error){
		     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
})	// end of $.ajax({------------------
</script>

<jsp:include page="../footer.jsp" />
