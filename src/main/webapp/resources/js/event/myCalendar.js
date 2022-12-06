 
 class MyCalendar{
	
	//	년도를 인수로 넘겨받아 윤년, 평년을 판단해 윤년이면 true, 평년이면 false를 리턴하는 메소드
	isLeapYear(year){
		return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
	}
	
	//	년, 월을 인수로 넘겨받아 그 달의 마지막 날짜를 리턴하는 메소드
	lastDay(year, month){
		const m = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		m[1] = isLeapYear(year) ? 29 : 28;
		return m[month - 1];
	}
	
	//	년, 월, 일을 인수로 넘겨받아 1년 1월 1일 부터 지난 날짜를 계산해 리턴하는 메소드
	totalDay(year, month, day) {
		let sum = (year - 1) * 365 + (year - 1) / 4 - (year - 1) / 100 + (year - 1) / 400;
		for (let i=1; i<month; i++) {
			sum += lastDay(year, i);
		}
		return sum + day;
	}
	
//	년, 월, 일을 인수로 넘겨받아 요일 숫자로 계산해 리턴하는 메소드
//	일요일(0), 월요일(1), 화요일(2), 수요일(3), 목요일(4), 금요일(5), 토요일(6)
	weekDay(year, month, day) {
		return totalDay(year, month, day) % 7;
	}
	
}
 
 // onload
 $(() =>{
	
	var date = new Date();
	console.log(date)
	
	let yyyy = date.getFullYear();
	let mmmm = date.getMonth() + 1;
	console.log(typeof(yyyy));
	console.log(typeof(mmmm));
	
	var weekDay = new MyCalendar();
	console.log(typeof(weekDay));
	let week = weekDay.weekDay(yyyy, mmmm, 1);
	console.log(typeof(week))
	//console.log(`yyyy: ${yyyy}, mmmm: ${mmmm}, weekDay: ${weekDay}`)
	
	console.log(isLeapYear(year))
	//console.log(lastDay(2022, 11))
	//console.log(totalDay(2022, 11, 11))
	//console.log(weekDay(2022, 11, 11))
	
	/*
	$('#thisMonth').html(`${yyyy}년 ${mmmm}월 ${week} `)
	
	week = MyCalendar.weekDay(year, month, 1);
	
	let fcBg = `
		<h1>test</h1>
	`
	$('.fc-bg').children('#fc-bg').html(fcBg);
	*/
})
 
 
 
