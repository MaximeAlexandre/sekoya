import flatpickr from "flatpickr";


flatpickr('.datepicker', {
  inline: true,
  enableTime: true,
  minuteIncrement: 30,
  time_24hr: true,
  defaultDate: "7:00",
  minTime: "7:00",
  maxTime: "21:00"
});
