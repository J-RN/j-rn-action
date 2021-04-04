document.addEventListener("DOMContentLoaded", function(){
  var coll = document.getElementsByClassName("nbinput");
  for (var i = 0; i < coll.length; i++) {
    var prompt = coll[i].children[0].children[0].children[0];
    coll[i].children[1].style.display = "none";
    prompt.addEventListener("click", function() {
      this.parentElement.classList.toggle("highlight-active");
      var input_area = this.parentElement.parentElement.nextElementSibling;
      if (input_area.style.display === "block") {
        input_area.style.display = "none";
      } else {
        input_area.style.display = "block";
      }
    });
  }
});
