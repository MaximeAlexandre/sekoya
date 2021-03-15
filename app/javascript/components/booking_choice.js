const newDaySpotDictionary = (day) => {
    const dataFree = document.getElementById("remaining-free-spots-all-days").innerHTML.split(',');
    const newDayFree = dataFree.filter(dt => dt.startsWith(`${day}`));
    const dataBusy = document.getElementById("busy-spots-all-days").innerHTML.split(',');
    const newDayBusy = dataBusy.filter(dt => dt.startsWith(`${day}`));

    let freeSpots = [];
    newDayFree.forEach(function(item){
        freeSpots.push(parseInt(item.split(" ")[1].split(":")[0]));
    });
    let busySpots = [];
    newDayBusy.forEach(function(item){
        busySpots.push(parseInt(item.split(" ")[1].split(":")[0]));
    });
    let freeSpotsFinal = [];
    freeSpots.forEach(function(h){
        if (busySpots.includes(h) === false) {freeSpotsFinal.push(h)}
    });
    var dict = {
        free: freeSpots,
        busy: busySpots,
        freeFinal: freeSpotsFinal,
        dataFree: newDayFree,
        dataBusy: newDayBusy,
        boxesPositions: [0,1,2,3,4,5,6,7,8,9,10,11,12,13],
      };
    return dict
}

const newDaySpotUpdate = (dict) => {
    const spots = document.getElementsByClassName('spot')
    console.log(dict["busy"])
    dict["boxesPositions"].forEach(function(spot){
        spots[spot].innerText = "X"
        spots[spot].classList.remove("free")
        spots[spot].classList.remove("busy")
        spots[spot].classList.add("unscheduled")
      });

    dict["free"].forEach(function(p){
        spots[p-7].innerText = "V"
        spots[p-7].classList.remove("unscheduled")
        spots[p-7].classList.add("free")
    });
    
    dict["busy"].forEach(function(p){
        spots[p-7].innerText = "X"
        spots[p-7].classList.remove("unscheduled")
        spots[p-7].classList.add("busy")
    });
}


const schedulePackaging = (dictionary) => {
    let packaging = []
    let groupNumber = 0
    dictionary["free"].forEach(function(hour){
        if (dictionary["busy"].includes(hour) === false) {
            if (packaging.length === 0) {
                packaging.push([hour])
            } else {
                if (packaging[groupNumber][packaging[groupNumber].length - 1] === hour - 1) {
                    packaging[groupNumber].push(hour)
                } else {
                    packaging.push([hour])
                    groupNumber += 1
                }
            }
        }
      });
    return packaging
}

const comparePackage = (packaging, s1, s2 ) => {
    let slider1Pack = null
    let slider2Pack = null
    packaging.forEach(function(pack){
        if (pack.includes(s1) === true) {
            slider1Pack = packaging.indexOf(pack) 
        }
        if (pack.includes(s2 - 1) === true) { 
            slider2Pack = packaging.indexOf(pack)
        }
    });
    var dataCompare = {
        compare: slider1Pack === slider2Pack,
        s1: slider1Pack,
        s2: slider2Pack,
      };
    return dataCompare
}

const closestFreeSchedule = (position, schedule) => {
    let closest = null
    let i = 1
    while (closest === null) {
        if (schedule.includes(position - i)){
            closest = position - i
        } else if (schedule.includes(position + i)){
            closest = position + i
        } else {
            i += 1
        }
      }
    return closest
}

const hoursShownUpdate = (s1,s2) => {
    const hoursShown = document.getElementById("show-selected-hours");
    hoursShown.innerText = `- De ${s1.value} h à ${s2.value} h -`;
}

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
        option.disabled = true;
    } else {
        option.disabled = false;
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
    const oneDayFree = document.getElementById("remaining-free-spots-one-days");
    const oneDayBusy = document.getElementById("busy-spots-one-day");
    const newDayData = newDaySpotDictionary(day);
    newDaySpotUpdate(newDayData);
    oneDayFree.innerText = newDayData["dataFree"];
    oneDayBusy.innerText = newDayData["dataBusy"];
    verificationSlider(day,1);

    const startHour = document.getElementById("start_time");
    const endHour = document.getElementById("end_time");
    const block = document.getElementById("select_booking_hours");
    const notToday = document.getElementById("not_today");
    const today = date();
    let hourMin = startingHour();
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
            notToday.classList.remove('hidden')
            startHour.value = store_start;
            hourMin = store_start;
        };
    } else {
        notToday.classList.add('hidden');
        block.classList.remove('hidden');
    };

    for (let option of startHour.options) {
        if (day === today) {
            if (Number(option.value) < hourMin) {
                option.disabled = true;
            } else {
                option.disabled = false;
            };
        } else {
                option.disabled = false;
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

const duringMove1 = () => {
    const s1 = document.getElementById("slider1");
    const s2 = document.getElementById("slider2");
    const n1 = Number(s1.value)
    const n2 = Number(s2.value)
    if (n1 >= n2) {
        s2.value = n1 + 1
    } else {
    }
    hoursShownUpdate(s1,s2)
}

const duringMove2 = () => {
    const s1 = document.getElementById("slider1");
    const s2 = document.getElementById("slider2");
    const n1 = Number(s1.value)
    const n2 = Number(s2.value)
    if (n2 <= n1) {
        s1.value = n2 - 1
    } else {
    }
    hoursShownUpdate(s1,s2)
}

const verificationSlider = (day, priority) => {
    const s1 = document.getElementById("slider1");
    const s2 = document.getElementById("slider2");
    let n1 = Number(s1.value)
    let n2 = Number(s2.value)
    
    const dayData = newDaySpotDictionary(day)
    const packageFreeSpots = schedulePackaging(dayData)
    const positionPackage = comparePackage(packageFreeSpots, n1, n2)

    if (dayData["freeFinal"].includes(n1) === false & dayData["freeFinal"].includes(n2 - 1) === false) {
        const closest = closestFreeSchedule(n1, dayData["freeFinal"])
        s1.value = closest
        s2.value = closest + 1
    } else if (dayData["freeFinal"].includes(n1) === false) {
        s1.value = packageFreeSpots[positionPackage["s2"]][0]
    } else if (dayData["freeFinal"].includes(n2 - 1) === false) {
        const whichPack = packageFreeSpots[positionPackage["s1"]].length - 1
        s2.value = packageFreeSpots[positionPackage["s1"]][whichPack] + 1
    }

    n1 = Number(s1.value)
    n2 = Number(s2.value)
    const samePackage = comparePackage(packageFreeSpots, n1, n2)

    if (samePackage["compare"] === true) {
    } else {
        if (priority === 1) {
            const arrayPosition = packageFreeSpots[samePackage["s1"]].length - 1
            s2.value = packageFreeSpots[samePackage["s1"]][arrayPosition] + 1
        } else {
            s1.value = packageFreeSpots[samePackage["s2"]][0]
        }
    }

    if (s1.value === s1.max) {
        s1.value = 20;
        console.log(s1.value);
    } 
    if (s2.value === s2.min) {
        s2.value = 8;
        console.log(s1.value);
    }
    hoursShownUpdate(s1,s2)
}

const initBookingChoice = () => {
    const startSlider = document.getElementById("slider1");
    const endSlider = document.getElementById("slider2");
    const day = document.getElementById("example-date-input")

    startSlider.addEventListener("input", duringMove1);
    endSlider.addEventListener("input", duringMove2);

    startSlider.addEventListener("change", () => { verificationSlider(day.value, 1) });
    endSlider.addEventListener("change", () => { verificationSlider(day.value, 2) });

    day.addEventListener("change", () => { visible(day.value) });
}

/* const exinitbokk = () => {
    const start = document.getElementById("start_time");
    const end = document.getElementById("end_time");
    const day = document.getElementById("example-date-input")
    start.addEventListener("change", changeDuration);
    end.addEventListener("change", changeDuration);
    day.addEventListener("change", () => { visible(day.value) });
}
*/
export { initBookingChoice };
