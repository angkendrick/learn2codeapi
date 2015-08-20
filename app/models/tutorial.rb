class Tutorial < ActiveRecord::Base

  belongs_to :user
  has_many :tutorial_subjects
  has_many :subjects, through: :tutorial_subjects
  has_many :reviews
  has_many :likes

  accepts_nested_attributes_for :tutorial_subjects, reject_if: proc { |attributes| attributes['subject_id'].blank? }

  mount_uploader :tutorialimage, TutorialimageUploader

end
