UserAuth.Views.RegisterForm = Marionette.View.extend

  tagName: 'form'
  
  className: 'form-wrapper'

  template: JST['user_auth/register_form']

  ui:
    'name': 'input[name="name"]'
    'email': 'input[name="email"]'
    'password': 'input[name="password"]'
    'passwordConfirm': 'input[name="password_confirm"]'

  events:
    'submit': 'submit'


  submit: (e) ->
    e.preventDefault()
    @createUser()
    @saveUser()
    # if @user.isValid() then @saveUser() else @renderError()
    
  renderError: ->
    console.log 'Error'

  createUser: ->
    @user = new UserAuth.Models.User
      name: @ui.name.val()
      email: @ui.email.val()
      password: @ui.password.val()
      password_confirmation: @ui.passwordConfirm.val()

  saveUser: ->
    console.log @user.toJSON()
    @user.save()