json.extract! answer, :id, :message_id, :content, :recipent, :sender, :user_id, :status, :created_at, :updated_at
json.url answer_url(answer, format: :json)