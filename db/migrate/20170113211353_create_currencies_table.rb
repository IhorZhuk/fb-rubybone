class CreateCurrenciesTable < ActiveRecord::Migration[5.0]
  def change
    User.all.each do | user |
      Currency.create(
        user: user,
        title: 'EUR'
      )
    end

  end
end
