const changeDuration = () => {
    const startHour = Number(document.getElementById("start_time").value);
    const endHour = document.getElementById("end_time");
    let endHourUse = Number(endHour.value);
    if (endHourUse <= startHour) {
        endHourUse = startHour + 1
        endHour.value = String(endHourUse);
    }
    for (let option of endHour.options) {
        if (option.value <= startHour) {
            option.classList.add('hidden');
        } else {
            option.classList.remove('hidden');
        }
    }
    const duree = endHourUse - startHour;
    let hour = ""
    if ( duree === 1 ) {
        hour = "heure"
    } else {
        hour = "heures"
    }
    const total = document.getElementById("total");
    const price = Number(total.dataset.price);
    total.innerText = `${duree} ${hour} - Total : ${duree*price} €`;
}

const initBookingChoice = () => {
    const start = document.getElementById("start_time");
    const end = document.getElementById("end_time");
    start.addEventListener("change", changeDuration);
    end.addEventListener("change", changeDuration);
}
export { initBookingChoice };
