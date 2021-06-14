// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
// import '../plugins/flatpickr';
import { initFlatpickr } from '../plugins/init_flatpickr';
import { initFlatpickrSchSelect } from '../plugins/init_flatpickr_sch_select';
import { initControls } from '../components/calendar_controls';
//import { initFlatpickrSchDateChange } from '../plugins/init_flatpickr_sch_date_change';
import { initUpdateNavbarOnScroll } from '../components/navbar.js';
import { initStarRating } from '../plugins/init_star_rating';
import { initBookingChoice } from '../components/booking_choice';
import { initCheckBoxes } from '../components/check_task';
import { initUserChoice } from '../components/user_choice';
import { initMapbox } from '../plugins/init_mapbox';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initAccountChoice } from '../components/account_choice';
import { initOtherInput } from '../components/other_input';
import { initClickHelperButton } from '../components/click_helper_button';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  if (document.querySelector('#map')) {
    initMapbox();
  }

  if (document.querySelector('#example-date-input')) {
    initFlatpickr();
  };
  if (document.querySelector('#dates_select')) {
    initFlatpickrSchSelect();
    //initFlatpickrSchDateChange()
  };
  if (document.querySelector('#calendar-all')) {
    initControls();
  };

  initUpdateNavbarOnScroll();
  initStarRating();
  initCheckBoxes();
  initClickHelperButton();


  if (document.querySelector('#senior_address')) {
    initAutocomplete('senior_address');
  };

  if (document.querySelector('#family_address')) {
    initAutocomplete('family_address');
  };

  if (document.querySelector('#helper_address')) {
    initAutocomplete('helper_address');
  };

  if (document.querySelector('#search_address')) {
    initAutocomplete('search_address');
  };

  if (document.querySelector('#filter_address')) {
    initAutocomplete('filter_address');
  };

  if (document.querySelector('#ask_senior') || document.querySelector('#ask_helper')) {
    initUserChoice();
  }

  if (document.querySelector('#select-booking-day-hours')) {
    initBookingChoice();
  }

  if (document.querySelector('#senior_account') || document.querySelector('#family_account')) {
    initAccountChoice();
  }

  if (document.querySelector('#other_pathology')) {
    initOtherInput();
  }

  if (document.querySelector('#family_other_pathology')) {
    initOtherInput();
  }

});
