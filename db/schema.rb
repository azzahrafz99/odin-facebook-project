# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database,
# and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and
# unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file
# into your version control system.

ActiveRecord::Schema.define(version: 201_707_110_736_22) do
  create_table 'comments', force: :cascade do |t|
    t.text     'body'
    t.integer  'commentable_id'
    t.string   'commentable_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'notifications', force: :cascade do |t|
    t.integer  'user_id', null: false
    t.integer  'actor_id'
    t.string   'notify_type', null: false
    t.string   'target_type'
    t.integer  'target_id'
    t.string   'second_target_type'
    t.integer  'second_target_id'
    t.string   'third_target_type'
    t.integer  'third_target_id'
    t.datetime 'read_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id', 'notify_type'], name:
    'index_notifications_on_user_id_and_notify_type'
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string   'title'
    t.string   'content'
    t.integer  'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'relationships', force: :cascade do |t|
    t.integer  'follower_id'
    t.integer  'followed_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['followed_id'], name: 'index_relationships_on_followed_id'
    t.index ['follower_id', 'followed_id'], name:
    'index_relationships_on_follower_id_and_followed_id', unique: true
    t.index ['follower_id'], name: 'index_relationships_on_follower_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string   'username'
    t.string   'email'
    t.string   'password'
    t.string   'password_confirmation'
    t.string   'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string   'remember_token'
    t.string   'remember_digest'
    t.string   'provider'
    t.string   'uid'
    t.string   'name'
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.index ['remember_token'], name: 'index_users_on_remember_token'
  end

  create_table 'votes', force: :cascade do |t|
    t.string   'votable_type'
    t.integer  'votable_id'
    t.string   'voter_type'
    t.integer  'voter_id'
    t.boolean  'vote_flag'
    t.string   'vote_scope'
    t.integer  'vote_weight'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['votable_id', 'votable_type', 'vote_scope'], name:
    'index_votes_on_votable_id_and_votable_type_and_vote_scope'
    t.index ['voter_id', 'voter_type', 'vote_scope'], name:
    'index_votes_on_voter_id_and_voter_type_and_vote_scope'
  end
end
