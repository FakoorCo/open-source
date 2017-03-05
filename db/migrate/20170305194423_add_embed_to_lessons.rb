class AddEmbedToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :embed, :string
  end
end
