/* app/assets/javascripts/application.js */
//= require_self

//= require jquery3
//= require popper
//= require bootstrap
//= require jquery_ujs
//= require_tree .

window.addEventListener('load', () => {
    $('.image_diag').css({"display": "none"});
    $('.img-left-side').css({"display": "none"});
    $('.img-right-side').css({"display": "none"});
})