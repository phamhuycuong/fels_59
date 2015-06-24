class Word < ActiveRecord::Base

  belongs_to :category

  has_many :lessons, through: :lesson_words
  has_many :lesson_words, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc {|attributes| attributes["content"].blank?}

  validates :content, presence: true, uniqueness: true

  scope :learned, ->user{where(Settings.word.user_learned % {idx: user.id})}

  scope :unlearned, ->user{where(Settings.word.user_unlearned % {idx: user.id})}

  scope :passed, ->user{where(Settings.word.user_passed % {idx: user.id})}

  scope :lesson_passed, ->lesson{where(Settings.word.lesson_passed % {lesson_id: lesson.id})}

  scope :random_words, ->user{Word.unlearned(user).order("random()").limit(Settings.lesson_max_word)}

  scope :get_all, ->user{}

  scope :filter_category, ->category_id{where category_id: category_id if category_id.present?}

  scope :filter_content, ->content{where Settings.word.filter_content % {content: content, chr37: "%"} if content.present?}

  scope :order_by_alphabet, ->{order content: :ASC}
end
