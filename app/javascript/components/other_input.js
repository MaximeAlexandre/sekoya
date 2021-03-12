 const initOtherInput = () => {
  const pathology = document.querySelector('#user_pathology');
  const other_field = document.getElementById('other_pathology');
  const family_pathology = document.querySelector('#family_user_pathology');
  const other_family_field = document.getElementById('family_other_pathology');
  other_field.style.display = "none";
  other_family_field.style.display = "none";

   $(pathology).change(function() {
    if ((this).value == "other") {
    other_field.style.display = "block";
   } else {
    other_field.style.display = "none";
   }
  });

   $(family_pathology).change(function() {
    if ((this).value == "other") {
      other_family_field.style.display = "block";
    } else {
      other_family_field.style.display = "none";
    }
   });
}

export { initOtherInput };
