// img.lazy data-src => src
document.addEventListener("DOMContentLoaded", function(){
  var lazyloadImages = document.querySelectorAll("img.lazy");
  var lazyloadThrottleTimeout;
  function lazyload(){
    if(lazyloadThrottleTimeout){
      clearTimeout(lazyloadThrottleTimeout);
    }
    lazyloadThrottleTimeout = setTimeout(function(){
      var scrollTop = window.pageYOffset;
      lazyloadImages.forEach(function(img){
        if(img.offsetTop < (window.innerHeight + scrollTop)){
          img.src = img.dataset.src;
          img.classList.remove('lazy');
        }
      });
      if(lazyloadImages.length == 0){
        document.removeEventListener("scroll", lazyload);
        window.removeEventListener("resize", lazyload);
        window.removeEventListener("orientationChange", lazyload);
      }
    }, 20);
  }
  document.addEventListener("scroll", lazyload);
  window.addEventListener("resize", lazyload);
  window.addEventListener("orientationChange", lazyload);
});

// nbinput: collapse & toggle tooltip
document.addEventListener("DOMContentLoaded", function(){
  var input_cells = document.getElementsByClassName("nbinput");
  for (var i = 0; i < input_cells.length; i++){
    var highlight = input_cells[i].children[0].children[0];
    highlight.children[0].children[0].innerHTML = "🔍";
    let tooltip = document.createElement('span');
    tooltip.textContent = "Toggle source";
    tooltip.classList.toggle("tooltip-text");
    highlight.appendChild(tooltip);

    input_cells[i].children[1].style.display = "none";
    highlight.addEventListener("click", function(){
      this.classList.toggle("highlight-active");
      var input_area = this.parentElement.nextElementSibling;
      if (input_area.style.display === "block"){
        input_area.style.display = "none";
        this.children[0].children[0].innerHTML = "🔍";
      } else {
        input_area.style.display = "block";
        this.children[0].children[0].innerHTML = "🚩";
      }
    });
  }
});
