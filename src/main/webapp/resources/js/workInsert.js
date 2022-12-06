onload = function(){
    today = new Date();
    console.log("today.toISOString() >>>" + today.toISOString());
    today = today.toISOString().slice(0, 10);
    console.log("today >>>> " + today);
    startDate = document.getElementById("startDate");
    deadline = document.getElementById("deadline");
    startDate.value = today;
    deadline.value = today;
}