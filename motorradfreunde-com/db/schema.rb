# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170425210158) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude",       limit: 24
    t.float    "longitude",      limit: 24
    t.boolean  "notification",                 default: false
  end

  add_index "activities", ["latitude"], name: "index_activities_on_latitude", using: :btree
  add_index "activities", ["longitude"], name: "index_activities_on_longitude", using: :btree
  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "ads", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "target",            limit: 255
    t.text     "html",              limit: 65535
    t.text     "javascript",        limit: 65535
    t.string   "url",               limit: 255
    t.text     "description",       limit: 65535
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "active",                          default: true
    t.integer  "customer_id",       limit: 4
    t.string   "subtitle",          limit: 255
    t.boolean  "html_only",                       default: false
    t.string   "displayed_url",     limit: 255
    t.integer  "position",          limit: 4,     default: 0
    t.integer  "impressions_count", limit: 4,     default: 0
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.text     "body",        limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "body_html",   limit: 65535
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.text     "body",              limit: 65535
    t.string   "http",              limit: 255
    t.boolean  "active",                          default: false
    t.integer  "user_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "news",                            default: false
    t.integer  "group_id",          limit: 4
    t.string   "source",            limit: 255
    t.datetime "photo_uploaded_at"
    t.text     "body_html",         limit: 65535
    t.integer  "photos_count",      limit: 4,     default: 0
    t.integer  "impressions_count", limit: 4
  end

  create_table "bikes", force: :cascade do |t|
    t.string   "vendor_name",         limit: 255
    t.integer  "user_id",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views_count",         limit: 4,     default: 0
    t.string   "model",               limit: 255
    t.integer  "ccm",                 limit: 4
    t.integer  "hp",                  limit: 4
    t.datetime "year_of_manufacture"
    t.string   "color",               limit: 255
    t.text     "description",         limit: 65535
    t.string   "category",            limit: 255
    t.string   "property",            limit: 255
    t.integer  "comments_count",      limit: 4,     default: 0
    t.integer  "votes_count",         limit: 4,     default: 0
    t.string   "permalink",           limit: 255
    t.datetime "photo_uploaded_at"
    t.integer  "photos_count",        limit: 4,     default: 0
    t.integer  "poi_id",              limit: 4
    t.integer  "vendor_id",           limit: 4
    t.integer  "impressions_count",   limit: 4
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4
    t.text     "body",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_html",        limit: 65535
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "commercials", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.decimal  "lat",                      precision: 15, scale: 10
    t.decimal  "lng",                      precision: 15, scale: 10
    t.string   "street",       limit: 255
    t.string   "zip",          limit: 255
    t.string   "city",         limit: 255
    t.string   "country",      limit: 255
    t.string   "phone",        limit: 255
    t.string   "fax",          limit: 255
    t.string   "email",        limit: 255
    t.string   "http",         limit: 255
    t.string   "type",         limit: 255
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.boolean  "active",                                             default: true
    t.integer  "photos_count", limit: 4,                             default: 0
  end

  create_table "customer_notices", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.text     "body",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "token",                  limit: 255
    t.string   "name",                   limit: 255
    t.string   "contact",                limit: 255
    t.string   "street",                 limit: 255
    t.string   "zip",                    limit: 255
    t.string   "city",                   limit: 255
    t.string   "country",                limit: 255
    t.string   "phone",                  limit: 255
    t.string   "fax",                    limit: 255
    t.string   "email",                  limit: 255
    t.text     "description",            limit: 65535
    t.text     "log",                    limit: 65535
    t.datetime "advertised_by_email_at"
    t.datetime "advertised_by_fax_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "url",                    limit: 255
    t.integer  "ads_count",              limit: 4
    t.integer  "pois_count",             limit: 4
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0
    t.integer  "attempts",   limit: 4,     default: 0
    t.text     "handler",    limit: 65535
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue",      limit: 255
  end

  add_index "delayed_jobs", ["locked_by"], name: "delayed_jobs_locked_by", using: :btree
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",                limit: 4
    t.string   "title",                  limit: 255
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "legacy_meeting_point",   limit: 255
    t.text     "description",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "accepted_ids",           limit: 65535
    t.text     "declined_ids",           limit: 65535
    t.string   "url",                    limit: 255
    t.datetime "generate_activities_at"
    t.boolean  "hide_time",                            default: false
    t.string   "import_url",             limit: 255
    t.float    "latitude",               limit: 24
    t.float    "longitude",              limit: 24
    t.string   "legacy_route",           limit: 255
    t.string   "legacy_street_number",   limit: 255
    t.string   "legacy_city",            limit: 255
    t.string   "legacy_state",           limit: 255
    t.string   "legacy_state_code",      limit: 255
    t.string   "legacy_postal_code",     limit: 255
    t.string   "legacy_country",         limit: 255
    t.string   "legacy_country_code",    limit: 255
    t.integer  "impressions_count",      limit: 4
    t.text     "address",                limit: 65535
  end

  add_index "events", ["latitude", "longitude"], name: "index_events_on_latitude_and_longitude", using: :btree

  create_table "feed_items", force: :cascade do |t|
    t.integer  "feed_id",      limit: 4
    t.string   "guid",         limit: 255
    t.string   "title",        limit: 255
    t.string   "url",          limit: 255
    t.string   "image_url",    limit: 255
    t.string   "author",       limit: 255
    t.text     "content",      limit: 65535
    t.text     "description",  limit: 65535
    t.datetime "published_at"
    t.text     "categories",   limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "feed_url",     limit: 255
    t.string   "url",          limit: 255
    t.string   "language",     limit: 255
    t.string   "image_url",    limit: 255
    t.string   "image_link",   limit: 255
    t.string   "image_title",  limit: 255
    t.text     "description",  limit: 65535
    t.string   "copyright",    limit: 255
    t.datetime "published_at"
    t.datetime "build_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "followships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",        limit: 255
    t.string   "email",       limit: 255
  end

  add_index "followships", ["follower_id", "user_id"], name: "index_friendships_on_inviter_id_and_invited_id", unique: true, using: :btree
  add_index "followships", ["user_id", "follower_id"], name: "index_friendships_on_invited_id_and_inviter_id", unique: true, using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "description",       limit: 65535
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "photos_count",      limit: 4,     default: 0
    t.integer  "impressions_count", limit: 4
  end

  create_table "interesting_urls", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.datetime "checked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body",                       limit: 65535
    t.integer  "sent_messageable_id",        limit: 4
    t.integer  "received_messageable_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "topic",                      limit: 255
    t.boolean  "opened",                                   default: false
    t.string   "ancestry",                   limit: 255
    t.boolean  "recipient_delete",                         default: false
    t.boolean  "sender_delete",                            default: false
    t.boolean  "recipient_permanent_delete",               default: false
    t.boolean  "sender_permanent_delete",                  default: false
    t.string   "received_messageable_type",  limit: 255
    t.string   "sent_messageable_type",      limit: 255
  end

  add_index "messages", ["ancestry"], name: "index_messages_on_ancestry", length: {"ancestry"=>250}, using: :btree
  add_index "messages", ["sent_messageable_id", "received_messageable_id"], name: "acts_as_messageable_ids", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "subject_id",        limit: 4
    t.string   "subject_type",      limit: 255
    t.string   "notification_type", limit: 255
    t.integer  "user_id",           limit: 4
    t.boolean  "read",                          default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.integer  "photogenic_id",      limit: 4
    t.string   "photogenic_type",    limit: 255
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_remote_url",   limit: 255
    t.boolean  "featured"
    t.integer  "position",           limit: 4,   default: 0
    t.string   "photo_fingerprint",  limit: 255
    t.boolean  "avatar",                         default: false
    t.boolean  "is_map",                         default: false
    t.boolean  "cover",                          default: false
    t.integer  "legacy_id",          limit: 4
  end

  add_index "photos", ["photogenic_id", "photogenic_type"], name: "index_photos_on_photogenic_id_and_photogenic_type", using: :btree

  create_table "pois", force: :cascade do |t|
    t.datetime "enabled_at"
    t.datetime "enabled_until"
    t.string   "name",                 limit: 255
    t.string   "contact",              limit: 255
    t.string   "legacy_city",          limit: 255
    t.string   "legacy_country",       limit: 255
    t.string   "phone",                limit: 255
    t.string   "fax",                  limit: 255
    t.string   "email",                limit: 255
    t.string   "http",                 limit: 255
    t.text     "opening_times",        limit: 65535
    t.text     "description",          limit: 65535
    t.text     "log",                  limit: 65535
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "photos_count",         limit: 4,     default: 0
    t.string   "handy",                limit: 255
    t.integer  "user_id",              limit: 4
    t.integer  "customer_id",          limit: 4
    t.integer  "bikes_count",          limit: 4,     default: 0
    t.string   "import_url",           limit: 255
    t.boolean  "bike_manufacturer",                  default: false
    t.float    "latitude",             limit: 24
    t.float    "longitude",            limit: 24
    t.string   "legacy_route",         limit: 255
    t.string   "legacy_street_number", limit: 255
    t.string   "legacy_state",         limit: 255
    t.string   "legacy_state_code",    limit: 255
    t.string   "legacy_postal_code",   limit: 255
    t.string   "legacy_country_code",  limit: 255
    t.integer  "impressions_count",    limit: 4
    t.text     "address",              limit: 65535
  end

  add_index "pois", ["latitude", "longitude"], name: "index_pois_on_latitude_and_longitude", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.text     "body",              limit: 65535
    t.boolean  "highlight",                       default: false
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "answers_count",     limit: 4,     default: 0
    t.text     "body_html",         limit: 65535
    t.integer  "forum_id",          limit: 4
    t.integer  "impressions_count", limit: 4
  end

  create_table "ride_requests", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.datetime "start_at"
    t.string   "driving_style",        limit: 255
    t.boolean  "deleted",                            default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.float    "latitude",             limit: 24
    t.float    "longitude",            limit: 24
    t.string   "legacy_route",         limit: 255
    t.string   "legacy_street_number", limit: 255
    t.string   "legacy_city",          limit: 255
    t.string   "legacy_state",         limit: 255
    t.string   "legacy_state_code",    limit: 255
    t.string   "legacy_postal_code",   limit: 255
    t.string   "legacy_country",       limit: 255
    t.string   "legacy_country_code",  limit: 255
    t.integer  "impressions_count",    limit: 4
    t.text     "address",              limit: 65535
  end

  add_index "ride_requests", ["latitude", "longitude"], name: "index_ride_requests_on_latitude_and_longitude", using: :btree

  create_table "routes", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.integer  "routable_id",          limit: 4
    t.string   "routable_type",        limit: 255
    t.string   "name",                 limit: 255
    t.string   "start_address",        limit: 255
    t.string   "end_address",          limit: 255
    t.integer  "distance",             limit: 4
    t.binary   "waypoints",            limit: 16777215
    t.binary   "static_polyline",      limit: 16777215
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.text     "description",          limit: 65535
    t.integer  "photos_count",         limit: 4,        default: 0
    t.float    "latitude",             limit: 24
    t.float    "longitude",            limit: 24
    t.string   "legacy_route",         limit: 255
    t.string   "legacy_street_number", limit: 255
    t.string   "legacy_city",          limit: 255
    t.string   "legacy_state",         limit: 255
    t.string   "legacy_state_code",    limit: 255
    t.string   "legacy_postal_code",   limit: 255
    t.string   "legacy_country",       limit: 255
    t.string   "legacy_country_code",  limit: 255
    t.integer  "impressions_count",    limit: 4
    t.text     "address",              limit: 65535
  end

  add_index "routes", ["latitude", "longitude"], name: "index_routes_on_latitude_and_longitude", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.string  "name_plural",    limit: 255
    t.boolean "poi_category",               default: false
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "timeline_events", force: :cascade do |t|
    t.string   "event_type",             limit: 255
    t.string   "subject_type",           limit: 255
    t.string   "actor_type",             limit: 255
    t.string   "secondary_subject_type", limit: 255
    t.integer  "subject_id",             limit: 4
    t.integer  "actor_id",               limit: 4
    t.integer  "secondary_subject_id",   limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.float    "latitude",               limit: 24
    t.float    "longitude",              limit: 24
    t.string   "route",                  limit: 255
    t.string   "street_number",          limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "state_code",             limit: 255
    t.string   "postal_code",            limit: 255
    t.string   "country",                limit: 255
    t.string   "country_code",           limit: 255
  end

  add_index "timeline_events", ["actor_id", "actor_type"], name: "index_timeline_events_on_actor_id_and_actor_type", using: :btree
  add_index "timeline_events", ["event_type"], name: "index_timeline_events_on_event_type", using: :btree
  add_index "timeline_events", ["id", "updated_at", "created_at"], name: "date_index", using: :btree
  add_index "timeline_events", ["latitude", "longitude"], name: "index_timeline_events_on_latitude_and_longitude", using: :btree
  add_index "timeline_events", ["secondary_subject_id", "secondary_subject_type"], name: "secondary_index", using: :btree
  add_index "timeline_events", ["subject_id", "subject_type"], name: "index_timeline_events_on_subject_id_and_subject_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                        limit: 255
    t.string   "old_crypted_password",         limit: 40
    t.string   "old_password_salt",            limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_of_birth"
    t.text     "description",                  limit: 65535
    t.string   "http",                         limit: 255
    t.string   "name",                         limit: 255
    t.integer  "distance",                     limit: 4
    t.datetime "licence_date"
    t.boolean  "admin",                                      default: false
    t.integer  "distance_per_year",            limit: 4
    t.text     "driving_description",          limit: 65535
    t.text     "favourite_experience",         limit: 65535
    t.text     "favourite_areas",              limit: 65535
    t.integer  "favorite_amount_of_cylinders", limit: 4
    t.integer  "facebook_id",                  limit: 8
    t.string   "favorite_vendor",              limit: 255
    t.string   "encrypted_password",           limit: 255
    t.string   "password_salt",                limit: 255
    t.string   "legacy_city",                  limit: 255
    t.string   "legacy_country_code",          limit: 255
    t.boolean  "terms_of_service"
    t.integer  "sign_in_count",                limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",           limit: 255
    t.string   "last_sign_in_ip",              limit: 255
    t.datetime "photo_uploaded_at"
    t.string   "reset_password_token",         limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token",           limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",            limit: 255
    t.integer  "failed_attempts",              limit: 4,     default: 0
    t.string   "unlock_token",                 limit: 255
    t.datetime "locked_at"
    t.string   "authentication_token",         limit: 255
    t.integer  "points",                       limit: 4
    t.string   "legacy_country",               limit: 255
    t.datetime "timeline_events_sent_at"
    t.string   "provider",                     limit: 255
    t.string   "oauth_token",                  limit: 255
    t.datetime "oauth_expires_at"
    t.integer  "photos_count",                 limit: 4,     default: 0
    t.float    "latitude",                     limit: 24
    t.float    "longitude",                    limit: 24
    t.string   "legacy_route",                 limit: 255
    t.string   "legacy_street_number",         limit: 255
    t.string   "legacy_state",                 limit: 255
    t.string   "legacy_state_code",            limit: 255
    t.string   "legacy_postal_code",           limit: 255
    t.integer  "impressions_count",            limit: 4
    t.string   "facebook_link",                limit: 255
    t.text     "address",                      limit: 65535
    t.datetime "newsletter_sent_at"
    t.string   "uid",                          limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["latitude", "longitude"], name: "index_users_on_latitude_and_longitude", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "bikes_count", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "unique_id",               limit: 255
    t.string   "youtube_video_id",        limit: 255
    t.text     "youtube_categories",      limit: 65535
    t.string   "title",                   limit: 255
    t.string   "author_name",             limit: 255
    t.string   "author_uri",              limit: 255
    t.text     "description",             limit: 65535
    t.integer  "duration",                limit: 4
    t.integer  "youtube_rating_likes",    limit: 4
    t.integer  "youtube_rating_dislikes", limit: 4
    t.integer  "youtube_rating_count",    limit: 4
    t.float    "youtube_rating_average",  limit: 24
    t.string   "player_url",              limit: 255
    t.integer  "youtube_view_count",      limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "active"
    t.integer  "impressions_count",       limit: 4
  end

  create_table "votes", force: :cascade do |t|
    t.boolean  "vote",                      default: false
    t.integer  "voteable_id",   limit: 4,                   null: false
    t.string   "voteable_type", limit: 255,                 null: false
    t.integer  "voter_id",      limit: 4
    t.string   "voter_type",    limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true, using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

end
