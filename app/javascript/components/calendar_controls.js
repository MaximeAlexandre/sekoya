const isOld =  (dataForm, formWeek) => {
    const todayTime = new Date()
    todayTime.setHours(todayTime.getHours()+(-1*todayTime.getTimezoneOffset()/60));
    const todayDate = todayTime.toISOString().slice(0,10)
    const docBegin = dataForm.value.split(":")[0]
    const submit = formWeek.getElementsByClassName("submit-week")[0]

    const condition = Date.parse(docBegin) < Date.parse(todayDate)
    if (condition) {
        submit.setAttribute("disabled", "disabled");
    } else {
        submit.removeAttribute('disabled');
    }
}

const updateFormWeek =  (docElement) => {
    const copyYearCweek = docElement.getElementsByClassName("copy-to-form")[0];
    const copyDataForm = docElement.getElementsByClassName("copy-data")[0];
    const copyDay1 = docElement.getElementsByClassName("copy-day-1");
    const copyDay2 = docElement.getElementsByClassName("copy-day-2");

    const formWeek = document.getElementById("form-week");
    const pasteYearCweek = formWeek.getElementsByClassName("write-year-cweek")[0];
    const pasteDataForm = formWeek.getElementsByClassName("dates_select_week")[0];
    const pasteDay1 = formWeek.getElementsByClassName("print-1");
    const pasteDay2 = formWeek.getElementsByClassName("print-2");

    pasteYearCweek.innerText = copyYearCweek.innerText
    pasteDataForm.value = copyDataForm.innerText
    const list = elementsList(7)
    list.forEach(function(i){
        pasteDay1[i].innerText = copyDay1[i].innerText
        pasteDay2[i].innerText = copyDay2[i].innerText
    });
    isOld(pasteDataForm, formWeek)
}

const whichWeek = (docElements) => {
    const list = elementsList(docElements.length)
    let current = null
    list.forEach(function(e){
        if (docElements[e].hidden === false) {current = e} ;
    });
    var data = {
        current: current,
        max: list.length - 1
      };
    return data
}

const leftRight = (direction) => {
    const weeks = document.querySelectorAll('.cweek');
    const data = whichWeek(weeks)
    const conditionL = data["current"] === 0 && direction === "left"
    const conditionR = data["current"] === data["max"] && direction === "right"
    if (conditionL || conditionR) {
    } else {
        if (direction === "left") {
            if (data["current"] - 1 === 0){
                weeks[data["current"]].hidden = true;
                weeks[data["current"]-1].hidden = false;
                document.getElementById("left-arrow").classList.add("disabled-arrow");
                const right = document.getElementById("right-arrow")
                if (right.className.split(' ').includes(`disabled-arrow`)) {
                    right.classList.remove("disabled-arrow");
                }
                updateFormWeek(weeks[data["current"]-1])
            } else {
                weeks[data["current"]].hidden = true;
                weeks[data["current"]-1].hidden = false;
                const right = document.getElementById("right-arrow")
                if (right.className.split(' ').includes(`disabled-arrow`)) {
                    right.classList.remove("disabled-arrow");
                }
                updateFormWeek(weeks[data["current"]-1])
            };
        } else {
            if (data["current"] + 1 === data["max"]){
                weeks[data["current"]].hidden = true;
                weeks[data["current"]+1].hidden = false;
                document.getElementById("right-arrow").classList.add("disabled-arrow");
                const left = document.getElementById("left-arrow")
                if (left.className.split(' ').includes(`disabled-arrow`)) {
                    left.classList.remove("disabled-arrow");
                }
                updateFormWeek(weeks[data["current"]+1])
            } else {
                weeks[data["current"]].hidden = true;
                weeks[data["current"]+1].hidden = false;
                const left = document.getElementById("left-arrow")
                if (left.className.split(' ').includes(`disabled-arrow`)) {
                    left.classList.remove("disabled-arrow");
                }
                updateFormWeek(weeks[data["current"]+1])
            };
        }
    }
}

const easyFormSwitch = (whichButton) => {
    if (whichButton === "week") {
        document.getElementById("form-week").hidden = true;
        document.getElementById("calendrier").hidden = false;
    } else if (whichButton === "choice"){
        document.getElementById("form-sp").hidden = true;
        document.getElementById("calendrier").hidden = false;
        document.getElementById("calendar-bar").hidden = false;
        document.getElementById("calendar-bar-2").hidden = true;
    } else if (whichButton === "to-week") {
        document.getElementById("calendrier").hidden = true;
        document.getElementById("form-week").hidden = false;
    } else {
        document.getElementById("calendrier").hidden = true;
        document.getElementById("form-sp").hidden = false;
        document.getElementById("calendar-bar").hidden = true;
        document.getElementById("calendar-bar-2").hidden = false;
    }
}

const elementsList = (max) => {
    let elements = [];
    let e = 0;
    while (e < max) {
        elements.push(e)
        e += 1
    };
    return elements
}

const classEventListener = (docElements, parameter) => {
    const list = elementsList(docElements.length)
    list.forEach(function(e){
        docElements[e].addEventListener("click", () => { easyFormSwitch(parameter) });
    });
}

const initControls = () => {
    const btnLeft = document.getElementById("left-arrow");
    const btnRight = document.getElementById("right-arrow");
    const btnReturnWeek = document.getElementById("button-return-week");
    const btnReturnChoice = document.getElementById("button-return-choice");
    const btnToChoice = document.getElementsByClassName("button-choice");
    const btnToWeek = document.getElementsByClassName("button-week");

    btnLeft.addEventListener("click", () => { leftRight("left") });
    btnRight.addEventListener("click", () => { leftRight("right") });
    btnReturnWeek.addEventListener("click", () => { easyFormSwitch("week") });
    btnReturnChoice.addEventListener("click", () => { easyFormSwitch("choice") });
    classEventListener(btnToChoice, "to-choice")
    classEventListener(btnToWeek, "to-week")
  }
  
export {initControls}