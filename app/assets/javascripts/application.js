// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require backbone
//= require_tree ./libs
//= require family_budget
//= require user_auth
//= require_tree ../templates
//= require_tree ./models
//= require_tree ./collections

//= require ./views/forms/form_base.js.coffee
//= require ./views/forms/form_add.js.coffee
//= require ./views/forms/form_edit.js.coffee

//= require_tree ./views

//= require_tree ./routers
//= require_tree ./utilities
//= require_tree ./user_auth
//= require_tree .