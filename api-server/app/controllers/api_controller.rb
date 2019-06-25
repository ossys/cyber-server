class ApiController < ApplicationController
  def test
    render :json => {:data => 'test'}
  end

  def enroll
  end

  def config
  end

  def dist_read
  end

  def dist_write
  end
end
