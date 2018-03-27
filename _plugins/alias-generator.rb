# see github.com/tsmango/jekyll_alias_generator

module Jekyll

	class PageWithoutAFile < Page
		def read_yaml(*)
			@data ||= {}
		end
	end


	class AliasGenerator < Generator

		def generate(site)
			@site = site

			# process_posts() # not sure if this works properly
			process_pages()
		end

		def process_posts()
			@site.posts.docs.each do |post|
				generate_aliases(post, post.url)
			end
		end

		def process_pages()
			@site.pages.each do |page|
				generate_aliases(page, page.path.gsub(/(\/index)?.html$/, ''))
			end
		end

		def get_template_source_path(file = "alias-template.html")
			File.expand_path file, __dir__
		end

		def get_alias_from_template(dest_path, go_to)
			alias_page = PageWithoutAFile.new(@site, __dir__, "", dest_path)
			alias_page.content = File.read(get_template_source_path)
			alias_page.data['layout'] = nil
			alias_page.data['go_to'] = go_to
			alias_page
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

				file_path = File.join(fs_path_to_dir, alias_file)
				alias_page = get_alias_from_template(file_path, go_to)
				File.open(file_path, 'w') do |file|
					file.write(alias_page)
				end

				@site.pages << alias_page

				alias_sections.size.times do |sections|
					@site.static_files << Jekyll::AliasFile.new(@site, @site.dest, alias_sections[0, sections + 1].join('/'), '')
				end
				@site.static_files << Jekyll::AliasFile.new(@site, @site.dest, alias_dir, alias_file)
			end
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
