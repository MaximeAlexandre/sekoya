const displaySeniorAccount = (type) => {
    const new_senior = document.getElementById("new_senior");
    const choice_account = document.getElementById("choice_account");
    choice_account.classList.add('hidden');
    new_senior.classList.remove('hidden');
}

const displayFamilyAccount = (type) => {
    const new_family = document.getElementById("new_family");
    const choice_account = document.getElementById("choice_account");
    choice_account.classList.add('hidden');
    new_family.classList.remove('hidden');
}

const initAccountChoice = () => {
    const new_senior = document.getElementById("senior_account");
    const family = document.getElementById("family_account");
    new_senior.addEventListener("click", displaySeniorAccount);
    family.addEventListener("click", displayFamilyAccount);
}

export { initAccountChoice };
