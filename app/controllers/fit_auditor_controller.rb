class FitAuditorController < ApplicationController
  def index
  end

  def audit
    result = FitAuditor.new(
      old_fitting: fitting_params[:old_fitting],
      new_fitting: fitting_params[:new_fitting]
    ).call

    result.to_json
  end

  private

  def fitting_params
    params.permit(:old_fitting, :new_fitting)
  end
end
