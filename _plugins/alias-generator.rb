# see github.com/tsmango/jekyll_alias_generator

module Jekyll

	class AliasGenerator < Generator

		def generate(site)
			@site = site

			# process_posts() # not sure if this works properly
			process_pages()
		end

		# def process_posts()
		# 	@site.posts.docs.each do |post|
		# 		generate_aliases(post, post.url)
		# 	end
		# end

		def process_pages()
			@site.pages.each do |page|
				generate_aliases(page, page.url)
			end
		end

		def generate_aliases(page, go_to)
			alias_paths ||= Array.new
			alias_paths << page.data['aliases']
			alias_paths.compact!

			alias_paths.flatten.each do |alias_path|
				alias_path = File.join('/', alias_path.to_s)

				alias_dir  = File.extname(alias_path).empty? ? alias_path : File.dirname(alias_path)
				alias_file = File.extname(alias_path).empty? ? "index.html" : File.basename(alias_path)

				fs_path_to_dir = File.join(@site.dest, alias_dir)
				alias_sections = alias_dir.split('/')[1..-1]

				FileUtils.mkdir_p(fs_path_to_dir)

				File.open(File.join(fs_path_to_dir, alias_file), 'w') do |file|
					file.write(alias_template(@site.config['url'], go_to))
				end

				alias_sections.size.times do |sections|
					@site.static_files << Jekyll::AliasFile.new(@site, @site.dest, alias_sections[0, sections + 1].join('/'), '')
				end
				@site.static_files << Jekyll::AliasFile.new(@site, @site.dest, alias_dir, alias_file)
			end
		end

		def alias_template(site_url, go_to)
<<-EOF
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link rel="canonical" href="#{site_url}#{go_to}">
		<meta http-equiv="refresh" content="0;url=#{site_url}#{go_to}">
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
