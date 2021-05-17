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
  const firstDay = startDate();
  flatpickr(flatInstances, {
    inline: true,
    minDate: firstDay,
    disable: [
      function(date) {
        return (date.getDay() === 6 || date.getDay() === 0);
      },
      function(date) {
        let date2 = new Date(date.getTime());
        date2.setHours(date2.getHours()+(-1*date.getTimezoneOffset()/60));
        return (datelist.includes(date2.toISOString().slice(0,10)));
      }
    ],
    // exemple: enable: ["2025-03-30", "2025-05-21", "2025-06-08", new Date(2025, 8, 9) ]    
    defaultDate: firstDay,
  });
}

export {initFlatpickr}

// flatpickr('.datepicker', {
//   inline: true
// });
