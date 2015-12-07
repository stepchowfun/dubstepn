class CreateEverything < ActiveRecord::Migration
  def change
    create_table 'posts' do |t|
      t.text     'title',        null: false
      t.text     'content',      null: false
      t.boolean  'is_public',    null: false
      t.datetime 'created_at',   null: false
      t.datetime 'updated_at',   null: false
      t.text     'content_html', null: false
      t.integer  'sort_id',      null: false
      t.text     'javascript',   null: false
      t.text     'css',          null: false
      t.text     'title_html',   null: false
    end

    add_index 'posts', ['is_public', 'sort_id'], name: 'index_posts_on_is_public_and_sort_id'
    add_index 'posts', ['is_public'], name: 'index_posts_on_is_public'
    add_index 'posts', ['sort_id'], name: 'index_posts_on_sort_id'

    create_table 'posts_tags', id: false do |t|
      t.integer 'post_id', null: false
      t.integer 'tag_id',  null: false
    end

    add_index 'posts_tags', ['post_id'], name: 'index_posts_tags_on_post_id'
    add_index 'posts_tags', ['tag_id'], name: 'index_posts_tags_on_tag_id'

    create_table 'redirects' do |t|
      t.text     'from',       null: false
      t.text     'to',         null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    create_table 'tags' do |t|
      t.string   'name',       limit: 255, null: false
      t.datetime 'created_at',             null: false
      t.datetime 'updated_at',             null: false
    end

    add_index 'tags', ['name'], name: 'index_tags_on_name'
  end
end
