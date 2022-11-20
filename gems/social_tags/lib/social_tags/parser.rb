require "nokogiri"

module SocialTags
  class Parser
    def initialize(html:)
      @html = html
    end

    def parse
      doc = Nokogiri.HTML5(@html)
      metas = doc.css("meta")
      ogs = metas.css("[property^='og:']")
      tws = metas.css("[property^='twitter:']")
      {
        ogs: extract(ogs),
        tws: extract(tws)
      }
    end

    private

    def extract(nodes)
      nodes.map do |node|
        {
          node.attribute("property").to_s => node.attribute("content").to_s
        }
      end.reduce(:merge).to_h
    end

  end
end
