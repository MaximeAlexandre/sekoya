const arraySpots = (min, max) => {
    let spots = [];
    let hours = [];
    let s = 0;
    let h = min;
    while (h != max) {
        spots.push(s)
        hours.push(h)
        s++;
        h = h+0.5
    };
    var hoursSpots = {
        hours: hours,
        spots: spots,
      };
    return hoursSpots
}

const newDaySpotDictionary = (day) => {
    const dataBusy = document.getElementById("busy-spots-all-days").innerHTML.split(',');
    const newDayBusy = dataBusy.filter(dt => dt.startsWith(`${day}`));

    let busySpots = [];
    newDayBusy.forEach(function(item){
        if (parseInt(item.split(" ")[1].split(":")[1]) === 0) {
            busySpots.push(parseInt(item.split(" ")[1].split(":")[0]));
        } else {
            busySpots.push(parseInt(item.split(" ")[1].split(":")[0])+0.5);
        }
    });
    const hoursSpots = arraySpots(7,21)
    var dict = {
        busy: busySpots,
        dataBusy: newDayBusy,
        boxesPositions: hoursSpots["spots"],
        hoursList: hoursSpots["hours"],
      };
    return dict
}

const newDaySpotUpdate = (dict) => {
    const spots = document.getElementsByClassName('spot')
    dict["boxesPositions"].forEach(function(spot){
        spots[spot].classList.add("free")
        spots[spot].classList.remove("unscheduled")
      });

    dict["busy"].forEach(function(p){
        spots[(p-7)*2].classList.add("unscheduled")
        spots[(p-7)*2].classList.remove("free")
    });
}


const schedulePackaging = (dictionary) => {
    let packaging = []
    let groupNumber = 0
    dictionary["hoursList"].forEach(function(hour){
        if (dictionary["busy"].includes(hour) === false) {
            if (packaging.length === 0) {
                packaging.push([hour])
            } else {
                if (packaging[groupNumber][packaging[groupNumber].length - 1] === hour - 0.5) {
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
        if (pack.includes(s2-0.5) === true) { 
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

// n1, packageFreeSpots.reduce(reducer)
const closestFreeSchedule = (position, free) => {
    const min = 7
    const max = 20.5
    let closest = null
    let i = 0.5
    while (closest === null) {
        let conditionPlusI = free.includes(position + i-0.5) === true && free.includes(position + i) === true
        let conditionMoinsI = free.includes(position - i+0.5) === true && free.includes(position - i) === true
        if (conditionPlusI){
            closest = position + i - 0.5
        } else if (conditionMoinsI){
            closest = position - i
        } else {
            if(position + i-0.5 > 20.5 && position - i+0.5 < 7){
                closest = "none"
            } else {
               i += 0.5 
            }
        }
      }
    return closest
}

const hoursShownUpdate = (s1,s2) => {
    const hoursShown = document.getElementById("show-selected-hours");
    let h1 = 0
    let m1 = 0
    if ( s1.value.toString().endsWith(".5") ) {
        h1 = parseInt(s1.value)
        m1 = "30"
    } else {
        h1 = s1.value
        m1 = "00"
    }
    let h2 = 0
    let m2 = 0
    if ( s2.value.toString().endsWith(".5") ) {
        h2 = parseInt(s2.value)
        m2 = "30"
    } else {
        h2 = s2.value
        m2 = "00"
    }
    hoursShown.innerText = `- De ${h1}h${m1} à ${h2}h${m2} -`;
}

const pluriel = (duree) => {
    let hour = ""
        if ( duree === 1 ) {
            return hour = "heure"
        } else {
            return hour = "heures"
        }
}

const changePriceShown = (s1, s2) => {
    const duree = s2.value - s1.value;
    const hour = pluriel(duree)
    const total = document.getElementById("total");
    const price = Number(total.dataset.price);
    total.innerText = `${duree} ${hour} - Total : ${duree*price} €`;
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

/* To keep?----------------------- start */
const startingHour = () => {
    let hourMin = 0;
    if (new Date().getMinutes() != 0) {
        hourMin = new Date().getHours() + 2;
    } else {
        hourMin = new Date().getHours() + 1;
    }
    return hourMin
}

/* ------------------------- end */

const visible= (day) => {
    const oneDayBusy = document.getElementById("busy-spots-one-day");
    const newDayData = newDaySpotDictionary(day);
    newDaySpotUpdate(newDayData);
    oneDayBusy.innerText = newDayData["dataBusy"];
    verificationSlider(day,1);
    const inputBlock = document.getElementById("select_booking_hours");
    const notToday = document.getElementById("not_today");
    const today = date();
    let hourMin = startingHour();

    if (day === today) {
        if (hourMin > 20) {
            inputBlock.classList.add('hidden');
            notToday.classList.remove('hidden')
        };
    } else {
        notToday.classList.add('hidden');
        inputBlock.classList.remove('hidden');
    };
}

const duringMove1 = () => {
    const s1 = document.getElementById("slider1");
    const s2 = document.getElementById("slider2");
    const n1 = Number(s1.value)
    const n2 = Number(s2.value)
    if (n1 >= n2-0.5) {
        s2.value = n1 + 1
    } else {
    }
    hoursShownUpdate(s1,s2)
    changePriceShown(s1,s2)
}

const duringMove2 = () => {
    const s1 = document.getElementById("slider1");
    const s2 = document.getElementById("slider2");
    const n1 = Number(s1.value)
    const n2 = Number(s2.value)
    if (n2 <= n1+0.5) {
        s1.value = n2 - 1
    } else {
    }
    hoursShownUpdate(s1,s2)
    changePriceShown(s1,s2)
}

const verificationSlider = (day, priority) => {
    const s1 = document.getElementById("slider1");
    const s2 = document.getElementById("slider2");
    let n1 = Number(s1.value)
    let n2 = Number(s2.value)
    const dayData = newDaySpotDictionary(day)
    const packageFreeSpots = schedulePackaging(dayData)

    const reducer = (accumulator, currentValue) => accumulator.concat(currentValue);
    const positionPackage = comparePackage(packageFreeSpots, n1, n2)

    if (n2 === 7) {
        s1.value = packageFreeSpots[0][0]
        s2.value = (parseFloat(s1.value)+1).toString()
    } else if (n1 === 21) {
        const whichPackLast = packageFreeSpots.length - 1
        const whichHourLast = packageFreeSpots[whichPackLast].length - 1
        s2.value = packageFreeSpots[whichPackLast][whichHourLast] + 0.5
        s1.value = (parseFloat(s2.value)-1).toString()
    } else if (dayData["busy"].includes(n1) && dayData["busy"].includes(n2 - 0.5)) {
        const closest = closestFreeSchedule(n1, packageFreeSpots.reduce(reducer), dayData["hoursList"])
        s1.value = closest
        s2.value = closest + 1
    } else if (dayData["busy"].includes(n1) === true) {
        s1.value = packageFreeSpots[positionPackage["s2"]][0]
        if (parseFloat(s2.value) === (parseFloat(s1.value) + 0.5)) s2.value = (parseFloat(s2.value) + 0.5).toString();
    } else if (dayData["busy"].includes(n2 - 0.5) === true) {
        const whichPack = packageFreeSpots[positionPackage["s1"]].length - 1
        s2.value = packageFreeSpots[positionPackage["s1"]][whichPack] + 0.5
        if (parseFloat(s2.value) - 0.5 === parseFloat(s1.value)) s1.value = (parseFloat(s1.value) - 0.5).toString();
    }

    n1 = Number(s1.value)
    n2 = Number(s2.value)
    const samePackage = comparePackage(packageFreeSpots, n1, n2)
    if (samePackage["compare"] === true) {
    } else {
        if (priority === 1) {
            const arrayPosition = packageFreeSpots[samePackage["s1"]].length - 1
            s2.value = packageFreeSpots[samePackage["s1"]][arrayPosition] + 0.5
            if (parseFloat(s2.value) - 0.5 === parseFloat(s1.value)) {
                s1.value = (parseFloat(s1.value) - 0.5).toString();
            }
        } else {
            s1.value = packageFreeSpots[samePackage["s2"]][0]
            if (parseFloat(s2.value) === (parseFloat(s1.value) + 0.5)) {
                s2.value = (parseFloat(s2.value) + 0.5).toString()
            }
        }
    }
    if (s1.value === s1.max || parseFloat(s1.value) === parseFloat(s1.max) - 0.5) {
        s1.value = 20;
    } 
    if (s2.value === s2.min || parseFloat(s2.value) === parseFloat(s2.min) + 0.5) {
        s2.value = 8;
    }
    hoursShownUpdate(s1,s2)
    changePriceShown(s1,s2)
}

const initBookingChoice = () => {
    const startSlider = document.getElementById("slider1");
    const endSlider = document.getElementById("slider2");
    const day = document.getElementById("example-date-input")

    startSlider.addEventListener("input", duringMove1);
    endSlider.addEventListener("input", duringMove2);
    /* add comportement when using <- et -> touches du clavier */

    startSlider.addEventListener("change", () => { verificationSlider(day.value, 1) });
    endSlider.addEventListener("change", () => { verificationSlider(day.value, 2) });

    day.addEventListener("change", () => { visible(day.value) });
}

export { initBookingChoice };
