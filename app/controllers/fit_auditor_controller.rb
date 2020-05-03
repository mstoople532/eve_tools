class FitAuditorController < ApplicationController
  def index
  end

  def audit
    result = FitAuditorService.new(
      old_fitting: fitting_params[:old_fitting],
      new_fitting: fitting_params[:new_fitting]
    ).call

    @fit_auditor = FitAuditor.new(
      buy: result[:buy],
      sell: result[:sell],
      keep: result[:keep]
    )
  end

  private

  def fitting_params
    params.permit(:old_fitting, :new_fitting)
  end
end
