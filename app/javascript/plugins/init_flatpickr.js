import flatpickr from "flatpickr";

const initFlatpickr = () => {
  const flatInstances = document.querySelectorAll('.datepicker');
  flatpickr(flatInstances, {
    inline: true,
    minDate: "today"
  });
}

export {initFlatpickr}

// flatpickr('.datepicker', {
//   inline: true
// });
