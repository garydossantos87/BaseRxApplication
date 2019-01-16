<!--
#==========================================================
#================= STEPS TO UPLOAD CHANGES ================
#==========================================================

# 1.- Increase BaseRxApplication.podspec version (copy the version number to add a tag with that number)
# 2.- Do a commit and a push with all the CHANGES
# 3.- Create a tag with the format "vXXXX" where XXXX is the version of the .podspec that yout copy in the step 1
# 4.- Open the terminal and go to the folder of the BaseRxApplication project
# 5.- Put this code pod repo push gitlab-specs BaseRxApplication.podspec --sources='https://github.com/garydossantos87/BaseRxApplication.git,https://github.com/CocoaPods/Specs.git' --allow-warnings
# 6.- If everything is ok the version will increase with your changes , otherwise you need to check
# 7.- Delete the .pods and the Podfile.lock of the project where you want to get the last version of the BaseRxApplication, then 'pod repo update' and pod install
# 8.- Have FUN :)

-->


Cuando se suba version hace falta lanzar lo siguiente para ponerlo en el specs (es posible que se tenga que cambiar el "Specs" por el repo que tengais en vuestro mac mediante el comando pod repo list):

pod repo push Specs BaseRxApplication.podspec --sources='https://github.com/garydossantos87/BaseRxApplication.git,https://github.com/CocoaPods/Specs.git' --allow-warnings

Si da algun error de validación probar la siguiente instrucción:

pod repo push gitlab-specs BaseRxApplication.podspec --sources='https://github.com/garydossantos87/BaseRxApplication.git,https://github.com/CocoaPods/Specs.git' --allow-warnings
