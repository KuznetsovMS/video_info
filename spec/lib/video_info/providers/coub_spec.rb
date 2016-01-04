# encoding: UTF-8
require 'spec_helper'

describe VideoInfo::Providers::Coub do

  describe ".usable?" do
    subject { VideoInfo::Providers::Coub.usable?(url) }

    context "with coub url" do
      let(:url) { 'http://coub.com/view/5u5n1' }
      it { should be_truthy }
    end

    context "with other url" do
      let(:url) { 'http://www.youtube.com/898029' }
      it { should be_falsey }
    end

    context "with spaces at end" do
      let(:url) { 'http://coub.com/view/5u5n1        ' }
      it { should be_truthy }
    end

    context "with spaces at start" do
      let(:url) { '      http://coub.com/view/5u5n1' }
      it { should be_truthy }
    end

    context "with spaces around url" do
      let(:url) { '      http://coub.com/view/5u5n1      ' }
      it { should be_truthy }
    end
    
    context "url without http/https" do
      let(:url) { 'coub.com/view/5u5n1' }
      it { should be_truthy }
    end

  end

  context "with video http://coub.com/view/57uv0", :vcr do
    subject { VideoInfo.new('http://coub.com/view/57uv0') }

    its(:provider)         { should eq 'Coub' }
    its(:author)           { should eq 'ThisMoments' }
    its(:video_id)         { should eq '57uv0' }
    its(:title)            { should eq 'GoPro: Majestic Wingsuit Fling in Switzerland (HD)' }
    its(:keywords)         { should eq 'gopro, hero 2, hero 3, hero 3 plus, hero 4, hero camera, hd camera, stoked, rad, switzerland, wingsuit, wingsuit flying' }
    its(:embed_url)        { should eq '//coub.com/embed/57uv0' }
    its(:embed_code)       { should eq '<iframe src="//coub.com/embed/57uv0?autoplay=true&muted=false" frameborder="0"></iframe>' }
    its(:thumbnail_small)  { should eq 'https://coubsecure-a.akamaihd.net/get/b50/p/coub/simple/cw_image/ee37e99a404/dfb0d7d749343dc38c403/micro_1425133311_00032.jpg' }
    its(:thumbnail_medium) { should eq 'https://coubsecure-a.akamaihd.net/get/b50/p/coub/simple/cw_image/ee37e99a404/dfb0d7d749343dc38c403/tiny_1425133311_00032.jpg' }
    its(:thumbnail_large)  { should eq 'https://coubsecure-a.akamaihd.net/get/b50/p/coub/simple/cw_image/ee37e99a404/dfb0d7d749343dc38c403/small_1425133311_00032.jpg' }
    its(:date)             { should eq '28.02.2015' }
    its(:duration)         { should eq 10 }
    its(:view_count)       { should be > 24373 }
  end

end
