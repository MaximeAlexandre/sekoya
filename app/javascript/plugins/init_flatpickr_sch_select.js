import flatpickr from "flatpickr";

const initFlatpickrSchSelect = () => {
  const myInput = document.querySelectorAll('.datepicker_input');
  flatpickr(myInput, {
    mode: "range",
    minDate: "today",  
    defaultDate: "today",
  });
}

export {initFlatpickrSchSelect}
