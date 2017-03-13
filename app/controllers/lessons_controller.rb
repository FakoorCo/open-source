class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: :show

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_section
    current_course = current_lesson.section.course
    if current_user.enrolled_in?(current_course) != true
      if current_lesson.section.course.user != current_user
        redirect_to course_path(current_course), alert: 'Unauthorized'
      end
    end
  end

end
