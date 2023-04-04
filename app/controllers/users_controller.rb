require 'byebug'

class UsersController < ApplicationController
  # include ActiveStorage::SetBlob, ActiveStorage::Streaming

  def profile_pic
    @user = User.find(params[:id])

    image = @user.profile_pic
    response.headers["Content-Type"] = image.content_type
    response.headers["Content-Disposition"] = "inline"

    image.download do |chunk|
      response.stream.write(chunk)
    end
  end

  def profile_pic_thumb
    @user = User.find(params[:id])

    image_thumb = @user.profile_pic.variant(:thumb)
    response.headers["Content-Type"] = image_thumb.blob.content_type
    response.headers["Content-Disposition"] = "inline"

    image_thumb.download do |chunk|
      response.stream.write(chunk)
    end
  end

  def profile_intro
    @user = User.find(params[:id])

    intro = @user.profile_intro
    response.headers["Content-Type"] = intro.content_type
    response.headers["Content-Disposition"] = "inline"

    intro.download do |chunk|
      # sleep 0.1
      response.stream.write(chunk)
    end
  end

  # signed_id=eyjfcmfpbhmionsibwvzc2fnzsi6ikjbahbcdz09iiwizxhwijpudwxslcjwdxiioijibg9ix2lkin19--a064a9fc2474ec908f637b2b627c443d13bfca7e
  # def profile_intro #Todo: make this work
  #   @user = User.find(params[:id])
  #
  #   @video = @user.profile_intro
  #   http_cache_forever(public: true) do
  #     send_blob_stream @video, disposition: params[:disposition]
  #   end
  # end

  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
