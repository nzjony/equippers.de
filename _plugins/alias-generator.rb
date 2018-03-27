# see github.com/tsmango/jekyll_alias_generator

module Jekyll

  class AliasGenerator < Generator

    def generate(site)
      @site = site

      process_posts()
      process_pages()
    end

    def process_posts()
      @site.posts.docs.each do |post|
        generate_aliases(post.url, post.data['aliases'])
      end
    end

    def process_pages()
      @site.pages.each do |page|
        generate_aliases(page.destination('').gsub(/index\.(html|htm)$/, ''), page.data['aliases'])
      end
    end

    def generate_aliases(destination_path, aliases)
      alias_paths ||= Array.new
      alias_paths << aliases
      alias_paths.compact!

      alias_paths.flatten.each do |alias_path|
        alias_path = File.join('/', alias_path.to_s)

        alias_dir  = File.extname(alias_path).empty? ? alias_path : File.dirname(alias_path)
        alias_file = File.extname(alias_path).empty? ? "index.html" : File.basename(alias_path)

        fs_path_to_dir = File.join(@site.dest, alias_dir)
        alias_sections = alias_dir.split('/')[1..-1]

        FileUtils.mkdir_p(fs_path_to_dir)

        File.open(File.join(fs_path_to_dir, alias_file), 'w') do |file|
          file.write(alias_template(destination_path))
        end

        alias_sections.size.times do |sections|
          @site.static_files << Jekyll::AliasFile.new(@site, @site.dest, alias_sections[0, sections + 1].join('/'), '')
        end
        @site.static_files << Jekyll::AliasFile.new(@site, @site.dest, alias_dir, alias_file)
      end
    end

    def alias_template(destination_path)
      <<-EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <link rel="canonical" href="#{destination_path}">
  <meta http-equiv="refresh" content="0;url=#{destination_path}">
</head>
</html>
EOF
    end
  end

  class AliasFile < StaticFile
    require 'set'

    def modified?
      return false
    end

    def write(dest)
      return true
    end
  end
end
