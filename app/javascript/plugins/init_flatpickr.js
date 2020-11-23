import flatpickr from "flatpickr";

const initFlatpickr = () => {
  const flatInstances = document.querySelectorAll('.datepicker');
  flatpickr(flatInstances, {
    inline: true,
    minDate: "today"
    // enable: ["2025-03-30", "2025-05-21", "2025-06-08", new Date(2025, 8, 9) ]
  });
}

export {initFlatpickr}

// flatpickr('.datepicker', {
//   inline: true
// });
