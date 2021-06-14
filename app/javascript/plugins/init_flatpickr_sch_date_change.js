const date = () => {
    let today = new Date();
    let todayMonth = today.getMonth()+1;
    if (todayMonth < 10) {
        todayMonth = `0${todayMonth}`;
    };
    today = `${today.getFullYear()}-${todayMonth}-${today.getDate()}`;
    return today
}

const verificationDates = (start, end, priority) => {
    if (priority === "start") {
        if (Date.parse(start.value) > Date.parse(end.value)) {

        };
    } else {
        if (Date.parse(start.value) > Date.parse(end.value)) {

        };
    };
}

const initFlatpickrSchDateChange = () => {
    const datepickrStart = document.getElementById("start_date_select");
    const datepickrEnd = document.getElementById("end_date_select");

    datepickrStart.addEventListener("change", () => { verificationDates(datepickrStart,datepickrEnd,"start") });
    datepickrEnd.addEventListener("change", () => { verificationDates(datepickrStart,datepickrEnd,"end") });
}

export {initFlatpickrSchDateChange}
