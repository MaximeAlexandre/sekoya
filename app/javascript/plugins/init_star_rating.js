import "jquery-bar-rating";

import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  $('#review_note').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
