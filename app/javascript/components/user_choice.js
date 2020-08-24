const displaySeniorOn = (type) => {
    const senior_form = document.getElementById("senior_register");
    const choice = document.getElementById("choice");
    choice.classList.add('hidden');
    senior_form.classList.remove('hidden');
}

const displayHelperOn = (type) => {
    const helper_form = document.getElementById("helper_register");
    const choice = document.getElementById("choice");
    choice.classList.add('hidden');
    helper_form.classList.remove('hidden');
}

const initUserChoice = () => {
    const senior = document.getElementById("ask_senior");
    const helper = document.getElementById("ask_helper");
    senior.addEventListener("click", displaySeniorOn);
    helper.addEventListener("click", displayHelperOn);
}

export { initUserChoice };