json.extract! comment, :id, :comment, :upvotes, :downvotes, :created_at, :updated_at
json.url comment_url(comment, format: :json)
