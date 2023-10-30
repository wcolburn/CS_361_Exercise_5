# Exercise 5

class DiscussionWorkflow

  def initialize(discussion, host, participants_email_string)
    @discussion = discussion
    @host = host
    @participants = add_participants_from_email(participants_email_string)
  end

  def add_participants_from_email(participants_email_string)
    return if participants_email_string.blank?
    participants_email_string.split.uniq.map do |email_address|
      @participants << Users.get(email_address)
    end
  end

  # Expects @participants array to be filled with User objects
  def LaunchDiscussionWorkflow
    return unless valid?
    run_callbacks(:create) do
      ActiveRecord::Base.transaction do
        discussion.save!
        create_discussion_roles!
        @successful = true
      end
    end
  end

  # ...

end


discussion = Discussion.new(title: "fake", ...)
host = User.find(42)
participants = "fake1@example.com\nfake2@example.com\nfake3@example.com"

workflow = DiscussionWorkflow.new(discussion, host, participants)
workflow.LaunchDiscussionWorkflow