class VideoInfo
  module Providers
    class Coub < Provider

      def self.usable?(url)
        url =~ /(coub\.com\/view.*)/
      end

      def provider
        'Coub'
      end

      def api_key
        VideoInfo.provider_api_keys[:coub]
      end

      def _set_video_id_from_url
        @video_id = url.split('/')[-1]
      end

      def title
        data['title']
      end

      def author
        data['channel']['title']
      end

      def duration
        data['duration']
      end

      %w[description width height].each do |method|
        define_method(method) { nil }
      end

      # micro — 70x46 pixels;
      # tiny — 112x85 pixels;
      # age_restrcited — 640x640 pixels; this image have the restriction sign;
      # ios_large — 600x525 pixels; intended to be dispayed on iOS devices;
      # big — 1280x1280 pixels;
      # med — 640x500 pixels;
      # small — 400x400 pixels;
      # pinterest — 600x600 pixels; intended to be dispayed in pinterest web site;
      def thumbnail(size)
        image_versions = data['image_versions']
        image_versions['template'].gsub('%{version}', size)
      end

      def thumbnail_small
        thumbnail('micro')
      end

      def thumbnail_medium
        thumbnail('tiny')
      end

      def thumbnail_large
        thumbnail('small')
      end

      def keywords
        keywords_array.join(', ')
      end

      def keywords_array
        data['tags'].map { |t| t['title'] }
      end

      def embed_url
        "//coub.com/embed/#{video_id}"
      end

      def date
        Date.parse(data['published_at']).strftime("%d.%m.%Y")
      end

      def view_count
        data['views_count']
      end

      private

      def _api_base
        'coub.com'
      end

      def _api_path
        "/api/v2/coubs/#{video_id}.json"
      end

      def _api_url
        "https://#{_api_base}#{_api_path}"
      end

      def _default_iframe_attributes
        {}
      end

      def _default_url_attributes
        {
          autoplay: true,
          muted: false
        }
      end

    end
  end
end
