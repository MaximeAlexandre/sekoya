import places from 'places.js';
const initAutocomplete = (input_id) => {
  const addressInput = document.getElementById(input_id);
  if (addressInput) {
    places({ container: addressInput });
  }
};
export { initAutocomplete };
