import flatpickr from "flatpickr";

const initFlatpickrSchSelect = () => {
  const myInput = document.querySelectorAll('.datepicker_input');
  flatpickr(myInput, {
    inline: true,
    minDate: "today",  
    defaultDate: "today",
  });
}

export {initFlatpickrSchSelect}
