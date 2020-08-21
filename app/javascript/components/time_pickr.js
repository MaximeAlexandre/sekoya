const changeDuration = () => {
    const startHour = Number(document.getElementsByName("start_time")[0].value);
    const endHour = document.getElementsByName("end_time")[0];
    let endHourUse = Number(endHour.value);
    if (endHourUse <= startHour) {
        endHourUse = startHour + 1
        endHour.value = String(endHourUse);
    }
    const duree = endHourUse - startHour;
    const total = document.getElementById("total");
    const price = Number(total.dataset.price);
    total.innerText = `${duree} heure - Total : ${duree*price} €`;
}

const initDuration = () => {
    const start = document.getElementsByName("start_time")[0];
    const end = document.getElementsByName("end_time")[0];
    start.addEventListener("change", changeDuration);
    end.addEventListener("change", changeDuration);
}
export { initDuration };
