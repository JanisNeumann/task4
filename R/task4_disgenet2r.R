library(disgenet2r)

# Get API key
disgenet_api_key <- get_disgenet_api_key(
  email = disgenet2_email, 
  password = disgenet2_password)

# Set environment to use API key
Sys.setenv(DISGENET_API_KEY= disgenet_api_key)