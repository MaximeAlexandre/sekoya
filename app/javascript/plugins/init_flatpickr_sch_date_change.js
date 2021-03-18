const date = () => {
    let today = new Date();
    let todayMonth = today.getMonth()+1;
    if (todayMonth < 10) {
        todayMonth = `0${todayMonth}`;
    };
    today = `${today.getFullYear()}-${todayMonth}-${today.getDate()}`;
    return today
}

const verificationDates = () => {
    console.log("azerty")
}

const initFlatpickrSchDateChange = () => {
    const datepickrStart = document.getElementById("start_date_select");
    const datepickrEnd = document.getElementById("end_date_select");

    datepickrStart.addEventListener("change", () => { verificationDates("start") });
    datepickrEnd.addEventListener("change", () => { verificationDates("end") });
}

export {initFlatpickrSchDateChange}
