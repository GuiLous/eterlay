Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.paths << Rails.root.join("app/assets/images")
Rails.application.config.assets.precompile += %w[ *.png *.jpg *.jpeg *.gif ]
