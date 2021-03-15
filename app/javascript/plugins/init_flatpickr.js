import flatpickr from "flatpickr";

const dateList = () => {
  const data = document.getElementById("selection-date").innerHTML.split(',');
  return data
}

const startDate = () => {
  const day = document.getElementById("first-date").innerHTML;
  return day
}

const initFlatpickr = () => {
  const flatInstances = document.querySelectorAll('.datepicker');
  const datelist = dateList();
  const firstday = startDate();
  flatpickr(flatInstances, {
    inline: true,
    minDate: firstday,
    enable: datelist,
    // exemple: enable: ["2025-03-30", "2025-05-21", "2025-06-08", new Date(2025, 8, 9) ]    
    defaultDate: firstday,
  });
}

export {initFlatpickr}

// flatpickr('.datepicker', {
//   inline: true
// });
