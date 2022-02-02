class CreateKeywordTables < ActiveRecord::Migration[6.0]
  def change
    create_table :keyword_tables do |t|
      t.string :keyword
      t.string :keywordReply

      t.timestamps
    end
  end
end
