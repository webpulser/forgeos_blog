class Paper < ActiveRecord::Base
  include AASM
  acts_as_taggable
  acts_as_commentable
  accepts_nested_attributes_for :comments, :allow_destroy => true
  has_and_belongs_to_many_attachments

  attr_accessor :paper_url

  belongs_to :author, :foreign_key => 'person_id', :class_name => 'Person'
  has_one :meta_info, :as => :target
  accepts_nested_attributes_for :meta_info

  has_and_belongs_to_many :categories, :readonly => true, :join_table => 'categories_elements', :foreign_key => 'element_id', :association_foreign_key => 'category_id', :class_name => 'PaperCategory'

  translates :name, :content, :url, :description

  validates_presence_of :url, :name, :content, :person_id

  has_many :viewed_counters, :as => :element, :class_name => 'PaperViewedCounter'

  aasm_column :state
  aasm_initial_state :draft
  aasm_state :draft
  aasm_state :published

  aasm_event :publish do
    transitions :to => :published, :from => :draft
  end

  aasm_event :throw do
    transitions :to => :draft, :from => :published
  end

  def aasm_current_state_with_event_firing=(state)
    aasm_events_for_current_state.each do |event_name|
      event = self.class.aasm_events[event_name]
      aasm_fire_event(event_name,false) if event && event.all_transitions.any?{ |t| t.to == state || t.to == state.to_sym }
    end
  end

  alias_method :aasm_current_state_with_event_firing, :aasm_current_state

  named_scope :popularity, lambda { {
      :order => "sum(#{PaperViewedCounter.table_name}.counter) DESC, papers.id DESC",
      :include => :viewed_counters,
      :group => "papers.id",
    }
  }

  def self.latest(options = {})
    all(options.merge({:conditions => { :state => 'published' }, :order => 'published_at DESC'}))
  end
  
  def paper_url
    self.translations.collect(&:url)
  end
end
