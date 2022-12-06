// event.jsp 페이지에서 캘린더 표시 처리 

const getEventListRequest = new XMLHttpRequest(); //event list를 얻기

var today = new Date(); //오늘 날짜        
var date = new Date();

//지난달
function lastMonth() //이전 달을 today에 값을 저장
{ 
	today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
	autoReload(); //만들기
}

//다음달
function nextMonth()  //다음 달을 today에 저장
{
	today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
	autoReload();
}
	
//오늘선택
function thisMonth(){
	today = new Date();
	autoReload();
}
	
// body 태그에 autoReload() 함수
function autoReload(){
	var nMonth = new Date(today.getFullYear(), today.getMonth(), 1); //현재달의 첫째 날
	var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0); //현재 달의 마지막 날
	var tcal = document.getElementById("calendar"); // 테이블 달력을 만들 테이블
	var yearmonth = document.getElementById("yearmonth"); //  년도와 월 출력할곳
	yearmonth.innerHTML = today.getFullYear() + "년 "+ (today.getMonth() + 1) + "월"; //년도와 월 출력

	if(today.getMonth()+1==12) {//  눌렀을 때 월이 넘어가는 곳
	
		before.innerHTML=("<"+today.getMonth())+"월";
		next.innerHTML="1월"+">";
		
	} else if(today.getMonth()+1==1) {//  1월 일 때
	
		before.innerHTML="<"+"12월";
		next.innerHTML=(today.getMonth()+2)+"월" +">";
		
	} else {	//   12월 일 때
	
		before.innerHTML="<"+(today.getMonth())+"월";
		next.innerHTML=(today.getMonth()+2)+"월"+">";
		
	}

	// 남은 테이블 줄 삭제
	while (tcal.rows.length > 2) {
		tcal.deleteRow(tcal.rows.length - 1);
	}
	
	var row = null;
	row = tcal.insertRow();
	var cnt = 0;
	var dayCheck = (nMonth.getDay()==0) ? 0 : nMonth.getDay(); //토요일을 마지막으로 넣기 위해서.

	 // 1일 시작칸 찾기
	for (i = 0; i < (dayCheck); i++) 
	{
		cnt = cnt + 1;	//요일값
		cell = row.insertCell();
		
		if (i==0 || i==6) { //주말
			cell.style.backgroundColor = "#f7f7f7";
		}
	}

	// 달력 출력
	for (i = 1; i <= lastDate.getDate(); i++) // 1일부터 마지막 일까지
	{ 
		cell = row.insertCell();
		
		var str="";
		
		str += "<div>"+i+"</div>";
		var day = (i<10) ? "0"+i : i;            	
		str += "<div id='"+day+"' style='margin: -8px; width:100px vertical-align:top; height:100px'></div>"; //나중에 원하는 날에 일정을 넣기위해 id값을 날자로 설정
		cell.innerHTML = str;
		
		cnt = cnt + 1;
		if (cnt % 7 == 0) {//토요일
			var str="";
			str += "<div>"+i+"</div>";
			var day = (i<10) ? "0"+i : i;            	
			str += "<div id='"+day+"' style='width:100px vertical-align:top; height:100px'>";
			str += "</div>";
			cell.innerHTML = str;
			row = calendar.insertRow();// 줄 추가
			cell.style.color = "#009de0";
		}
		
		if (cnt % 7 == 1) { //일요일
			var str="";
			str += "<div>"+i+"</div>";
			var day = (i<10) ? "0"+i : i;            	
			str += "<div id='"+day+"' style='width:100px vertical-align:top; height:100px'>";
			str += "</div>";
			cell.innerHTML = str;
			cell.style.color = "#ed5353";
		}
		
		//마지막 날짜가 지나면 토요일까지 칸 그리기
		if(lastDate.getDate() == i && ((cnt % 7) != 0)){
			var add = 7 - (cnt % 7);
			for(var k = 1; k <= add; k++){
				cell = row.insertCell();
				cnt = cnt + 1;
				if (cnt % 7 == 0) {//토요일
					cell.style.backgroundColor = "#f7f7f7";
				}
				if (cnt % 7 == 1) { //일요일
					cell.style.backgroundColor = "#f7f7f7";
				}
			}
		}
		
		//오늘날짜배경색
		if( today.getFullYear() == date.getFullYear() && today.getMonth() == date.getMonth() && i==date.getDate() )
		{
			cell.style.backgroundColor = "#E8E8E8"; //오늘날짜배경색
		}
		
	}
	
	//원하는 날짜 영역에 내용 추가하기
//	var tdId = "01"; //1일
//	var str = "";
//	str += "<div>일정1</div>";
//	str += "<div>일정2</div>";
//	document.getElementById(tdId).innerHTML = str;


	//ajax eventList 요청 함수 호출
	getEventList();
}
	

//ajax eventList 요청 함수
function getEventList(){
	console.log('getEventList()');
	
	let url='./AjaxGetEventList'
//	console.log(url);
	
	getEventListRequest.open('GET', url, true);
	getEventListRequest.send(null);
	getEventListRequest.onreadystatechange = processToGetEventList;
	
}
	
function processToGetEventList(){
	console.log('getEventList() 함수에서 요청한 ajax가 완료후 실행되는 콜백 함수 processToGetEventList()');
	
//	console.log('readyState: ', getEventListRequest.readyState);
//	console.log('Status: ', getEventListRequest.status);
	
	if(getEventListRequest.readyState == 4 && getEventListRequest.status == 200){
		console.log("정상적 통신 확인");
		
		let obj = eval('(' + getEventListRequest.responseText + ')');
//		console.log(obj);
		let eList = obj.eList;
		
//		console.log(eList);
		if(eList.length != '0') {
//			console.log(eList[0])
//			console.log(eList[0][0].eventID)
//			console.log(eList[0][1].startDate)
//			console.log(eList[0][2].endDate)
//			console.log(eList[0][3].subject)
//			console.log(eList[0][4].eventColor)
//			console.log(eList[0][5].deleteDate)
//			console.log(eList[0][6].writeDate)
			// 때아닌 insert가 왜 계속 들어가는겨~~~~
//			if(eList[0][5].deleteDate == 'null'){
				for(let i=0; i<eList.length; i++){
					var isEAlready = false;
					// 당일 이벤트인가?
					if(eList[i][1].startDate == eList[i][2].endDate){
						const sDate = new Date(eList[i][1].startDate);
						var tdId = (sDate.getDate<10) ? "0" + sDate.getDate : sDate.getDate + "";
						var str = "";
//						if(false){	//추가된 일정이 앞에 있음
//							//str += "<br/><br/><div style='background-color:" + eList[i][4].eventColor + "; border: 1px solid darkgray;'>"+ eList[i][3].subject +"</div>";
//							str += eList[i][3].subject;
//							var div = document.createElement("div");
//							document.getElementById(tdId).appendChild("div").innerHTML = str;
//							
//						} else {	//false 추가된 일정이 앞에 없음
							const arr = eList[i][2].endDate.split("-");
							//console.log(arr);
							var tdId = arr[2];
							str += "<br/><div id='e' style='background-color:" + eList[i][4].eventColor + "; border: 1px solid darkgray;'>"+ eList[i][3].subject +"</div>";
							document.getElementById(tdId).innerHTML = str;
							isEAlready = true;
//						}
					}
				}	//eList의 크기만큼 당일 이벤트 for i
				
				for(let i=0; i<eList.length; i++){
					// 연속 이벤트
					console.log(eList[i].length);	//7
					for(let j=0; j<eList[i].length;j++){
						if(eList[i][1].startDate != eList[i][2].endDate){
							const arr1 = eList[i][1].startDate.split("-");
							const arr2 = eList[i][2].endDate.split("-");
							if(arr1[0] === arr2[0] && arr1[1] === arr2[1]){ // satrtDate와 endDate가 같은 년, 월인가?
								const sDate = new Date(eList[i][1].startDate);
								const eDate = new Date(eList[i][2].endDate)
								//startDate 입력
								var tdId = arr1[2];
								var str = "";
								str += "<div style='background-color:" + eList[i][4].eventColor + 
											"; border-top: 1px solid darkgray; border-left: 1px solid darkgray; border-bottom: 1px solid darkgray;'>"+ eList[i][3].subject +"</div>";
								console.log(tdId);
								console.log(document.getElementById(tdId));
								document.getElementById(tdId).innerHTML = str;
								//endDate 입력
								tdId = arr2[2];
								str = "";
								str += "<div style='background-color:" + eList[i][4].eventColor + 
											"; border-top: 1px solid darkgray; border-right: 1px solid darkgray; border-bottom: 1px solid darkgray;'>&nbsp;</div>";
								document.getElementById(tdId).innerHTML = str;
								//console.log(eDate.getDate()-sDate.getDate()-1);	//1
								//console.log(eDate.getDate());
								//console.log(sDate.getDate());
								if((eDate.getDate()-sDate.getDate())>1){
										a = sDate.getDate();
									for(k = 0; k<(eDate.getDate()-sDate.getDate());k++){
										a += 1;
										console.log("tdId: " + tdId);	
										str = "";
										str += "<div style='background-color:" + eList[i][4].eventColor + 
												"; border-top: 1px solid darkgray; border-bottom: 1px solid darkgray;'>&nbsp;</div>";
										console.log(str);
										console.log(document.getElementById(tdId))
										document.getElementById(tdId).innerHTML = str;
									}
								}
							}	//atrtDate와 endDate가 같은 년, 월인가? if
							//else if (arr1[0] === arr2[0] && arr1[1] != arr2[1]){// satrtDate와 endDate가 같은 년, 다른 월인가?
								
							//}
							
								
								
						}	//연속 이벤트 if j
					}	// for j
				}	//연속 이벤트 if i
//			}	//delete 없을 때 if
		}	//eList에 값이 있을 때 if
	} // 통신 可 
}

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	