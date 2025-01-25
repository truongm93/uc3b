## stuff to fix
Add private endpoint for all services 
Change webapp from windows to linux
Debug issue adding data source with system assigned identity with openai

## Install Terraform
1. Download Terraform binaries here: https://developer.hashicorp.com/terraform/install
2. Make sure terraform binary is available on your PATH.
    
    1. Go to Control Panel -> System -> System settings -> Environment Variables.
    2. Scroll down in system variables until you find PATH.
    3. Click edit and change accordingly.
    4. BE SURE to include a semicolon at the end of the previous as that is the delimiter, i.e. c:\path;c:\path2
    5. Launch a new console for the settings to take effect.
    6. reference: https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows
3. Open Visual Studio code
4. check if Terraform was successful installed
    1. run command: terraform --version

## Login into your Azure subscription
1. run command az login
2. enter your credentials
3. make sure you are in the right subscription/context
    1. run command az account show
    2. run command az account set -s "subscription_id"


## Run Terraform Code
1. Make sure to be on the diretory where is the code (use cd command to navigate to the correct directory)
2. run command terraform init
3. run command terraform apply -auto-approve
