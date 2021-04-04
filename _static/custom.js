document.addEventListener("DOMContentLoaded", function(){
  var coll = document.getElementsByClassName("nbinput");
  for (var i = 0; i < coll.length; i++) {
    var highlight = coll[i].children[0].children[0];
    highlight.children[0].children[0].innerHTML = "🔍";
    let tooltip = document.createElement('span');
    tooltip.textContent = "Toggle source";
    tooltip.classList.toggle("tooltip-text");
    highlight.appendChild(tooltip);

    coll[i].children[1].style.display = "none";
    highlight.addEventListener("click", function() {
      this.classList.toggle("highlight-active");
      var input_area = this.parentElement.nextElementSibling;
      if (input_area.style.display === "block") {
        input_area.style.display = "none";
        this.children[0].children[0].innerHTML = "🔍";
      } else {
        input_area.style.display = "block";
        this.children[0].children[0].innerHTML = "🚩";
      }
    });
  }
});
