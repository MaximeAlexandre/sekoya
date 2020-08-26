const date = () => {
    let today = new Date();
    let todayMonth = today.getMonth()+1;
    if (todayMonth < 10) {
        todayMonth = `0${todayMonth}`;
    };
    today = `${today.getFullYear()}-${todayMonth}-${today.getDate()}`;
    return today
}

const startingHour = () => {
    let hourMin = 0;
    if (new Date().getMinutes() != 0) {
        hourMin = new Date().getHours() + 2;
    } else {
        hourMin = new Date().getHours() + 1;
    }
    return hourMin
}

const hideUnusedEnd = (option, startHour) => {
    if (option.value <= startHour) {
        option.classList.add('hidden');
    } else {
        option.classList.remove('hidden');
    }
}

const pluriel = (duree) => {
    let hour = ""
        if ( duree === 1 ) {
            return hour = "heure"
        } else {
            return hour = "heures"
        }
}

const changeDuration = () => {
    const startHour = Number(document.getElementById("start_time").value);
    const endHour = document.getElementById("end_time");
    let endHourUse = Number(endHour.value);
    if (endHourUse <= startHour) {
        endHourUse = startHour + 1
        endHour.value = String(endHourUse);
    }

    const duree = endHourUse - startHour;
    const hour = pluriel(duree)
    
    const total = document.getElementById("total");
    const price = Number(total.dataset.price);
    total.innerText = `${duree} ${hour} - Total : ${duree*price} €`;

    for (let option of endHour.options) {
        hideUnusedEnd(option, startHour)
    }

}

const visible= (day) => {
    const startHour = document.getElementById("start_time");
    const endHour = document.getElementById("end_time");
    const block = document.getElementById("select_booking_hours");
    const today = date();
    let hourMin = startingHour()
    if (hourMin < Number(startHour.options[0].value)) {
        hourMin = Number(startHour.options[0].value);
    }
    const store_start = Number(startHour.options[0].value)
    if (day === today) {
        if (hourMin > Number(startHour.value)) {
            startHour.value = hourMin;
        };
        if (hourMin > 20) {
            block.classList.add('hidden');
            startHour.value = store_start;
            hourMin = store_start;
        };
    } else {
        block.classList.remove('hidden');
    };

    for (let option of startHour.options) {
        if (day === today) {
            if (Number(option.value) < hourMin) {
                option.classList.add('hidden');
            } else {
                option.classList.remove('hidden');
            };
        } else {
                option.classList.remove('hidden');
        };
    };

    for (let option of endHour.options) {
        if (day === today) {
            let endHourUse = Number(endHour.value);
            if (endHourUse <= Number(startHour.value)) {
                endHourUse = Number(startHour.value) + 1
                endHour.value = String(endHourUse);
            }
            const duree = endHourUse - Number(startHour.value);
            const hour = pluriel(duree)
            const total = document.getElementById("total");
            const price = Number(total.dataset.price);
            total.innerText = `${duree} ${hour} - Total : ${duree*price} €`;
            for (let option of endHour.options) {
                hideUnusedEnd(option, Number(startHour.value))
            }
        } else {
            hideUnusedEnd(option, Number(startHour.value));
        }
    }
}

const initBookingChoice = () => {
    const start = document.getElementById("start_time");
    const end = document.getElementById("end_time");
    const day = document.getElementById("example-date-input")
    start.addEventListener("change", changeDuration);
    end.addEventListener("change", changeDuration);
    day.addEventListener("change", () => { visible(day.value) });
}
export { initBookingChoice };
