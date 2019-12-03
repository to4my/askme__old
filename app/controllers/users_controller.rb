class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Mikhail',
        username: 'to4my',
        avatar_url: 'https://lh3.googleusercontent.com/-y12HGFkzEgc/AAAAAAAAAAI/AAAAAAAAAAA/' \
        'ACHi3rd1dpiwuhmobBbYy8kvzKdPNVTQ4g.CMID/s83-c/photo.jpg',
        email: 'to4my@ya.ru',
        password: '12345'

      ),
      User.new(
        id: 2,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100',
        email: 'installero@ya.ru',
        password: '12345'
      ),
      User.new(id: 3,
               name: 'Misha',
               username: 'aristofun',
               email: 'aristofun@ya.ru',
               password: '12345')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Mikhail',
      username: 'to4my',
      avatar_url: 'https://lh3.googleusercontent.com/-y12HGFkzEgc/AAAAAAAAAAI/AAAAAAAAAAA/' \
        'ACHi3rd1dpiwuhmobBbYy8kvzKdPNVTQ4g.CMID/s83-c/photo.jpg',
      email: 'to4my@ya.ru',
      password: '12345'

    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('02.12.2019')),
      Question.new(text: 'How much is the fish?', created_at: Date.parse('01.12.2019'))
    ]

    @new_question = Question.new
  end
end
