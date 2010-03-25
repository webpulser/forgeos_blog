class Post < ActiveRecord::Base
  include AASM
  acts_as_taggable
  acts_as_commentable
  accepts_nested_attributes_for :comments, :allow_destroy => true
  has_and_belongs_to_many_attachments

  belongs_to :person
  has_one :meta_info, :as => :target
  accepts_nested_attributes_for :meta_info

  translates :name, :content, :url

  validates_presence_of :url, :name, :content

  aasm_column :state
  aasm_initial_state :draft
  aasm_state :draft
  aasm_state :published

  aasm_event :publish do
    transitions :to => :draft, :from => :published
  end

  aasm_event :throw do
    transitions :to => :published, :from => :draft
  end

  def aasm_current_state_with_event_firing=(state)
    aasm_events_for_current_state.each do |event_name|
      event = self.class.aasm_events[event_name]
      aasm_fire_event(event_name,false) if event && event.all_transitions.any?{ |t| t.to == state || t.to == state.to_sym }
    end
  end
  
  alias_method :aasm_current_state_with_event_firing, :aasm_current_state
end
