const changeDuration = () => {
    const startHour = Number(document.getElementsByName("start_time")[0].value)
    const endHour = Number(document.getElementsByName("end_time")[0].value)
    const duree = endHour - startHour

    const totalDuration = document.getElementById("total-duration")
    const price = Number(totalDuration.dataset.price)
    totalDuration.innerText = ` ${price} € x ${duree} heures `

    const totalPrice = document.getElementById("total-price")
    totalPrice.innerText =`Total : ${duree*price}* €`
}

const initDuration = () => {
    const start = document.getElementsByName("start_time")[0]
    const end = document.getElementsByName("end_time")[0]
    start.addEventListener("change", changeDuration);
    end.addEventListener("change", changeDuration);
}
export { initDuration };