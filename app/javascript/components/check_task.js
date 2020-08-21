const initCheckBoxes = () => {
  const tasks = document.querySelectorAll(".category-choice")
  if (tasks.length >= 1) {
    Array.from(tasks).forEach((task) => {
      task.addEventListener("click", (event) => {
        event.currentTarget.classList.toggle("active")
        if (event.currentTarget.querySelector("input").checked) {
          event.currentTarget.querySelector("input").checked = false
        } else {
          event.currentTarget.querySelector("input").checked = true
        }
      })
    })
  }
}

export {initCheckBoxes};



// $(document).ready(function(){
//   $(".category-choice").click(function(){
//     $(this).toggleClass("active");
//   });
// });
