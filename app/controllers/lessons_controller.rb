class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_for_current_section, only: :show

  def show
  end

  private

  def update
    current_lesson.update_attributes(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_enrollment_for_current_section
    current_course = current_lesson.section.course
    if current_user.enrolled_in?(current_course) != true
      redirect_to course_path(current_course), alert: 'You have been enrolled to see the lesson!'
    end 
  end

end
