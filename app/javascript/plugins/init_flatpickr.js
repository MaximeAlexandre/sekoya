import flatpickr from "flatpickr";

const initFlatpickr = () => {
  const flatInstances = document.querySelectorAll('.datepicker');
  flatpickr(flatInstances, {
    inline: true
  });
}

export {initFlatpickr}

// flatpickr('.datepicker', {
//   inline: true
// });
