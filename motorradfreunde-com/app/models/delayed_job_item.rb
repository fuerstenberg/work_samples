class DelayedJobItem

  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: 'delayed_jobs'

  field :attempts,   type: Integer
  field :failed_at,  type: DateTime
  field :handler,    type: String
  field :last_error, type: String
  field :locked_at,  type: DateTime
  field :locked_by,  type: String
  field :priority,   type: Integer
  field :queue,      type: String
  field :run_at,     type: DateTime

end
