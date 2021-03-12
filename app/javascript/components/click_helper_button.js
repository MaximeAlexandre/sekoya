const initClickHelperButton = () => {
  const helper = $('button#ask_helper');

    $(document).ready(function() {
      setTimeout(function() {
       if (location.hash != '')
        helper.click();
      }, 10);
    });

}

export { initClickHelperButton }
