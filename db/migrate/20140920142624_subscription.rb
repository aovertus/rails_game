class Subscription < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :tournament
      t.timestamps
    end
  end
end
