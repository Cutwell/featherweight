require "jekyll"
require "nokogiri"
require "fastimage"

module Jekyll
    class AntiImageReflow
        def self.process(content)
            html = content.output
            content.output = process_tags(html) if process_tags?(html)
        end

        def self.process?(doc)
            (doc.is_a?(Jekyll::Page) || doc.write?) && doc.output_ext == ".html" || doc.permalink&.end_with?("/")
        end

        def self.process_tags?(html)
            html.include?("<img") || html.include?("<iframe")
        end

        def self.process_tags(html)
            content = Nokogiri.HTML(html)
            tags = content.css("img[src]")

            tags.each do |tag|
                # add height and width attributes
                if tag.name == "img"
                    size = FastImage.size(tag["src"])
                    tag["width"] = size[0] unless tag["width"] || size.nil?
                    tag["height"] = size[1] unless tag["height"] || size.nil?
                    tag["loading"] = "lazy" unless tag["loading"]
                end
            end

            content.to_html
        end

        private_class_method :process_tags
        private_class_method :process_tags?
    end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
    Jekyll::AntiImageReflow.process(doc) if Jekyll::AntiImageReflow.process?(doc)
end