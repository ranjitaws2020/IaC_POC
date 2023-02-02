def call()
{
                    try {
                        echo "Stopping App Pool"
                        bat "%systemroot%\\system32\\inetsrv\\appcmd stop apppool /apppool.name:DefaultAppPool"
                    }
                    catch (Exception err) {
                        echo err.getMessage()
                    }
                    
                    echo "Cleaning the app folder"
                    bat "del \"C:\\inetpub\\wwwroot\\UploadDowFilesJenkinsPipeline\\**\" /S /Q"
                    
                    echo "Copying the published files to the app folder"
                    bat "xcopy \"C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\DotNetAPI-CICD\\DotNetAPI_CI\\bin\\publish\\**\" \"C:/inetpub/wwwroot/UploadDowFilesJenkinsPipeline\" /E /Q"
                    
                    echo "Starting App Pool"
                    bat "%systemroot%\\system32\\inetsrv\\appcmd start apppool /apppool.name:DefaultAppPool"
}
